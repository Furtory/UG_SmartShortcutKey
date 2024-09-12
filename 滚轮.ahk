$WheelUp:: ;滚轮上
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (弹出式窗口ID="NX_SURFACE_WND_DIALOG")
{
  Send {Shift Down}
  Send {Tab}
  Send {Shift Up}
}
else if (Mode=1) or GetKeyState("XButton1", "P")
{
  if (MouseBlockInput!=1)
  {
    Send {WheelUp}
    return
  }
  
  Send {Left}
  if (WheelUp_presses > 0) ; SetTimer 已经启动, 所以我们记录键击.
  {
    WheelUp_presses += 1
    return
  }
  else ; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动计时器
  {
    WheelUp_presses := 1
    SetTimer, CWheelUp, -300 ; 在 350 毫秒内等待更多的键击.
    return
  }
}
else if GetKeyState("MButton", "P")
{
  WheelTickCount:=WheelTickCount+1
}
else
{
  Send {WheelUp}
}
return

CWheelUp:
if (WheelUp_presses >= 3) ; 此键按下了三次及以上.
{
  Send {Home}
  Sleep 200
  ; ToolTip 三连击
}
WheelUp_presses := 0
return

$WheelDown:: ;滚轮下
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
if (弹出式窗口ID="NX_SURFACE_WND_DIALOG")
{
  Send {Tab}
}
else if (Mode=1) or GetKeyState("XButton1", "P")
{
  if (MouseBlockInput!=1)
  {
    Send {WheelDown}
    return
  }
  
  Send {Right}
  if (WheelDown_presses > 0) ; SetTimer 已经启动, 所以我们记录键击.
  {
    WheelDown_presses += 1
    return
  }
  else ; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动计时器
  {
    WheelDown_presses := 1
    SetTimer, CWheelDown, -300 ; 在 350 毫秒内等待更多的键击.
    return
  }
}
else if GetKeyState("MButton", "P")
{
  WheelTickCount:=WheelTickCount-1
}
else
{
  Send {WheelDown}
}
return

CWheelDown:
if (WheelDown_presses >= 3) ; 此键按下了三次及以上.
{
  Send {End}
  Sleep 200
  ; ToolTip 三连击
}
WheelDown_presses := 0
return

WheelLeft:: ;滚轮左
if (A_TickCount-WheelLeftRecord<=200)
{
  WheelLeftRecord:=A_TickCount
  return
}
GM:=-1
快捷键:="^z|撤回"
gosub SK
GM:=0
WheelLeftRecord:=A_TickCount
return

WheelRight:: ;滚轮右
if (A_TickCount-WheelRightRecord<=200)
{
  WheelRightRecord:=A_TickCount
  return
}
GM:=-1
快捷键:="^y|还原"
gosub SK
GM:=0
WheelRightRecord:=A_TickCount
return