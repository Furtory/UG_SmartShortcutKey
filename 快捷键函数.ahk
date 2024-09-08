;Shortcut Key 快捷键配置
SK:
SK:=1

;抬起触发的热键以防误触发
if (GM=0) ;没有手势
{
  触发热键:=StrReplace(A_ThisHotkey,"$")
  触发热键:=StrReplace(A_ThisHotkey,"^")
  触发热键:=StrReplace(A_ThisHotkey,"+")
  触发热键:=StrReplace(A_ThisHotkey,"!")
  Send {%触发热键% Up}
}
else if (GM=1) ;左右键
{
  Send {LButton Up}
  Send {RButton Up}
}
else if (GM=2) ;左右键
{
  Send {MButton Up}
}

;检查是否读取到快捷键配置
if (InStr(快捷键, "未设置")!=0) or (快捷键="") or (快捷键="ERROR")
{
  快捷键提示:="未设置"
  SK:=0
  return
}

;分离 快捷键配置 和 说明
快捷键:=StrSplit(快捷键,"|")
快捷键配置:=快捷键[1]
功能说明:=快捷键[2]

SetKeyDelay, -1, 10, Play

;清空快捷键提示
快捷键提示:=""

;按下快捷键配置的修饰键 并生成提示的修饰键部分
SendMode Input
BlockInput On
if (InStr(快捷键配置, "^")!=0) ;按下修饰键Ctrl
{
  Send {Ctrl Down}
  快捷键提示.="Ctrl+"
}
else
{
  if (InStr(快捷键配置, "^")=0) and GetKeyState("Ctrl", "P") ;抬起修饰键Ctrl
  {
    Send {Ctrl Up}
  }
}

if (InStr(快捷键配置, "!")!=0) ;按下修饰键Alt
{
  Send {Alt Down}
  快捷键提示.="Alt+"
}
else
{
  if (InStr(快捷键配置, "^")=0) and GetKeyState("Alt", "P") ;抬起修饰键Ctrl
  {
    Send {Alt Up}
  }
}

if (InStr(快捷键配置, "+")!=0) ;按下修饰键Shift
{
  Send {Shift Down}
  快捷键提示.="Shift+"
}
else
{
  if (InStr(快捷键配置, "^")=0) and GetKeyState("Shift", "P") ;抬起修饰键Ctrl
  {
    Send {Shift Up}
  }
}

;分离修饰键后输出快捷键
Sleep 30
; ToolTip 快捷键配置%快捷键配置%
快捷键提取:=StrReplace(快捷键配置,"^")
快捷键提取:=StrReplace(快捷键提取,"+")
快捷键提取:=StrReplace(快捷键提取,"!")
Send {%快捷键提取% Down}

;提示快捷键
IniRead, KeyToolTip, 软件设置.ini, 设置, KeyToolTip
if (KeyToolTip=1)
{
  SetTimer, KeyToolTip, 30
  SetTimer, KeyToolTipOff, -1500
}

Sleep 50

;生成提示的快捷键部分
if (InStr(触发热键, "Numpad")!=0) ;小键盘
{
  触发热键提示.=触发热键
  触发热键提示.=StrReplace(触发热键,"Numpad","小键盘")
}
else if (触发热键="0") or (触发热键="1") or (触发热键="2") or (触发热键="3") or (触发热键="4") or (触发热键="5") or (触发热键="6") or (触发热键="7") or (触发热键="8") or (触发热键="9")
{
  触发热键提示.="数字"
  触发热键提示.=触发热键
}
快捷键提示.=触发热键提示

;抬起快捷键配置的修饰键
if (InStr(快捷键配置, "+")!=0) ;抬起修饰键Shift
{
  Send {Shift Up}
}
if (InStr(快捷键配置, "!")!=0) ;抬起修饰键Alt
{
  Send {Alt Up}
}
if (InStr(快捷键配置, "^")!=0) ;抬起修饰键Ctrl
{
  Send {Ctrl Up}
}
Send {%快捷键提取% Up}

SendMode Event
BlockInput Off

if (GM!=0) ;手势触发快捷键 不进行长按设置
{
  SK:=0
  return
}

快捷键设置:=0
KeyDownTime:=A_TickCount
loop
{
  Sleep 30
  
  KeyPressTime:=A_TickCount-KeyDownTime
  ; 热键状态:=GetKeyState(触发热键, "P")
  ; ToolTip 触发热键%触发热键% 状态%热键状态% %KeyPressTime%ms
  if !GetKeyState(触发热键, "P")
  {
    Break
  }
  else if (WinExist("快捷键设置")!=0)
  {
    Continue
  }
  else if (KeyPressTime>1000) and (快捷键设置=0)
  {
    快捷键设置:=1
    goto 快捷键设置
  }
}

loop
{
  Sleep 30
  if !GetKeyState("Ctrl", "P") and !GetKeyState("Shift", "P") and !GetKeyState("Alt", "P")
  {
    Break
  }
}

SK:=0
return

快捷键设置:
CoordMode, Mouse, Screen
ToolTipCount:=A_TickCount
loop
{
  MouseGetPos, NX, NY
  Sleep 30
  if (A_TickCount-ToolTipCount>1500) and (GM=0)
  {
    ToolTip 按下前进键以取消设置
  }
  else
  {
    ToolTip 松开快捷键以进行设置
  }
  
  if !GetKeyState(触发热键, "P") and !GetKeyState("LButton", "P") and !GetKeyState("RButton", "P") and !GetKeyState("MButton", "P") and !GetKeyState("Space", "P") ;等待所有按键抬起以防误触
  {
    ToolTip
    Break
  }
  else if GetKeyState("XButton2", "P") and (GM=0) ;前进取消
  {
    ToolTip
    KeyWait, XButton2
    SK:=0
    return
  }
  else if (NX>LL) and (NX<LR) and (NY>LT) and (NY<LB) and (GM>0) and  !GetKeyState("Space", "P") ;手势取消
  {
    ToolTip
    KeyWait, LButton
    KeyWait, RButton
    SK:=0
    return
  }
}

gosub HotkeyOff
SK:=0

If (WinExist("快捷键设置")!=0)
{
  WinActivate, 快捷键设置
  Return
}

;提示当前处于的模式
模式:=""
if (Mode=1)
{
  模式:="数字"
}
else if (Mode=2)
{
  模式:="草图"
}
else if (Mode=3)
{
  模式:="建模"
}

Gui 快捷键设置:+DPIScale -MinimizeBox -MaximizeBox -Resize -SysMenu
Gui 快捷键设置:Font, s9, Segoe UI
Gui 快捷键设置:Add, Text, x14 y13 w220 h281 +Left, 设置 %模式%模式 下的`n%触发热键提示% 快捷键
Gui 快捷键设置:Add, Hotkey, x58 y50 w120 h25 v新快捷键配置, %快捷键配置%
Gui 快捷键设置:Add, Text, x14 y90 w220 h281 +Left, 快捷键功能说明
Gui 快捷键设置:Add, Edit, x58 y115 w120 h25 v新功能说明, %功能说明%
Gui 快捷键设置:Add, Button, x15 y150 w69 h25 GButton清空, &清空
Gui 快捷键设置:Add, Button, x83 y150 w69 h25 GButton确认, &确认
Gui 快捷键设置:Add, Button, x151 y150 w69 h25 GButton取消, &取消
Gui 快捷键设置:Show, w234 h185, 快捷键设置
Return

Button清空:
Gui, 快捷键设置:Destroy
快捷键配置:=""
功能说明:=""
gosub SaveSK
gosub ReadSK
gosub HotkeyOn
return

Button确认:
Gui, 快捷键设置:Submit, NoHide
Gui, 快捷键设置:Destroy
快捷键配置:=新快捷键配置
功能说明:=新功能说明
gosub SaveSK
gosub ReadSK
gosub HotkeyOn
return

Button取消:
Gui, 快捷键设置:Destroy
gosub HotkeyOn
return

SaveSK:
;根据触发的热键生成变量名
if (GM>0) ;手势快捷键
{
  变量名:=触发热键提示
}
else ;非手势快捷键
{
  变量名:=""
  if (InStr(触发热键, "+")!=0) ;Shift
  {
    变量名.="Shift"
  }
  if (InStr(触发热键, "!")!=0) ;Alt
  {
    变量名.="Alt"
  }
  if (InStr(触发热键, "^")!=0) ;Ctrl
  {
    变量名.="Ctrl"
  }
  
  if (InStr(触发热键, "Numpad")!=0) ;小键盘
  {
    变量名.=触发热键
    变量名.=StrReplace(触发热键,"Numpad","小键盘")
  }
  else if (触发热键="0") or (触发热键="1") or (触发热键="2") or (触发热键="3") or (触发热键="4") or (触发热键="5") or (触发热键="6") or (触发热键="7") or (触发热键="8") or (触发热键="9")
  {
    变量名.="数字"
    变量名.=触发热键
  }
}

;合并快捷键配置
if (快捷键配置="")
{
  快捷键配置:="未设置"
}
快捷键配置.="|"
if (功能说明="")
{
  功能说明:="功能说明"
}
快捷键配置.=功能说明

if (Mode=2)
{
  IniWrite, %快捷键配置%, 快捷键设置.ini, 草图设置, %变量名%
}
else if (Mode=3)
{
  IniWrite, %快捷键配置%, 快捷键设置.ini, 建模设置, %变量名%
}
return

KeyToolTip:
ToolTip, %功能说明%
Sleep 30
return

KeyToolTipOff:
SetTimer, KeyToolTip, Delete
ToolTip
return

HotkeyOff:
Hotkey, $1, Off
Hotkey, $2, Off
Hotkey, $3, Off
Hotkey, $4, Off
Hotkey, $5, Off
Hotkey, $6, Off
Hotkey, $7, Off
Hotkey, $8, Off
Hotkey, $9, Off
Hotkey, $0, Off
Hotkey, $., Off
Hotkey, $NumpadDot, Off
Hotkey, $Enter, Off
Hotkey, $NumpadEnter, Off
Hotkey, $NumpadAdd, Off
Hotkey, $NumpadSub, Off
Hotkey, $NumpadMult, Off
Hotkey, $NumpadDiv, Off

Hotkey, $^1, Off
Hotkey, $^2, Off
Hotkey, $^3, Off
Hotkey, $^4, Off
Hotkey, $^5, Off
Hotkey, $^6, Off
Hotkey, $^7, Off
Hotkey, $^8, Off
Hotkey, $^9, Off
Hotkey, $^0, Off
Hotkey, $^., Off
Hotkey, $^NumpadDot, Off
Hotkey, $^Enter, Off
Hotkey, $^NumpadEnter, Off
Hotkey, $^NumpadAdd, Off
Hotkey, $^NumpadSub, Off
Hotkey, $^NumpadMult, Off
Hotkey, $^NumpadDiv, Off

Hotkey, $+1, Off
Hotkey, $+2, Off
Hotkey, $+3, Off
Hotkey, $+4, Off
Hotkey, $+5, Off
Hotkey, $+6, Off
Hotkey, $+7, Off
Hotkey, $+8, Off
Hotkey, $+9, Off
Hotkey, $+0, Off
Hotkey, $+., Off
Hotkey, $+NumpadDot, Off
Hotkey, $+Enter, Off
Hotkey, $+NumpadEnter, Off
Hotkey, $+NumpadAdd, Off
Hotkey, $+NumpadSub, Off
Hotkey, $+NumpadMult, Off
Hotkey, $+NumpadDiv, Off

Hotkey, $!1, Off
Hotkey, $!2, Off
Hotkey, $!3, Off
Hotkey, $!4, Off
Hotkey, $!5, Off
Hotkey, $!6, Off
Hotkey, $!7, Off
Hotkey, $!8, Off
Hotkey, $!9, Off
Hotkey, $!0, Off
Hotkey, $!., Off
Hotkey, $!NumpadDot, Off
Hotkey, $!Enter, Off
Hotkey, $!NumpadEnter, Off
Hotkey, $!NumpadAdd, Off
Hotkey, $!NumpadSub, Off
Hotkey, $!NumpadMult, Off
Hotkey, $!NumpadDiv, Off
return

HotkeyOn:
Hotkey, $1, On
Hotkey, $2, On
Hotkey, $3, On
Hotkey, $4, On
Hotkey, $5, On
Hotkey, $6, On
Hotkey, $7, On
Hotkey, $8, On
Hotkey, $9, On
Hotkey, $0, On
Hotkey, $., On
Hotkey, $NumpadDot, On
Hotkey, $Enter, On
Hotkey, $NumpadEnter, On
Hotkey, $NumpadAdd, On
Hotkey, $NumpadSub, On
Hotkey, $NumpadMult, On
Hotkey, $NumpadDiv, On

Hotkey, $^1, On
Hotkey, $^2, On
Hotkey, $^3, On
Hotkey, $^4, On
Hotkey, $^5, On
Hotkey, $^6, On
Hotkey, $^7, On
Hotkey, $^8, On
Hotkey, $^9, On
Hotkey, $^0, On
Hotkey, $^., On
Hotkey, $^NumpadDot, On
Hotkey, $^Enter, On
Hotkey, $^NumpadEnter, On
Hotkey, $^NumpadAdd, On
Hotkey, $^NumpadSub, On
Hotkey, $^NumpadMult, On
Hotkey, $^NumpadDiv, On

Hotkey, $+1, On
Hotkey, $+2, On
Hotkey, $+3, On
Hotkey, $+4, On
Hotkey, $+5, On
Hotkey, $+6, On
Hotkey, $+7, On
Hotkey, $+8, On
Hotkey, $+9, On
Hotkey, $+0, On
Hotkey, $+., On
Hotkey, $+NumpadDot, On
Hotkey, $+Enter, On
Hotkey, $+NumpadEnter, On
Hotkey, $+NumpadAdd, On
Hotkey, $+NumpadSub, On
Hotkey, $+NumpadMult, On
Hotkey, $+NumpadDiv, On

Hotkey, $!1, On
Hotkey, $!2, On
Hotkey, $!3, On
Hotkey, $!4, On
Hotkey, $!5, On
Hotkey, $!6, On
Hotkey, $!7, On
Hotkey, $!8, On
Hotkey, $!9, On
Hotkey, $!0, On
Hotkey, $!., On
Hotkey, $!NumpadDot, On
Hotkey, $!Enter, On
Hotkey, $!NumpadEnter, On
Hotkey, $!NumpadAdd, On
Hotkey, $!NumpadSub, On
Hotkey, $!NumpadMult, On
Hotkey, $!NumpadDiv, On
return