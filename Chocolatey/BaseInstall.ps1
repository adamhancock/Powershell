
## Parameters
param (
    [Parameter(Mandatory=$true)][string]$install
 )

## Installing PS Modules in modules.json 

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

    # Import json file set with -install parameter. 
  $packagesArray = Get-Content -Raw -Path $install | ConvertFrom-Json

  $packagesArray | ForEach-Object -Process {
      ## Loop through the packages json file
        if (-not (Get-Package $_.name -ErrorAction SilentlyContinue)){
            if ($_.prompt){
                ## Package has prompt set, prompt user to install? 
                $message = "Install " + $_."name" + " from " + $_."source" + "? Y/N"
                $install = Read-Host -Prompt $message
                    if($install -eq "y"){
                        write-host "Installing "$_.name"..."
                        ## User said yes, Go Install Package from Source. 
                        Install-Package -Name $_.name -ProviderName $_.source 
                    }
            }else{
        write-host "Installing "$_.name"..."
        # No prompt required, just install it. 
        Install-Package -Name $_.name -ProviderName $_.source 
    }
    }else{
        # Package is already installed. 
        write-host $_.name "is already installed." 
    }
  }