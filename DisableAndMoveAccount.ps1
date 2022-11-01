$accountname = Read-Host -Prompt 'Input the username'
$org = "Students/Suspended accounts"
$emailaddress = ($accountname + "@srsd.k12.pa.us")

Get-ADUser -Identity samaccountname | 
Move-ADObject -TargetPath "OU=Deactivated,OU=Students,OU=Domain Users,DC=Local,DC=srsd,DC=k12,DC=pa,DC=us" -PassThru | 
Disable-ADAccount

gam update user $emailaddress suspended on
gam update org $org add user $EmailAddress
gam info user $emailaddress
