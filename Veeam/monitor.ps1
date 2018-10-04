$url = "http://postb.in/lGzqbNSG"
if (Get-WinEvent -LogName "Veeam Endpoint Backup"){
$data = Get-WinEvent -LogName "Veeam Endpoint Backup" -MaxEvents 10 | where {$_.message -like "*success*" -or $_.message -like "*fail*" } | ConvertTo-Json -depth 5
}else{
    $data = Get-WinEvent -LogName "Veeam Agent" -MaxEvents 10 | where {$_.message -like "*success*" -or $_.message -like "*fail*" } | ConvertTo-Json -depth 5
}
Write-Host $data
Invoke-WebRequest -UseBasicParsing $url -ContentType "application/json" -Method POST -Body $data