## Adam Hancock

$csv = Import-Csv users.csv
$csv | ForEach-Object {
$password =  $_.password | ConvertTo-SecureString -AsPlainText -Force
New-ADUser -SamAccountName $_.username -GivenName $_.Firstname -Surname $_.Surname -DisplayName ($_.Firstname + " " + $_.Surname) -Name ($_.Firstname + " " + $_.Surname) -AccountPassword $password -EmailAddress $_.email -UserPrincipalName $_.email -Enabled $true -title $_.Title
}