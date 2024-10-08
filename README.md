# bloodsugar-cursor

A cool way to update your cursor to reflect your blood sugar values.

The main idea here is to poll against your Nightscout API every 5 minutes and update the color of your mouse cursor to help indicate your current level.

For right now, the colors are:

- green = in range
- yellow = high
- red = low

Included are the cursor files that will be loaded based on this status.
You can run this via AutoHotkey and PowerShell for right now, and is very Windows centric.

A known issue is how the cursor is rendered when running the PowerShell script. It's currently quite blurry and there seems to be a need to activate something to kick in better rendering. AutoHotkey doesn't have this problem.

I HIGHLY recommend using this with AutoHotkey since PowerShell has so many issues (from the blurry cursor to the inability to have a decent Cron job implementation).
<https://www.autohotkey.com/>

## Technical Details

Windows has certain APIs available to update the cursor. Mainly, `LoadCursorFromFile` and `SetSystemCursor` are leveraged.

<https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-setsystemcursor>
<https://learn.microsoft.com/en-us/windows/win32/menurc/about-cursors>
<http://www.jasinskionline.com/windowsapi/ref/s/setsystemcursor.html>

Each value below is a DWORD value, which identifies a cursor.

- 32512 = NORMAL
- 32513 = IBEAM
- 32514 = WAIT
- 32515 = CROSS
- 32516 = UP
- 32631 = PEN
- 32642 = SIZENWSE
- 32643 = SIZENESW
- 32644 = SIZEWE
- 32645 = SIZENS
- 32646 = SIZEALL
- 32648 = NO
- 32649 = HAND
- 32650 = APPSTARTING
- 32651 = HELP
- 32671 = PIN
- 32672 = PERSON

### Registry Keys

Within the Registry Editor, a couple places control mouse/cursor settings:

- Computer/HKEY_CURRENT_USER
  - Control Panel
    - Cursors
    - Mouse
  - Software/Microsoft/Accessibility

You can see values corresponding to some defaults, which seem to be linked to the
accessibility settings.

"Cursor Size" in Settings/Accessibility/Mouse pointer and touch is linked to
Control Panel/Cursors -> CursorBaseSize in the Registry:
3 = 64
4 = 80

"Mouse pointer speed" in Settings/Bluetooth & devices/Mouse is linked to
Control Panel/Mouse -> MouseSensitivity. The values are equivalent.

And finally "Mouse pointer style" in Settings/Accessibility/Mouse pointer and touch is linked to
Software/Microsoft/Accessibility

There are four registry keys here:

- CursorColor
- CursorSize
- CursorType
- TextScaleFactor

The color can be seen to change from:
Green = 12582656 (0x00bfff00)
Yellow = 64250      (0x0000fafa)

Back at the Control Panel/Cursors entries, the file path for Arrow is this string:
"C:\\Users\\[YOUR_USERNAME]\\AppData\\Local\\Microsoft\\Windows\\Cursors\\arrow_eoa.cur"

Going to that directory, we can find these cursor files. If we change the color in Settings now, we can see these files get updated.

### AutoHotkey

This topic helped tremendously in doing this in AutoHotkey (v1):
<https://www.autohotkey.com/boards/viewtopic.php?t=81652>

No major changes to the logic, other than updating the script to v2 syntax.

### PowerShell

The PowerShell script is written in a way that is to be leveraged by Task Scheduler.
This doesn't really work well with Task Scheduler because of this issue: <https://github.com/PowerShell/PowerShell/issues/3028>.

The stupid PowerShell window keeps appearing and causing whatever window I'm on to lose focus.

The DLL is also called in a little bit of an odd way...

<https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-type?view=powershell-5.1#example-4-call-native-windows-apis>

The above reference shows how you can leverage the `Add-Type` utility to add a Microsoft .NET class to a PowerShell session.
Since .NET can make the DLL call, we have this nested logic of a DLL call within a .NET string defined within PowerShell. Yikes.

It's probably worth it to create an actual .NET solution for this instead of scripting it through PowerShell. So much for a PoC for PowerShell.
