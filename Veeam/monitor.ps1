$url = "http://postb.in/lGzqbNSG"
if (Get-WinEvent -LogName "Veeam Endpoint Backup" -ErrorAction silentlycontinue ){
$logname = "Veeam Endpoint Backup"
}else{
    $logname = "Veeam Agent"
}
$data = Get-WinEvent -LogName $logname -MaxEvents 10 | where {$_.message -like "*success*" -or $_.message -like "*fail*" } | ConvertTo-Json -depth 5

Write-Host $data
Invoke-WebRequest -UseBasicParsing $url -ContentType "application/json" -Method POST -Body $data