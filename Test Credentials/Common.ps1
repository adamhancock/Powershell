## Adam Hancock

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
            write-host -ForegroundColor Red Password: $Password - $UserName
            Write-Output $Password - $UserName | Out-File users.txt -Append
        }
    }
}
Write-Output "Starting Log..." | Out-File users.txt
Write-Host "Downloading Password List..."
Invoke-WebRequest -Uri "https://ingeniotech.blob.core.windows.net/download/passwordlist.txt" -OutFile passwords.txt
$total = Get-Content passwords.txt| Measure-Object –Line
Write-Host "Testing Passwords..."

foreach ($user in Get-ADUser -Filter * -Properties Name, userPrincipalName) {
    # write-host $user.Name -ForegroundColor Green
    $i = 1;
    foreach ($password in Get-Content .\passwords.txt) {
     
        # write-host $user.name - $i '/' $total.Lines
        $perc = [math]::Round($i / $total.Lines * 100)
        
        $name = $user.Name 
        
        Write-Progress -Activity "Testing $name - $perc%" -PercentComplete $perc
        # write-host $user.userPrincipalName - $user.LockedOut   
        Test-ADCredential -username $user.userPrincipalName  -password $password 
            
        $lockedout = Get-ADUser -identity $user -Properties LockedOut
        # write-host $lockedout.LockedOut
        if ($lockedout.LockedOut) {
            # write-host "Unlocking.."
            Unlock-ADAccount -Identity $user.SamAccountName
        }
        $i++

    }

}