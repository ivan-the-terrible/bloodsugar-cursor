; orignal topic converted to v2: https://www.autohotkey.com/boards/viewtopic.php?t=81652
F3::SetSystemCursor()
F4::RestoreCursors()

SetSystemCursor() {
 ; https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-setsystemcursor
 ; https://learn.microsoft.com/en-us/windows/win32/menurc/about-cursors
 ; http://www.jasinskionline.com/windowsapi/ref/s/setsystemcursor.html
 ; Each value below is a DWORD value, which identifies a cursor.
 ; 32512 = NORMAL
 ; 32513 = IBEAM
 ; 32514 = WAIT
 ; 32515 = CROSS
 ; 32516 = UP
 ; 32631 = PEN
 ; 32642 = SIZENWSE
 ; 32643 = SIZENESW
 ; 32644 = SIZEWE
 ; 32645 = SIZENS
 ; 32646 = SIZEALL
 ; 32648 = NO
 ; 32649 = HAND
 ; 32650 = APPSTARTING
 ; 32651 = HELP
 ; 32671 = PIN
 ; 32672 = PERSON
 cursor_dict := {
   32512: "arrow_eoa.cur",
   32513: "ibeam_eoa.cur",
   32514: "wait_eoa.cur",
   32515: "cross_eoa.cur",
   32516: "up_eoa.cur",
   32631: "pen_eoa.cur",
   32642: "nwse_eoa.cur",
   32643: "nesw_eoa.cur",
   32644: "ew_eoa.cur",
   32645: "ns_eoa.cur",
   32646: "move_eoa.cur",
   32648: "unavail_eoa.cur",
   32649: "link_eoa.cur",
   32650: "busy_eoa.cur",
   32651: "helpsel_eoa.cur",
   32671: "pin_eoa.cur",
   32672: "person_eoa.cur"
 }

 inrange_cursors := ".\inrange_cursors"
 elevated_cursors := ".\elevated_cursors"
 low_cursors := ".\low_cursors"

 For key, value in cursor_dict {
   DllCall("SetSystemCursor", "Uint", DllCall("LoadCursorFromFile", "Str", value), "Int", key)
 }
}

RestoreCursors() {
 SPI_SETCURSORS := 0x57
 DllCall("SystemParametersInfo", "UInt", SPI_SETCURSORS, "UInt", 0, "UInt", 0, "UInt", 0)
}