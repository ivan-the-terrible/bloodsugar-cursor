
$SetSystemCursor_Signature = @"
[DllImport("user32.dll")]public static extern bool SetSystemCursor(IntPtr hcur, int id);

[DllImport("user32.dll")]
public static extern IntPtr LoadCursorFromFile(string lpFileName);

public static void SetCursorFromFile(string cursorFile, int cursorId){
    IntPtr hCursor = LoadCursorFromFile(cursorFile);
    SetSystemCursor(hCursor, cursorId);
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

$cursor_dict = @{
    32512 = "arrow_eoa.cur"
    32513 = "ibeam_eoa.cur"
    32514 = "wait_eoa.cur"
    32515 = "cross_eoa.cur"
    32516 = "up_eoa.cur"
    32631 = "pen_eoa.cur"
    32642 = "nwse_eoa.cur"
    32643 = "nesw_eoa.cur"
    32644 = "ew_eoa.cur"
    32645 = "ns_eoa.cur"
    32646 = "move_eoa.cur"
    32648 = "unavail_eoa.cur"
    32649 = "link_eoa.cur"
    32650 = "busy_eoa.cur"
    32651 = "helpsel_eoa.cur"
    32671 = "pin_eoa.cur"
    32672 = "person_eoa.cur"
}

$scriptPath = $MyInvocation.MyCommand.Path
$absolutePath = Convert-Path -Path $scriptPath
$directory = [System.IO.Path]::GetDirectoryName($absolutePath)

$elevated_cursors = Join-Path -Path $directory -ChildPath "elevated_cursors"
$inrange_cursors = Join-Path -Path $directory -ChildPath "inrange_cursors"
$low_cursors = Join-Path -Path $directory -ChildPath "low_cursors"

if (!(Test-Path -Path $elevated_cursors)) {
    Write-Host "The path $elevated_cursors does not exist."
    exit
}

if (!(Test-Path -Path $inrange_cursors)) {
    Write-Host "The path $inrange_cursors does not exist."
    exit
}

if (!(Test-Path -Path $low_cursors)) {
    Write-Host "The path $low_cursors does not exist."
    exit
}

function SetElevatedCursors {
    foreach ($cursorId in $cursor_dict.Keys) {
        $cursorFile = Join-Path -Path $elevated_cursors -ChildPath $cursor_dict[$cursorId]
        $SetSystemCursor::SetCursorFromFile($cursorFile, $cursorId)
    }
}

function SetInRangeCursors {
    foreach ($cursorId in $cursor_dict.Keys) {
        $cursorFile = Join-Path -Path $inrange_cursors -ChildPath $cursor_dict[$cursorId]
        $SetSystemCursor::SetCursorFromFile($cursorFile, $cursorId)
    }
}

function SetLowCursors {
    foreach ($cursorId in $cursor_dict.Keys) {
        $cursorFile = Join-Path -Path $low_cursors -ChildPath $cursor_dict[$cursorId]
        $SetSystemCursor::SetCursorFromFile($cursorFile, $cursorId)
    }
}

$jsonUrl = "http://192.168.0.127:1337/api/v1/entries.json"
$response = Invoke-RestMethod -Uri $jsonUrl -Method Get

$sugar_value = $response[0].sgv

if ($sugar_value -gt 200) {
    SetElevatedCursors
} elseif ($sugar_value -lt 90) {
    SetLowCursors
} else {
    SetInRangeCursors
}