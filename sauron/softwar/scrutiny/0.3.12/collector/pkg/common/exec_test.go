package common_test

import (
	"github.com/analogj/scrutiny/collector/pkg/common"
	"github.com/sirupsen/logrus"
	"github.com/stretchr/testify/require"
	"os/exec"
	"testing"
)

func TestExecCmd(t *testing.T) {
	t.Parallel()

	//setup

	//test
	result, err := common.ExecCmd(logrus.WithField("exec", "test"), "echo", []string{"hello world"}, "", nil)

	//assert
	require.NoError(t, err)
	require.Equal(t, "hello world\n", result)
}

func TestExecCmd_Date(t *testing.T) {
	t.Parallel()

	//setup

	//test
	_, err := common.ExecCmd(logrus.WithField("exec", "test"), "date", []string{}, "", nil)

	//assert
	require.NoError(t, err)
}

//
//func TestExecCmd_Error(t *testing.T) {
//	t.Parallel()
//
//	//setup
//	bc := collector.BaseCollector {}
//
//	//test
//	_, err := bc.ExecCmd("smartctl", []string{"-a", "/dev/doesnotexist"}, "", nil)
//
//	//assert
//	exitError, castOk := err.(*exec.ExitError);
//	require.True(t, castOk)
//	require.Equal(t, 1, exitError.ExitCode())
//
//}
//

func TestExecCmd_InvalidCommand(t *testing.T) {
	t.Parallel()

	//setup

	//test
	_, err := common.ExecCmd(logrus.WithField("exec", "test"), "invalid_binary", []string{}, "", nil)

	//assert
	_, castOk := err.(*exec.ExitError)
	require.False(t, castOk)
}
