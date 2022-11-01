$text = gam info user cchristiansen@srsd.k12.pa.us

$position = $text[2].IndexOf(":")

$Firstname = $text[1].Substring($position+2)

$Lastname = $text[2].Substring($position+2)

Write-Host "Lastname="$Lastname
Write-Host $Firstname