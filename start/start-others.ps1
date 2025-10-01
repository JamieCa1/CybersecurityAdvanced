# Define the other VM names from your Vagrantfile
$vms = "dns", "web", "database", "employee", "remote-employee"

# Define the VirtualBox program path
# You might need to adjust this path if VirtualBox is not installed in the default location.
$vboxManage = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

$action = $args[0]

switch ($action) {
    "start" {
        Write-Host "Starting other VMs..."
        foreach ($vm in $vms) {
            & $vboxManage startvm "$vm" --type headless
        }
    }
    "stop" {
        Write-Host "Stopping other VMs..."
        foreach ($vm in $vms) {
            & $vboxManage controlvm "$vm" acpipowerbutton
        }
    }
    default {
        Write-Host "Usage: .\start\start-others.ps1 {start|stop}"
        exit 1
    }
}