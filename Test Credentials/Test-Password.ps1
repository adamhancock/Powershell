# Adam Hancock

Import-Module ActiveDirectory  

$users = $null  

function Test-ADCredential {
    [CmdletBinding()]
    Param
    (
        [string]$UserName,
        [string]$Password
    )
    if (!($UserName) -or !($Password)) {
        # Write-Warning 'Test-ADCredential: Please specify both user name and password'
    }
    else {
    
        Add-Type -AssemblyName System.DirectoryServices.AccountManagement
        $DS = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('domain')
        $result = $DS.ValidateCredentials($UserName, $Password)
        if ($result) {
            write-host $UserName
        }
    }
}

#####################################

$password = "Stoba123"
write-host Password: $password
Get-ADUser -Filter * -Properties userPrincipalName | foreach { Test-ADCredential -username $_.userPrincipalName -password $password   }
