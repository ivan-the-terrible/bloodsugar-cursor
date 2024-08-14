# bloodsugar-cursor

A cool way to update your cursor to reflect your blood sugar values.

The main idea here is to poll against your Nightscout API every couple of minutes or so and update the color of your mouse cursor to help indicate your current level.

For right now, the colors are:

- green = in range
- yellow = high
- red = low

Included are the cursor files that will be loaded based on this status.
You can run this via AutoHotKey for right now.

## Technical Details

Windows has certain APIs available to update the cursor. Mainly, `LoadCursorFromFile` and `SetSystemCursor` are leveraged.

<https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-setsystemcursor>
<https://learn.microsoft.com/en-us/windows/win32/menurc/about-cursors>
<http://www.jasinskionline.com/windowsapi/ref/s/setsystemcursor.html>
Each value below is a DWORD value, which identifies a cursor.

- 32512 = OCR_NORMAL
- 32513 = OCR_IBEAM
- 32514 = OCR_WAIT
- 32515 = OCR_CROSS
- 32516 = OCR_UP
- 32642 = OCR_SIZENWSE
- 32640 = OCR_SIZE (Win NT only LOL, couldn't find this in official docs)
- 32641 = OCR_ICON (Win NT only LOL, couldn't find this in official docs)
- 32643 = OCR_SIZENESW
- 32644 = OCR_SIZEWE
- 32645 = OCR_SIZENS
- 32646 = OCR_SIZEALL
- 32648 = OCR_NO
- 32649 = OCR_HAND
- 32650 = OCR_APPSTARTING
- 32651 = IDC_HELP

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
"C:\\Users\\ivanc\\AppData\\Local\\Microsoft\\Windows\\Cursors\\arrow_eoa.cur"

Going to that directory, we can find these cursor files. If we change the color in Settings now, we can see these files get updated.
