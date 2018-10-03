$url = ""
$data = Get-EventLog -LogName "Veeam Endpoint Backup" -Newest 2 | where {$_.message -like "*success*" -or $_.message -like "*fail*" } | ConvertTo-Json
Invoke-WebRequest -UseBasicParsing $url -ContentType "application/json" -Method POST -Body $data