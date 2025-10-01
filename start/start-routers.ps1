# Define the router VM names from your Vagrantfile
$routers = "isprouter", "companyrouter", "homerouter"

# Define the VirtualBox program path
# You might need to adjust this path if VirtualBox is not installed in the default location.
$vboxManage = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

$action = $args[0]

switch ($action) {
    "start" {
        Write-Host "Starting all router VMs..."
        foreach ($vm in $routers) {
            & $vboxManage startvm "$vm" --type headless
        }
    }
    "stop" {
        Write-Host "Stopping all router VMs..."
        foreach ($vm in $routers) {
            & $vboxManage controlvm "$vm" acpipowerbutton
        }
    }
    default {
        Write-Host "Usage: .\start\start-routers.ps1 {start|stop}"
        exit 1
    }
}