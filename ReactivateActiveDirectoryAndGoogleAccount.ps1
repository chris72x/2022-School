$UserName = Read-Host -Prompt 'Input the username'
$Grade = Read-Host -Prompt "What grade is the student in, 0-12?"

switch($Grade){
    {0..2 -contains $_}{$org = "Students/Primary Center"}
    {3..5 -contains $_}{$org = "Students/Upper Elementary"}
    {6..12 -contains $_}{$org = "Students/Jr Sr High School"}
}

$Path = ("OU=Students,OU=Domain Users,DC=Local,DC=srsd,DC=k12,DC=pa,DC=us")

Unlock-ADAccount -Identity $UserName
Enable-ADAccount -Identity $UserName
(Get-ADUser -Identity $UserName).distinguishedname | Move-ADObject -TargetPath $Path


gam update user ($UserName + "@srsd.k12.pa.us") suspended off