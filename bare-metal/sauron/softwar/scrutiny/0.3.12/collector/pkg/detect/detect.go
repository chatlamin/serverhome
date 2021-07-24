package detect

import (
	"encoding/json"
	"fmt"
	"github.com/analogj/scrutiny/collector/pkg/common"
	"github.com/analogj/scrutiny/collector/pkg/config"
	"github.com/analogj/scrutiny/collector/pkg/models"
	"github.com/analogj/scrutiny/webapp/backend/pkg/models/collector"
	"github.com/sirupsen/logrus"
	"os"
	"strings"
)

type Detect struct {
	Logger *logrus.Entry
	Config config.Interface
}

//private/common functions

// This function calls smartctl --scan which can be used to detect storage devices.
// It has a couple of issues however:
// - --scan does not return any results on mac
//
// To handle these issues, we have OS specific wrapper functions that update/modify these detected devices.
// models.Device returned from this function only contain the minimum data for smartctl to execute: device type and device name (device file).
func (d *Detect) SmartctlScan() ([]models.Device, error) {
	//we use smartctl to detect all the drives available.
	detectedDeviceConnJson, err := common.ExecCmd(d.Logger, "smartctl", []string{"--scan", "-j"}, "", os.Environ())
	if err != nil {
		d.Logger.Errorf("Error scanning for devices: %v", err)
		return nil, err
	}

	var detectedDeviceConns models.Scan
	err = json.Unmarshal([]byte(detectedDeviceConnJson), &detectedDeviceConns)
	if err != nil {
		d.Logger.Errorf("Error decoding detected devices: %v", err)
		return nil, err
	}

	detectedDevices := d.TransformDetectedDevices(detectedDeviceConns)

	return detectedDevices, nil
}

//updates a device model with information from smartctl --scan
// It has a couple of issues however:
// - WWN is provided as component data, rather than a "string". We'll have to generate the WWN value ourselves
// - WWN from smartctl only provided for ATA protocol drives, NVMe and SCSI drives do not include WWN.
func (d *Detect) SmartCtlInfo(device *models.Device) error {

	args := []string{"--info", "-j"}
	//only include the device type if its a non-standard one. In some cases ata drives are detected as scsi in docker, and metadata is lost.
	if len(device.DeviceType) > 0 && device.DeviceType != "scsi" && device.DeviceType != "ata" {
		args = append(args, "-d", device.DeviceType)
	}
	args = append(args, fmt.Sprintf("%s%s", DevicePrefix(), device.DeviceName))

	availableDeviceInfoJson, err := common.ExecCmd(d.Logger, "smartctl", args, "", os.Environ())
	if err != nil {
		d.Logger.Errorf("Could not retrieve device information for %s: %v", device.DeviceName, err)
		return err
	}

	var availableDeviceInfo collector.SmartInfo
	err = json.Unmarshal([]byte(availableDeviceInfoJson), &availableDeviceInfo)
	if err != nil {
		d.Logger.Errorf("Could not decode device information for %s: %v", device.DeviceName, err)
		return err
	}

	//WWN: this is a serial number/world-wide number that will not change.
	//DeviceType and DeviceName are already populated, however may change between collector runs (eg. config/host restart)
	//InterfaceType:
	device.ModelName = availableDeviceInfo.ModelName
	device.InterfaceSpeed = availableDeviceInfo.InterfaceSpeed.Current.String
	device.SerialNumber = availableDeviceInfo.SerialNumber
	device.Firmware = availableDeviceInfo.FirmwareVersion
	device.RotationSpeed = availableDeviceInfo.RotationRate
	device.Capacity = availableDeviceInfo.UserCapacity.Bytes
	device.FormFactor = availableDeviceInfo.FormFactor.Name
	device.DeviceProtocol = availableDeviceInfo.Device.Protocol
	if len(availableDeviceInfo.Vendor) > 0 {
		device.Manufacturer = availableDeviceInfo.Vendor
	}

	//populate WWN is possible if present
	if availableDeviceInfo.Wwn.Naa != 0 { //valid values are 1-6 (5 is what we handle correctly)
		d.Logger.Info("Generating WWN")
		wwn := Wwn{
			Naa: availableDeviceInfo.Wwn.Naa,
			Oui: availableDeviceInfo.Wwn.Oui,
			Id:  availableDeviceInfo.Wwn.ID,
		}
		device.WWN = strings.ToLower(wwn.ToString())
		d.Logger.Debugf("NAA: %d OUI: %d Id: %d => WWN: %s", wwn.Naa, wwn.Oui, wwn.Id, device.WWN)
	} else {
		d.Logger.Info("Using WWN Fallback")
		d.wwnFallback(device)
	}

	return nil
}

// function will remove devices that are marked for "ignore" in config file
// will also add devices that are specified in config file, but "missing" from smartctl --scan
// this function will also update the deviceType to the option specified in config.
func (d *Detect) TransformDetectedDevices(detectedDeviceConns models.Scan) []models.Device {
	groupedDevices := map[string][]models.Device{}

	for _, scannedDevice := range detectedDeviceConns.Devices {

		deviceFile := strings.ToLower(scannedDevice.Name)

		detectedDevice := models.Device{
			HostId:     d.Config.GetString("host.id"),
			DeviceType: scannedDevice.Type,
			DeviceName: strings.TrimPrefix(deviceFile, DevicePrefix()),
		}

		//find (or create) a slice to contain the devices in this group
		if groupedDevices[deviceFile] == nil {
			groupedDevices[deviceFile] = []models.Device{}
		}

		// add this scanned device to the group
		groupedDevices[deviceFile] = append(groupedDevices[deviceFile], detectedDevice)
	}

	//now tha we've "grouped" all the devices, lets override any groups specified in the config file.

	for _, overrideDevice := range d.Config.GetScanOverrides() {
		overrideDeviceFile := strings.ToLower(overrideDevice.Device)

		if overrideDevice.Ignore {
			// this device file should be deleted if it exists
			delete(groupedDevices, overrideDeviceFile)
		} else {
			//create a new device group, and replace the one generated by smartctl --scan
			overrideDeviceGroup := []models.Device{}

			for _, overrideDeviceType := range overrideDevice.DeviceType {
				overrideDeviceGroup = append(overrideDeviceGroup, models.Device{
					HostId:     d.Config.GetString("host.id"),
					DeviceType: overrideDeviceType,
					DeviceName: strings.TrimPrefix(overrideDeviceFile, DevicePrefix()),
				})
			}

			groupedDevices[overrideDeviceFile] = overrideDeviceGroup
		}
	}

	//flatten map
	detectedDevices := []models.Device{}
	for _, group := range groupedDevices {
		detectedDevices = append(detectedDevices, group...)
	}

	return detectedDevices
}
