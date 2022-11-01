$UserName = Read-Host -Prompt 'Input the username'
$Password = Read-Host -Prompt 'Input the password'
Function Test-ADAuthentication {
    param(
        $UserName,
        $Password)
    
    $null -ne (New-Object DirectoryServices.DirectoryEntry "",$UserName,$Password).psbase.name
}

Test-ADAuthentication -username $UserName -password $Password