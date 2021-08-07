/*
Processes -> Schedules.
Создаем три зачади:
1. ежедневно в 06.00 отработает системная задача git на все конфиги резервных копий.
2. ежедневно в 04.00 отработает системная задача backup, в которой настроены хосты из раздела Processes -> Task assignments
3. раз в месяц 1 числа в 06.00 отработает системная задача discovery, в которой настроены сети из раздела Inventory -> Subnets (Networks), при условии активного статуса Discoverable
*/
INSERT INTO
    cbackup.schedule (id, task_name, schedule_cron)
VALUES
    (1, 'git_commit', '0 6 * * *');
INSERT INTO
    cbackup.schedule (id, task_name, schedule_cron)
VALUES
    (2, 'backup', '0 4 * * *');
INSERT INTO
    cbackup.schedule (id, task_name, schedule_cron)
VALUES
    (3, 'discovery', '0 6 1 * *');

/*
Inventory -> Device auth templates
Создаем шаблоны аутентификации по ssh для mikrotik, по telnet для D-Link
*/
INSERT INTO
    cbackup.device_auth_template (name, auth_sequence, description)
VALUES
    ('ssh', '>', NULL);
INSERT INTO
    cbackup.device_auth_template (name, auth_sequence, description)
VALUES
    ('telnet-d-link', 'ame:\r\n{{telnet_login}}\r\nord:\r\n{{telnet_password}}\r\n#', NULL);

/*
Inventory -> Credentials
Создаем учетные данные для доступа к сетевому оборудованию по протоколам ssh, telnet, snmp
*/
INSERT INTO
    cbackup.credential (id, name, telnet_login, telnet_password, ssh_login, ssh_password, snmp_read, snmp_set, snmp_version, snmp_encryption, enable_password, port_telnet, port_ssh, port_snmp)
VALUES
    (1, 'Credentials1', 'admin', 'password', 'admin', 'password', 'public', 'public', 1, NULL, 'cbackup_password', 23, 22, 161);

/*
Inventory -> Subnets (Networks)
Создаем сети для поиска сетевого оборудования
*/
INSERT INTO
    cbackup.network (id, credential_id, network, discoverable, description)
VALUES
    (1, 1, '192.168.1.0/24', 0, NULL);
INSERT INTO
    cbackup.network (id, credential_id, network, discoverable, description)
VALUES
    (2, 1, '10.90.90.0/24', 0, NULL);

/*
Inventory -> Devices
Создаем модели железок и привязываем к определенному шаблону аутентификации
*/
INSERT INTO
    cbackup.device (id, vendor, model, auth_template_name)
VALUES
    (1, 'Mikrotik', 'RB 750', 'ssh');
INSERT INTO
    cbackup.device (id, vendor, model, auth_template_name)
VALUES
    (2, 'Dlink', 'DGS-1210-28/ME B1', 'telnet-d-link');

/*
Processes -> Workers & Jobs
Создаем правила "как" и какими командами будет делатся копия
*/
/*
для Mikrotik
*/
INSERT INTO
    cbackup.worker (id, name, task_name, `get`, description)
VALUES
    (1, 'backup-mikrotik', 'backup', 'ssh', NULL);
INSERT INTO
    cbackup.job (id, name, worker_id, sequence_id, command_value, command_var, cli_custom_prompt, snmp_request_type, snmp_set_value, snmp_set_value_type, timeout, table_field, enabled, description)
VALUES
    (1, 'exportcompact', 1, 1, '/export compact', NULL, NULL, 'get', NULL, NULL, 60000, 'config', 1, NULL);

/*
для D-link DGS-1210/ME
*/
INSERT INTO
    cbackup.worker (id, name, task_name, `get`, description)
VALUES
    (2, 'backup-DGS-1210-ME', 'backup', 'telnet', NULL);
INSERT INTO
    cbackup.job (id, name, worker_id, sequence_id, command_value, command_var, cli_custom_prompt, snmp_request_type, snmp_set_value, snmp_set_value_type, timeout, table_field, enabled, description)
VALUES
    (2, 'disableclipaging', 2, 1, 'disable clipaging', NULL, NULL, 'get', NULL, NULL, 1000, NULL, 1, NULL);
INSERT INTO
    cbackup.job (id, name, worker_id, sequence_id, command_value, command_var, cli_custom_prompt, snmp_request_type, snmp_set_value, snmp_set_value_type, timeout, table_field, enabled, description)
VALUES
    (3, 'show config', 2, 2, 'show config modified', NULL, NULL, 'get', NULL, NULL, 60000, 'config', 1, NULL);
INSERT INTO
    cbackup.job (id, name, worker_id, sequence_id, command_value, command_var, cli_custom_prompt, snmp_request_type, snmp_set_value, snmp_set_value_type, timeout, table_field, enabled, description)
VALUES
    (4, 'enableclipaging', 2, 3, 'enable clipaging', NULL, NULL, 'get', NULL, NULL, 1000, NULL, 1, NULL);
INSERT INTO
    cbackup.job (id, name, worker_id, sequence_id, command_value, command_var, cli_custom_prompt, snmp_request_type, snmp_set_value, snmp_set_value_type, timeout, table_field, enabled, description)
VALUES
    (5, 'logout', 2, 4, 'logout', NULL, NULL, 'get', NULL, NULL, 1000, NULL, 1, NULL);

/*
Nodes -> Add manually (Node)
Создаем конкретное сетевое оборудования, привязываем параметры созданые в разделах Inventory -> Credentials, Inventory -> Subnets (Networks), Inventory -> Devices
*/
INSERT INTO
    cbackup.node (id, ip, network_id, credential_id, device_id, auth_template_name, mac, created, modified, last_seen, manual, hostname, serial, prepend_location, location, contact, sys_description, protected)
VALUES
    (1, '192.168.1.8', 1, 1, 1, NULL, NULL, '2019-09-27 12:47:28.000', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0);

/*
Processes -> Task assignments
ГЛАВНОЕ: Создаем привязку сетевого устройства, правила, и список команд
*/
INSERT INTO
    cbackup.tasks_has_nodes (id, node_id, task_name, worker_id)
VALUES
    (1, 1, 'backup', 1);