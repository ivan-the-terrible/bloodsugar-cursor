; orignal topic converted to v2: https://www.autohotkey.com/boards/viewtopic.php?t=81652
Persistent()
OnExit(RestoreCursors)
SetTimer(SetSystemCursor, 300000) ; every 5 minutes

SetSystemCursor() ; initial call to run immediately

SetSystemCursor() {
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

  ; Send GET request
  HTTP := ComObject("WinHttp.WinHttpRequest.5.1")
  HTTP.Open("GET", "http://192.168.0.127:1337/api/v1/entries", true)
  HTTP.Send()
  HTTP.WaitForResponse()
  response := HTTP.ResponseText
  ; Get the blood sugar value
  response_lines := StrSplit(response, "`n")
  first_line := response_lines[1]
  blood_sugar := StrSplit(first_line, A_Tab)[3] ; 3rd column has the blood sugar value

  ; Set the cursor based on the blood sugar value
  if (blood_sugar < 90) {
    current_cursor_dir := low_cursors
  } else if (blood_sugar > 170) {
    current_cursor_dir := elevated_cursors
  } else {
    current_cursor_dir := inrange_cursors
  }

 For key, value in cursor_dict.OwnProps() {
   current_cursor := current_cursor_dir . "\" . value
   loaded_cursor := DllCall("LoadCursorFromFile", "Str", current_cursor)
   DllCall("SetSystemCursor", "Uint", loaded_cursor, "Int", key)
 }
}

RestoreCursors(*) {
 SPI_SETCURSORS := 0x57
 DllCall("SystemParametersInfo", "UInt", SPI_SETCURSORS, "UInt", 0, "UInt", 0, "UInt", 0)
}