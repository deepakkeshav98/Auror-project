$DomainAdmin      =  $env:username
$Password         =  "password@123"
$DomainPassword   =  ConvertTo-SecureString $Password -AsPlainText -Force
$DomainFQDN       =  "auror.local"
$DomainNetBios    =  $DomainFQDN.Split('.') | SELECT -First 1
$DomainSuffix     =  $DomainFQDN.Split('.') | SELECT -last 1
$admin            =  $DomainAdmin
$DomainUser       =  $admin + "@" + $domainFQDN


Write-Host "Starting isntall features"
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Import-Module ADDSDeployment
Write-Host "Ad Deployment"
Install-ADDSForest `
    -DomainName $DomainFQDN `
    -DomainNetbiosName $DomainNetBios `
    -DatabasePath "C:\NTDS" `
    -LogPath "C:\NTDS" `
    -SysvolPath "C:\SYSVOL" `
    -DomainMode "WinThreshold" `
    -ForestMode "WinThreshold" `
    -CreateDNSDelegation:$false `
    -InstallDns:$true `
    -NoRebootOnCompletion:$true `
    -Force:$true `
    -SafeModeAdministratorPassword $DomainPassword
;
