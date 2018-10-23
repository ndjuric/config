#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;-Caption
LWIN & PgUp::
WinSet, Style, -0xC00000, A
WinSet, Style, -0xC40000, A
return
;

;+Caption
LWIN & PgDn::
WinSet, Style, +0xC00000, A
WinSet, Style, +0xC40000, A
return
;

;+Caption
LWIN & Backspace::
SysGet, outputvar, MonitorWorkArea
Height:=outputvarBottom-outputvarTop
WinMove, A, , 0, 0, , %Height%

return
;