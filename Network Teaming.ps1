foreach ($i in ((Get-NetLbfoTeam).name)) 
{ 
Write-Host "`nTeam Name – "$i`n"Team Members: " 
Get-NetAdapter (Get-NetLbfoTeamMember -Team $i).Name | Format-Table 
}
