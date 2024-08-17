# Please see https://github.com/PowerShell/PowerShell/issues/3028 as to why this isn't in use
$action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument '-WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Users\ivanc\Documents\bloodsugar-cursor\bloodsugar_cursor.ps1"'

$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5)

$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

Register-ScheduledTask -TaskName "Blood Sugar Cursor" -Action $action -Trigger $trigger -Settings $settings