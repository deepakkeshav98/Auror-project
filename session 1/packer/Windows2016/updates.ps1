Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
Install-PackageProvider -Name NuGet -Force
Import-PackageProvider -Name NuGet

# Update the PSGallery (the Default) PSRepository
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Get-PSRepository -Name PSGallery | Format-List * -Force

# List all modules installed
Write-Output "Running:  Get-InstalledModule"
Get-InstalledModule

# Install the module we need
Write-Output "Running:  Install-Module -Name PSWindowsUpdate -Force"
Install-Module -Name PSWindowsUpdate -Force

# Import the module
Import-Module -Name PSWindowsUpdate

# List support commands from the module:
Get-Command -Module PSWindowsUpdate

# Now, check if the Microsoft Update service is available.
# If not, we need to add it.
$MicrosoftUpdateServiceId = "7971f918-a847-4430-9279-4a52d1efe18d"
If ((Get-WUServiceManager -ServiceID $MicrosoftUpdateServiceId).ServiceID -eq $MicrosoftUpdateServiceId) { Write-Output "Confirmed that Microsoft Update Service is registered..." }
Else { Add-WUServiceManager -ServiceID $MicrosoftUpdateServiceId -Confirm:$true }
# Now, check again to ensure it is available.  If not -- fail the script:
If (!((Get-WUServiceManager -ServiceID $MicrosoftUpdateServiceId).ServiceID -eq $MicrosoftUpdateServiceId)) { Throw "ERROR:  Microsoft Update Service is not registered." }

# Force the installation of updates and reboot of server (if required)
Get-WUInstall -MicrosoftUpdate -AcceptAll -AutoReboot
Get-WUInstall -MicrosoftUpdate -AcceptAll -Download -Install -AutoReboot