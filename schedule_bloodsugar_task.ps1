# this is utterly ridiculous, but it's the only way I could get the task to run without a window popping up
# I have to call command prompt to call powershell to call the script - like really????
$action = New-ScheduledTaskAction -Execute 'cmd.exe' -Argument 'cmd /c start /min "" powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Users\ivanc\Documents\bloodsugar-cursor\bloodsugar_cursor.ps1"'

$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5)

$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

Register-ScheduledTask -TaskName "Blood Sugar Cursor" -Action $action -Trigger $trigger -Settings $settings