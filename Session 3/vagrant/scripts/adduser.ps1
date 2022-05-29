net user Adam Pass@123 /ADD /DOMAIN /Y
net user serveradmin1 Password@123 /ADD /DOMAIN /Y
net user serveradmin2 Password@123 /ADD /DOMAIN /Y
net user serveradmin3 Password@123 /ADD /DOMAIN /Y
net user servermaintenance4 Password!123 /ADD /DOMAIN /Y
net user servermaintenance5 Password!123 /ADD /DOMAIN /Y
net user servermaintenance1 Password!123 /ADD /DOMAIN /Y
net user servermaintenance2 Password!123 /ADD /DOMAIN /Y
net user servermaintenance3 Password!123 /ADD /DOMAIN /Y
net user helpdeskadmin1 Password_123 /ADD /DOMAIN /Y
net user helpdeskadmin2 Password_123 /ADD /DOMAIN /Y
net user helpdeskadmin3 Password_123 /ADD /DOMAIN /Y
net user helpdeskadmin4 Password_123 /ADD /DOMAIN /Y
net user helpdeskadmin5 Password_123 /ADD /DOMAIN /Y
net user domainadmin1 Password*123 /ADD /DOMAIN /Y
net user domainadmin2 Password*123 /ADD /DOMAIN /Y
net user domainadmin3 Password*123 /ADD /DOMAIN /Y
net user domainadmin4 Password*123 /ADD /DOMAIN /Y
net user domainadmin5 Password*123 /ADD /DOMAIN /Y
net user dcadmin1 Pass-123 /ADD /DOMAIN /Y
net user dcadmin2 Pass-123 /ADD /DOMAIN /Y
net user dcadmin3 Pass-123 /ADD /DOMAIN /Y
net user dcadmin4 Pass-123 /ADD /DOMAIN /Y
net user dcadmin5 Pass-123 /ADD /DOMAIN /Y

New-ADGroup -Name "server administrators" -SamAccountName "server administrators" -GroupCategory Security -GroupScope Global -DisplayName "Server administrators" -Path "CN=Users,DC=Auror,DC=Local" -Description "Members of this group are server admins"
Add-ADGroupMember -Identity "server administrators" -Members serveradmin1,serveradmin2,serveradmin3,servermaintenance4,servermaintenance5
New-ADGroup -Name "Server maintenance" -SamAccountName "server maintenance" -GroupCategory Security -GroupScope Global -DisplayName "Server maintenance" -Path "CN=Users,DC=Auror,DC=Local" -Description "Members of this group are server maintenance"
Add-ADGroupMember -Identity "server maintenance" -Members servermaintenance4,servermaintenance5,servermaintenance1,servermaintenance2,servermaintenance3
New-ADGroup -Name "Helpdesk admin" -SamAccountName "helpdesk admins" -GroupCategory Security -GroupScope Global -DisplayName "helpdesk admins" -Path "CN=Users,DC=Auror,DC=Local" -Description "Members of this group are helpdesk admins"
Add-ADGroupMember -Identity "helpdesk admins" -Members helpdeskadmin1,helpdeskadmin2,helpdeskadmin3,helpdeskadmin4,helpdeskadmin5
New-ADGroup -Name "exchange admins" -SamAccountName "exchange admins" -GroupCategory Security -GroupScope Global -DisplayName "exchange admins" -Path "CN=Users,DC=Auror,DC=Local" -Description "Members of this group are exchange admins"
Add-ADGroupMember -Identity "exchange admins" -Members dcadmin1,dcadmin2,dcadmin3,dcadmin4,dcadmin5
Add-ADGroupMember -Identity "Domain Admins" -Members domainadmin1,domainadmin2,domainadmin3,domainadmin4,domainadmin5

New-GPO -Name "Server administrators" -Comment "Server admins"
New-GPO -Name "server maintenance" -Comment "RDP to members"
New-GPO -Name "helpdesk admin" -Comment "admin to local account user"
New-GPO -Name "exchange admin" -Comment "DC admins"
