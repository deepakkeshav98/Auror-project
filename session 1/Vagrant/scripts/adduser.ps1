$Global:Domain = "";
$firstname = "Adam"
$lastname = ""
$fullname = "Adam"
$SamAccountName = "adam"
$principalname = "adam"
$password = "Pass@123"
New-ADUser -Name "$firstname $lastname" -GivenName $firstname -Surname $lastname -SamAccountName $SamAccountName -UserPrincipalName $principalname@$Global:Domain -Path "CN=Users,DC=auror,DC=local" -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount
