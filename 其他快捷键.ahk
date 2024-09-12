;Forced Mode 强制模式
#`::
if (FM<0)
{
  FM:=0
  IniWrite, %FM%, 软件设置.ini, Mode, FM
  SetTimer, ForcedModeToolTip, 30
}
else
{
  SetTimer, ForcedModeToolTip, Off
  FM:=-1
  IniWrite, %FM%, 软件设置.ini, Mode, FM
  loop 20
  {
    ToolTip 已关闭强制模式
    Sleep 30
  }
  ToolTip
}
return

#1:: ;数字
FM:=1
IniWrite, %FM%, 软件设置.ini, Mode, FM
return

#2:: ;草图
FM:=2
IniWrite, %FM%, 软件设置.ini, Mode, FM
return

#3:: ;建模
FM:=3
IniWrite, %FM%, 软件设置.ini, Mode, FM
return

ForcedModeToolTip:
if (FM=0)
{
  ToolTip 已打开强制模式`n按下 WIN + 1数字 2草图 3建模 调用
}
else if (FM=1)
{
  ToolTip 已设置为数字模式
}
else if (FM=2)
{
  ToolTip 已设置为草图模式
}
else if (FM=3)
{
  ToolTip 已设置为建模模式
}
return

$Esc::
BlockInput MouseMoveOff
MouseBlockInput:=0
if (Mode!=1)
{
  Send {Esc Down}
  loop
  {
    if !GetKeyState("Esc", "P")
    {
      Send {Esc Up}
      break
    }
    Sleep 10
  }
}
else
{
  Send {MButton}
}
return

~$Space::
SpaceRecord:=A_TickCount
loop
{
  Sleep 30
  if !GetKeyState("Space", "P") or GetKeyState("LButton", "P") or GetKeyState("RButton", "P") or GetKeyState("MButton", "P")
  {
    return
  }
  else if (A_TickCount-SpaceRecord>2000)
  {
    break
  }
}
IniRead, StaticCountRecord, 软件设置.ini, Mode, StaticCountRecord
loop
{
  ToolTip 当前控件数量 %StaticCountRecord% 个`n保持按住空格以写入设置
  Sleep 30
  if !GetKeyState("Space", "P") or GetKeyState("LButton", "P") or GetKeyState("RButton", "P") or GetKeyState("MButton", "P")
  {
    ToolTip
    return
  }
  else if (A_TickCount-SpaceRecord>5000)
  {
    break
  }
}
IniWrite, %StaticCountRecord%, 软件设置.ini, Mode, StaticCountLimit
loop 50
{
  ToolTip 控件数量 %StaticCountRecord% 个 写入完成!
  Sleep 30
}
ToolTip
return

$BackSpace::
BackSpaceRecord:=A_TickCount
loop
{
  Sleep 30
  if !GetKeyState("BackSpace", "P")
  {
    Send {BackSpace}
    break
  }
  else if (A_TickCount-BackSpaceRecord>500)
  {
    Send {del}
    KeyWait, BackSpace
    break
  }
}
return

~$Alt::
if (MouseBlockInput=1)
{
  BlockInput MouseMoveOff
  
  loop
  {
    Sleep 30
    if !GetKeyState("Alt", "P")
    {
      BlockInput MouseMove
      break
    }
  }
}
return