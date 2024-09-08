$Enter::
$NumpadEnter::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  EnterPressTime:=A_TickCount
  loop
  {
    Sleep 30
    if !GetKeyState("Enter", "P") and !GetKeyState("NumpadEnter", "P")
      break
  }
  
  PressDuration:=A_TickCount-EnterPressTime
  if (PressDuration<=500) ;点击
  {
    if (Enter_presses > 0) ; SetTimer 已经启动, 所以我们记录键击.
    {
      Enter_presses += 1
      return
    }
    else ; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动计时器
    {
      Enter_presses := 1
      SetTimer, CEnter, -500 ; 在 500 毫秒内等待更多的键击.
      return
    }
  }
  else if (PressDuration>500) ;长按
  {
    Send {MButton}
    BlockInput MouseMoveOff
    MouseBlockInput:=0
  }
  return
}
else if (Mode=2)
{
  快捷键:=S_Enter
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_Enter
  goto SK
}
return

;Combo Enter
CEnter:
if (Enter_presses = 1) ; 此键按下了一次.
{
  Send {Tab}
  ; ToolTip 单击
}
else if (Enter_presses >= 2) ; 此键按下了两次
{
  Send {Enter}
  BlockInput MouseMoveOff
  MouseBlockInput:=0
  ; ToolTip 双击
}
Enter_presses := 0
return

$1::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG") and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {1 Down}
  loop
  {
    Sleep 30
    if !GetKeyState("1", "P")
      break
  }
  Send {1 Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_1
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_1
  goto SK
}
return

$2::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {2 Down}
  loop
  {
    Sleep 30
    if !GetKeyState("2", "P")
      break
  }
  Send {2 Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_2
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_2
  goto SK
}
return

$3::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {3 Down}
  loop
  {
    Sleep 30
    if !GetKeyState("3", "P")
      break
  }
  Send {3 Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_3
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_3
  goto SK
}
return

$4::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {4 Down}
  loop
  {
    Sleep 30
    if !GetKeyState("4", "P")
      break
  }
  Send {4 Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_4
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_4
  goto SK
}
return

$5::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {5 Down}
  loop
  {
    Sleep 30
    if !GetKeyState("5", "P")
      break
  }
  Send {5 Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_5
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_5
  goto SK
}
return

$6::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {6 Down}
  loop
  {
    Sleep 30
    if !GetKeyState("6", "P")
      break
  }
  Send {6 Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_6
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_6
  goto SK
}
return

$7::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {7 Down}
  loop
  {
    Sleep 30
    if !GetKeyState("7", "P")
      break
  }
  Send {7 Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_7
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_7
  goto SK
}
return

$8::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {8 Down}
  loop
  {
    Sleep 30
    if !GetKeyState("8", "P")
      break
  }
  Send {8 Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_8
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_8
  goto SK
}
return

$9::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {9 Down}
  loop
  {
    Sleep 30
    if !GetKeyState("9", "P")
      break
  }
  Send {9 Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_9
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_9
  goto SK
}
return

$0::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {0 Down}
  loop
  {
    Sleep 30
    if !GetKeyState("0", "P")
      break
  }
  Send {0 Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_0
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_0
  goto SK
}
return

$.::
$NumpadDot::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {. Down}
  loop
  {
    Sleep 30
    if !GetKeyState(".", "P") and !GetKeyState("NumpadDot", "P")
      break
  }
  Send {. Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_Dot
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_Dot
  goto SK
}
return

$NumpadAdd::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {NumpadAdd Down}
  loop
  {
    Sleep 30
    if !GetKeyState("NumpadAdd", "P")
      break
  }
  Send {NumpadAdd Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_PAdd
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_PAdd
  goto SK
}
return

$NumpadSub::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {NumpadSub Down}
  loop
  {
    Sleep 30
    if !GetKeyState("NumpadSub", "P")
      break
  }
  Send {NumpadSub Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_PSub
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_PSub
  goto SK
}
return

$NumpadMult::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {NumpadMult Down}
  loop
  {
    Sleep 30
    if !GetKeyState("NumpadMult", "P")
      break
  }
  Send {NumpadMult Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_PMult
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_PMult
  goto SK
}
return

$NumpadDiv::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (Mode=1) and !GetKeyState("XButton1", "P")
{
  if (AutoLock=1) and (弹出式窗口ID!="NX_SURFACE_WND_DIALOG")
  {
    BlockInput MouseMove
    MouseBlockInput:=1
  }
  Send {NumpadDiv Down}
  loop
  {
    Sleep 30
    if !GetKeyState("NumpadDiv", "P")
      break
  }
  Send {NumpadDiv Up}
  return
}
else if (Mode=2)
{
  快捷键:=S_PDiv
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_PDiv
  goto SK
}
return