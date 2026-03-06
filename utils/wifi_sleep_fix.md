## Fix for Wifi Issue in IdeadPad Pro 5

```
cat /sys/bus/pci/devices/0000:01:00.0/d3cold_allowed
```
* if it returned 1, meaning this EFI setting was not honored, and suspend would (apparently) initiate or attempt a cold sleep
* Wifi card could be on a different PCI path, so adapt accordingly.

* Try suspend after disabling it manually
```
echo 0 > /sys/bus/pci/devices/0000:01:00.0/d3cold_allowed
```

* If the above script resolved the issue. Create a systemd service to disable it every time.
* Create a file: /etc/systemd/system/disable-wifi-d3cold.service
```
[Unit]
Description=Disable D3cold for Intel BE200 WiFi
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/bin/bash -c "echo 0 > /sys/bus/pci/devices/0000:01:00.0/d3cold_allowed"

[Install]
WantedBy=multi-user.target
```
* Enable the service to run automatically
```
systemctl enable disable-wifi-d3cold.service
```
* Check the status of the service
```
systemctl status disable-wifi-d3cold.service
```

### Resources

1. https://community.intel.com/t5/Wireless/Intel-WiFi-7-BE200-loses-connection-after-suspend-resume-on/m-p/1693034
