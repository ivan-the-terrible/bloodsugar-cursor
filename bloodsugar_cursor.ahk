; orignal topic converted to v2: https://www.autohotkey.com/boards/viewtopic.php?t=81652
cursor_file := ".\arrow_eoa.cur"
F3::SetSystemCursor(cursor_file)
F4::RestoreCursors()

SetSystemCursor(cursor_file) {
 ; https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-setsystemcursor
 ; https://learn.microsoft.com/en-us/windows/win32/menurc/about-cursors
 ; http://www.jasinskionline.com/windowsapi/ref/s/setsystemcursor.html
 ; Each value below is a DWORD value, which identifies a cursor.
 ; 32512 = OCR_NORMAL
 ; 32513 = OCR_IBEAM
 ; 32514 = OCR_WAIT
 ; 32515 = OCR_CROSS
 ; 32516 = OCR_UP
 ; 32642 = OCR_SIZENWSE
 ; 32640 = OCR_SIZE (Win NT only LOL, couldn't find this in official docs)
 ; 32641 = OCR_ICON (Win NT only LOL, couldn't find this in official docs)
 ; 32643 = OCR_SIZENESW
 ; 32644 = OCR_SIZEWE
 ; 32645 = OCR_SIZENS
 ; 32646 = OCR_SIZEALL
 ; 32648 = OCR_NO
 ; 32649 = OCR_HAND
 ; 32650 = OCR_APPSTARTING
 ; 32651 = IDC_HELP


 Cursors := "32512,32513,32514,32515,32516,32640,32641,32642,32643,32644,32645,32646,32648,32649,32650,32651"
 Loop Parse, Cursors, ","
 {
  DllCall("SetSystemCursor", "Uint", DllCall("LoadCursorFromFile", "Str", cursor_file), "Int", A_Loopfield)
 }
}

RestoreCursors() {
 SPI_SETCURSORS := 0x57
 DllCall("SystemParametersInfo", "UInt", SPI_SETCURSORS, "UInt", 0, "UInt", 0, "UInt", 0)
}