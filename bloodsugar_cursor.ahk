; orignal topic converted to v2: https://www.autohotkey.com/boards/viewtopic.php?t=81652
cursor_file := ".\arrow_eoa.cur"
F3::SetSystemCursor(cursor_file)
F4::RestoreCursors()

SetSystemCursor(cursor_file) {
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