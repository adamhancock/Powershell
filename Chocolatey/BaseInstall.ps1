## Installing Modules

$modules = Get-Content -Raw -Path modules.json | ConvertFrom-Json

$modules | ForEach-Object -Process {
if (-not (Get-Module -Name $_.name -EA SilentlyContinue )) {
    write-host "Installing " $_.name "..." 
    Install-module $_.name -force
    Import-module $_.name
    Install-PackageProvider $_.name
    Import-PackageProvider $_.name
    Set-PackageSource $_.source -Trusted
    }else{
        write-host $_.name "already installed"
    }
}


## Installing Packages

  $packages = Get-Content -Raw -Path packages.json | ConvertFrom-Json

  $packages | ForEach-Object -Process {
        if (-not (Get-Package $_.name -ErrorAction SilentlyContinue)){
            if ($_.prompt){
                $message = "Install " + $_."name" + " from " + $_."source" + "? Y/N"
                $install = Read-Host -Prompt $message
                    if($install -eq "y"){
                        write-host "Installing "$_.name"..."
                        Install-Package -Name $_.name -ProviderName $_.source 
                    }
            }else{
        write-host "Installing "$_.name"..."
        Install-Package -Name $_.name -ProviderName $_.source 
    }
    }else{
        write-host $_.name "is already installed." 
    }
  }