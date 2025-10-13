#!/usr/bin/env python3

import subprocess
import platform

vms = [
    "companyrouter",
    "dns",
    "web",
    "database",
    "employee",
    "homerouter",
    "remote-employee",
    "red"
]

if platform.system() == "Windows":
    vboxmanage_cmd = r"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
else:
    vboxmanage_cmd = "VBoxManage"

for vm in vms:
    print(f"Enabling NAT for {vm}")
    try:
        subprocess.run(
            [vboxmanage_cmd, "controlvm", vm, "setlinkstate1", "on"], check=True
        )
    except subprocess.CalledProcessError as e:
        print(f"Error enabling NAT for {vm}: {e}")