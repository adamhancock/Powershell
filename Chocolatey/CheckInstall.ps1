if (-not (Get-Module -Name "ChocolateyGet" -EA SilentlyContinue )) {
    write-host "Installing ChocolateyGet..."
    Install-module "ChocolateyGet" -force
    Import-module "ChocolateyGet"
    Install-PackageProvider "ChocolateyGet"
    Import-PackageProvider "ChocolateyGet"
     
    }else{
        write-host "ChocolateyGet already installed"
    }