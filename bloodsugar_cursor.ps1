
$SetSystemCursor_Signature = @"
[DllImport("user32.dll")]public static extern bool SetSystemCursor(IntPtr hcur, int id);

[DllImport("user32.dll")]
public static extern IntPtr LoadCursorFromFile(string lpFileName);

public static void SetCursorFromFile(string cursorFile){
    IntPtr hCursor = LoadCursorFromFile(cursorFile);
    SetSystemCursor(hCursor, 32512);
}
"@

$SetSystemCursor = Add-Type -MemberDefinition $SetSystemCursor_Signature -Name "Win32SetSystemCursor" -Namespace Win32Functions -PassThru

$SystemParametersInfo_Signature = @"
[DllImport("user32.dll")]public static extern bool SystemParametersInfo(int uiAction, int uiParam, IntPtr pvParam, int fWinIni);

public const int SPI_SETCURSORS = 0x57;

public static void RestoreCursors(){
    SystemParametersInfo(SPI_SETCURSORS, 0, IntPtr.Zero, 0);
}
"@

$SystemParametersInfo = Add-Type -MemberDefinition $SystemParametersInfo_Signature -Name "Win32SystemParametersInfo" -Namespace Win32Functions -PassThru

$scriptPath = $MyInvocation.MyCommand.Path
$absolutePath = Convert-Path -Path $scriptPath
$directory = [System.IO.Path]::GetDirectoryName($absolutePath)

$jsonUrl = "http://192.168.0.127:1337/api/v1/entries.json"
$response = Invoke-RestMethod -Uri $jsonUrl -Method Get

$sugar_value = $response[0].sgv

if ($sugar_value -gt 175) {
    # set the color yellow
} else if ($sugar_value -lt 70) {
    # set the color red
} else {
    # set the color green
}