$interval=30
$global:basetime=0
$global:admincount=0
$global:dc=0

Add-Type -AssemblyName PresentationCore,PresentationFramework

#initialize the count of server admins and exchange admins
function admincountinit{
$groups="server Administrators","exchange admins"
foreach($group in $groups){
$Adgroupmembers=Get-ADGroupMember -Identity $group -Recursive | measure
$admincounttemp=$Adgroupmembers.Count+$admincounttemp
}
$global:admincount=$admincounttemp
}

#check if there are any changes in the exchange admins and server admins
function server-admins{
$groups="server Administrators","exchange admins"
foreach($group in $groups){
$Adgroupmembers=Get-ADGroupMember -Identity $group -Recursive | measure
$admincounttemp=$Adgroupmembers.Count+$admincounttemp
}
#write-output $admincount
if($admincount -lt $admincounttemp){
[System.Windows.MessageBox]::Show("There is a new member in the server or DC admin group")
}
}



#check if any computer is added in any security groups  groups
function computer-securitygroup{
$groups="Helpdesk admins","server administrators","domain admins","server maintenance","exchange admins"
foreach($group in $groups){
$Adgroupmembers=Get-ADGroupMember -Identity $group -Recursive
foreach($Adgroupmember in $Adgroupmembers){
if($Adgroupmember.objectClass -eq "computer"){
[System.Windows.MessageBox]::Show("$($Adgroupmember.name) in $($group)") }}}
}

#check if help desk users are member of server admin
function helpdeskadmin-in-serveradmin{
$helpdeskadmins= Get-ADGroupMember -Identity "helpdesk Admins" -Recursive
$serveradmins= Get-ADGroupMember -Identity "server administrators" -Recursive
foreach($helpdeskadmin in $helpdeskadmins){
foreach($serveradmin in $serveradmins){
if($helpdeskadmin.name -eq $serveradmin.name){
[System.Windows.MessageBox]::Show("This Helpdesk admin $($helpdeskadmin.name) is also a server admin")}
}
}}

#check if domain admin members are changed
function domainadminsinit{
$dacount=Get-ADGroupMember -Identity "domain Admins" -Recursive  | measure
$global:dc=$dacount.Count
}
function domainadmins{
$currentcount=Get-ADGroupMember -Identity "domain Admins" -Recursive  | measure
$cc=$currentcount.Count
if($dc -ne $cc){
[System.Windows.MessageBox]::Show("some changes has been made to the domain admins member")

}

}

function password-spray{

$adusers=get-aduser -filter * -properties *
$count=0
foreach($aduser in $adusers){
$time=([int64]$aduser.badPasswordTime)/10000000
#write-output $basetime
#write-output $interval
if($time -ge $basetime+$interval){
$global:basetime=$time}
elseif(($time -le $basetime+60) -and ($time -ge $basetime)  ){
$count=$count+1
}
#write-output $time

}
if($count -ge 20)
{
[System.Windows.MessageBox]::Show("password spraying attack Detected")}

}

admincountinit
domainadminsinit
for(;;){
computer-securitygroup
helpdeskadmin-in-serveradmin
domainadmins
server-admins
password-spray
start-sleep -seconds $interval}