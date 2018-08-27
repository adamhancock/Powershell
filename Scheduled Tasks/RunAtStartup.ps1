## Adam Hancock
## Downloads and creates a task to run in at system startup. Runs under the system account. 
$downloadurl = "https://ninite.com/7zip-audacity-dropbox-greenshot-java8-notepadplusplus-paint.net-putty-silverlight-vlc/ninite.exe"
$taskname = "My Scheduled Task"
$taskdescription = "My Scheduled task Description"
$exe = "myexe.exe" 
# $exearguments = ""
$downloadlocation = 'C:\windows\Temp\' + $exe



if (Get-Content $downloadlocation -EA SilentlyContinue){
    Remove-Item $downloadlocation
}
Write-Host "Downloading..."
Invoke-WebRequest -Uri $downloadurl -OutFile $downloadlocation

if (Get-ScheduledTask -TaskName $taskname -EA SilentlyContinue){
    write-host "Scheduled Task already exists"
}else{
    if ($exearguments){
        $action = New-ScheduledTaskAction -Execute $exe -Argument $exearguments
    }else{
        $action = New-ScheduledTaskAction -Execute $exe
    }
    $trigger =  New-ScheduledTaskTrigger -AtStartup -RandomDelay 00:00:10
    $principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
    Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskname -Description $taskdescription -Principal $principal

}

