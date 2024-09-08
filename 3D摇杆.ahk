MouseXY(x,y) ;【鼠标移动】
{
  DllCall("mouse_event",uint,1,int,x,int,y,uint,0,int,0)
}

$Up::
if GetKeyState("Right", "P") and GetKeyState("Left", "P") and GetKeyState("Down", "P")
{
  return
}
$Down::
if GetKeyState("Right", "P") and GetKeyState("Left", "P") and GetKeyState("Up", "P")
{
  return
}
$Left::
if GetKeyState("Up", "P") and GetKeyState("Down", "P") and GetKeyState("Right", "P")
{
  return
}
$Right::
if GetKeyState("Up", "P") and GetKeyState("Down", "P") and GetKeyState("Left", "P")
{
  return
}

HotkeyNow:=StrReplace(A_ThisHotkey,"$")
IniRead, Mode, 软件设置.ini, Mode, Mode
MouseGetPos, , , WinID
WinGetClass, 弹出式窗口ID, ahk_id %WinID%
CoordMode, Mouse, Screen

if (Mode<=1) and (弹出式窗口ID="NX_SURFACE_WND_DIALOG")
{
  触发热键:=StrReplace(A_ThisHotkey,"$")
  Send {%触发热键% Down}
  loop
  {
    Sleep 30
    if !GetKeyState(触发热键, "P")
    {
      break
    }
  }
  return
}

Critical, On
BlockInput On
BlockInput, MouseMove

if (Mode<=2)
{
  Send {Shift Down}
}
else
{
  Send {Shift Up}
}

Send {MButton Down}
CoordMode, Mouse, Screen
MouseGetPos, 中键X, 中键Y
中键计时:=A_TickCount

if (双击计时!=0)
{
  双击检测:=A_TickCount-双击计时
}
else
{
  双击检测:=0
}

幅度:=10
初次按下:=1
换向X:=0
换向Y:=0
换向:=0
if GetKeyState("Left", "P")
{
  方向X:=-1
  MouseMove, -幅度, 0, 0, R
  MouseMove, 幅度, 0, 0, R
}
else if GetKeyState("Right", "P")
{
  方向X:=1
  MouseMove, 幅度, 0, 0, R
  MouseMove, -幅度, 0, 0, R
}
else if GetKeyState("Up", "P")
{
  方向Y:=-1
  MouseMove, 0, -幅度, 0, R
  MouseMove, 0, 幅度, 0, R
}
else if GetKeyState("Down", "P")
{
  方向Y:=1
  MouseMove, 0, 幅度, 0, R
  MouseMove, 0, =幅度, 0, R
}

loop
{
  if GetKeyState("Left", "P") and !GetKeyState("Right", "P")
  {
    if (左右反向=1)
    {
      方向X:=1
    }
    else
    {
      方向X:=-1
    }
  }
  else if GetKeyState("Right", "P") and !GetKeyState("Left", "P")
  {
    if (左右反向=1)
    {
      方向X:=-1
    }
    else
    {
      方向X:=1
    }
  }
  else if GetKeyState("Left", "P") and GetKeyState("Right", "P")
  {
    方向X:=0
  }
  else if !GetKeyState("Left", "P") and !GetKeyState("Right", "P")
  {
    方向X:=0
  }
  
  if GetKeyState("Up", "P") and !GetKeyState("Down", "P")
  {
    if (上下反向=1)
    {
      方向Y:=1
    }
    else
    {
      方向Y:=-1
    }
  }
  else if GetKeyState("Down", "P") and !GetKeyState("Up", "P")
  {
    if (上下反向=1)
    {
      方向Y:=-1
    }
    else
    {
      方向Y:=1
    }
  }
  else if GetKeyState("Up", "P") and GetKeyState("Down", "P")
  {
    方向Y:=0
  }
  else if !GetKeyState("Up", "P") and !GetKeyState("Down", "P")
  {
    方向Y:=0
  }
  
  if (旧方向X!=方向X) and (A_Index!=1)
  {
    方向X记录:=方向X
    换向X:=A_TickCount
  }
  if (旧方向Y!=方向Y) and (A_Index!=1)
  {
    方向Y记录:=方向Y
    换向Y:=A_TickCount
  }
  
  方向X记录:=方向X
  方向Y记录:=方向Y
  
  ;速度
  if (双击检测<250) and (HotkeyNow=HotkeyRecord)
  {
    速度:=10
    
    if (方向X<0)
    {
      方向X:=方向X-4
    }
    else if (方向X>0)
    {
      方向X:=方向X+4
    }
    
    if (方向Y<0)
    {
      方向Y:=方向Y-4
    }
    else if (方向Y>0)
    {
      方向Y:=方向Y+4
    }
  }
  else
  {
    中键耗时:=A_TickCount-中键计时
    if (中键耗时<=1300)
    {
      速度:=15-Floor(中键耗时/(1000/10))
    }
    else
    {
      速度:=2
    }
  }
  
  if (换向X!=0)
  {
    换向X时间:=A_TickCount-换向X
    if (换向X时间<=1000)
    {
      减速度X:=Ceil(5-换向X时间/200)
      if (方向X<=1) and (方向X>0)
      {
        方向X:=1
      }
      else if (方向X>-1) and (方向X<0)
      {
        方向X:=-1
      }
    }
    else
    {
      减速度X:=0
    }
  }
  
  if (换向Y!=0)
  {
    换向Y时间:=A_TickCount-换向Y
    if (换向Y时间<=1000)
    {
      减速度Y:=Ceil(5-换向Y时间/200)
      if (方向Y<=1) and (方向Y>0)
      {
        方向Y:=1
      }
      else if (方向Y>-1) and (方向Y<0)
      {
        方向Y:=-1
      }
    }
    else
    {
      减速度Y:=0
    }
  }
  
  if (换向X!=0) or (换向Y!=0)
  {
    换向:=1
  }
  
  if (换向X!=0) or (换向Y!=0)
  {
    if (减速度X>减速度Y)
    {
      速度:=速度+减速度X
    }
    else if (减速度X<减速度Y)
    {
      速度:=速度+减速度Y
    }
  }
  
  ; ToolTip 当前按键 %HotkeyNow%   历史按键%HotkeyRecord%`n速度 %速度%px`n中键耗时 %中键耗时%ms   双击检测 %双击检测%ms`nX %方向X%   换向X时间 %换向X时间%ms`nY %方向Y%   换向Y时间 %换向Y时间%ms`n旧方向X %旧方向X%   旧方向Y %旧方向Y%`n当前时间 %A_TickCount%`n换向X时间 %换向X%   换向Y时间 %换向Y%
  MouseXY(方向X,方向Y) ;【鼠标移动】
  
  if (方向X>0)
  {
    旧方向X:=1
  }
  else if (方向X<0)
  {
    旧方向X:=-1
  }
  else
  {
    旧方向X:=0
  }
  
  if (方向Y>0)
  {
    旧方向Y:=1
  }
  else if (方向Y<0)
  {
    旧方向Y:=-1
  }
  else
  {
    旧方向Y:=0
  }
  
  DllCall("Winmm\timeBeginPeriod", "UInt", TimePeriod)
  loop %速度%
    DllCall("Sleep", "UInt", SleepDuration)
  
  if !GetKeyState("Left", "P") and !GetKeyState("Right", "P") and !GetKeyState("Up", "P") and !GetKeyState("Down", "P")
  {
    方向X:=0
    方向Y:=0
    DllCall("Winmm\timeEndPeriod", "UInt", TimePeriod)
    
    if (中键耗时<250)
    {
      双击计时:=A_TickCount
    }
    else
    {
      双击计时:=0
    }
    
    break
  }
}
if (Mode<=2)
{
  Send {Shift Up}
}
Send {MButton Up}
MouseMove, 中键X, 中键Y
BlockInput, MouseMoveOff
BlockInput, Off
Critical, Off
if (换向!=1)
{
  HotkeyRecord:=HotkeyNow
}
else
{
  HotkeyRecord:=""
}
return