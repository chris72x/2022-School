(Import-Module ActiveDirectory)

$SourceFile = ("C:\Users\cchristiansen\Downloads\StudentsFile - Sheet1.csv")

$csv = Import-Csv $SourceFile

foreach($_ in $csv) {

    switch($_.Grade){
        {0..2 -contains $_}{$org = "Students/Primary Center"}
        {3..5 -contains $_}{$org = "Students/Upper Elementary"}
        {6..12 -contains $_}{$org = "Students/Jr Sr High School"}
    }

    $Name = ($_.Firstname + " " + $_.Lastname)
    $EmailAddress = ($_.Username + "@srsd.k12.pa.us")
    $Path = ("OU=Students,OU=Domain Users,DC=Local,DC=srsd,DC=k12,DC=pa,DC=us")
    function CreateActiveDirectoryAccount {

<#        New-ADUser -Name $Name `
            -GivenName $_.Firstname `
            -Surname $_.Lastname `
            -DisplayName $Name `
            -UserPrincipalName ($EmailAddress) `
            -SamAccountName $_.Username `
            -EmailAddress $EmailAddress `
            -AccountPassword $_.Password `
            -CannotChangePassword $true `
            -PasswordNeverExpires $true `
            -ChangePasswordAtLogon $false `
            -Enabled $true
            -Path $Path
#>
            Write-Host "Username:"$_.Username", Password: "$_.Password
            Write-Host "givenname:"$_.Firstname
            Write-Host "surname:"$_.Lastname
            Write-Host "displayname:"$Name
            Write-Host "userprincipalname:"$EmailAddress
            Write-Host "samaccountname:"$_.Username
            Write-Host "emailaddress:"$EmailAddress
            Write-Host "accountpassword:"$_.Password
            Write-Host "path:"$Path
    }
    
    function CreateGoogleAccount {
<#
        gam create user $_.$EmailAddress firstname $_.Firstname lastname $_.Lastname password $_.Password changepassword off
        gam update org $org add user $EmailAddress
        gam info user $_.$EmailAddress
#>
        Write-Host "Org: "$org
    }

    CreateActiveDirectoryAccount
    CreateGoogleAccount
}