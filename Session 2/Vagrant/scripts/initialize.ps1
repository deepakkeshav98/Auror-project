$Path = $env:TEMP; $Installer = 'chrome_installer.exe'; Invoke-WebRequest -Uri 'http://dl.google.com/chrome/install/375.126/chrome_installer.exe' -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args '/silent /install' -Verb RunAs -Wait; Remove-Item -Path $Path\$Installer
Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ServerAddresses 10.0.0.10
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False
Get-WindowsCapability -Name RSAT.ActiveDirectory* -Online | Add-WindowsCapability -Online
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 0
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
#net localgroup Administrators adam /add
$Password = ConvertTo-SecureString -String 'vagrant' -AsPlainText -Force

# Create credential object
$Credential = New-Object System.Management.Automation.PSCredential ('Administrator', $Password)
$Settings = @{
    DomainName       = "auror.local"
    DomainCredential = $Credential
}
Add-Computer @Settings