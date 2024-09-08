~$LButton:: ;左键
BlockInput MouseMoveOff
MouseBlockInput:=0
if GetKeyState("RButton", "P")
{
  Send {LButton Up}
}
else
{
  IniRead, Mode, 软件设置.ini, Mode, Mode
  return
}

$MButton:: ;中键
if GetKeyState("XButton1", "P") or GetKeyState("XButton2", "P")
{
  Send {MButton}
  return
}
IniRead, Mode, 软件设置.ini, Mode, Mode

CoordMode, Mouse, Screen
;Initial 初始位置
MouseGetPos, IX, IY
;limit 限制距离
LL:=Round(IX-50*(A_ScreenHeight/1080)) ;Left
LR:=Round(IX+50*(A_ScreenHeight/1080)) ;Right
LT:=Round(IY-50*(A_ScreenHeight/1080)) ;Top
LB:=Round(IY+50*(A_ScreenHeight/1080)) ;Bottom

;ToolTip Direction 提示方向
TTD:=0
快捷键设置:=0
过滤器选择中:=0
KeyDownTime:=A_TickCount
WheelTickCountRecord:=WheelTickCount
loop
{
  MouseGetPos, NX, NY
  
  if (WheelTickCount>WheelTickCountRecord)
  {
    WheelTickCountRecord:=WheelTickCount
    gosub 上一个选择过滤器
  }
  else if (WheelTickCount<WheelTickCountRecord)
  {
    WheelTickCountRecord:=WheelTickCount
    gosub 下一个选择过滤器
  }
  
  if (过滤器选择中!=1)
  {
    gosub GTT
  }
  
  Sleep 30
  KeyPressTime:=A_TickCount-KeyDownTime
  if !GetKeyState("LButton", "P") and !GetKeyState("RButton", "P") and !GetKeyState("MButton", "P") ;抬起按键
  {
    ToolTip
    ToolTip, , , ,2
    break
  }
  else if (WinExist("快捷键设置")!=0)
  {
    Continue
  }
  else if (KeyPressTime>1000) and (快捷键设置=0) and !GetKeyState("LButton", "P") and !GetKeyState("RButton", "P") and !GetKeyState("MButton", "P")
  {
    ToolTip
    ToolTip, , , ,2
    快捷键设置:=1
    快捷键:=StrSplit(快捷键,"|")
    快捷键配置:=快捷键[1]
    功能说明:=快捷键[2]
    goto 快捷键设置
  }
}

if (TTD=-3) ;取消释放
{
  return
}
else if (过滤器选择中=1)
{
  Send {LButton}
  Sleep 30
  MouseMove, GLQX, GLQY
  BlockInput MouseMoveOff
  MouseBlockInput:=0
  过滤器选择中:=0
  return
}
else if (TTD=0)
{
  PressDuration:=A_TickCount-KeyDownTime
  if (PressDuration<=500) ;点击
  {
    TTD:=-1
    if (GM=1)
    {
      if (Mode=2) ;草图
      {
        快捷键:=S_G_LRC
        触发热键提示:="右键加左键点击"
      }
      else if (Mode=3) ;建模
      {
        快捷键:=M_G_LRC
        触发热键提示:="右键加左键点击"
      }
    }
    else if (GM=2)
    {
      if (Mode=2) ;草图
      {
        快捷键:=S_G_MC
        触发热键提示:="中键点击"
      }
      else if (Mode=3) ;建模
      {
        快捷键:=M_G_MC
        触发热键提示:="中键点击"
      }
    }
  }
  else if (PressDuration>500) ;长按
  {
    TTD:=-2
    if (GM=1)
    {
      if (Mode=2) ;草图
      {
        快捷键:=S_G_LRP
        触发热键提示:="右键加左键长按"
      }
      else if (Mode=3) ;建模
      {
        快捷键:=M_G_LRP
        触发热键提示:="右键加左键长按"
      }
    }
    else if (GM=2)
    {
      if (Mode=2) ;草图
      {
        快捷键:=S_G_MP
        触发热键提示:="中键长按"
      }
      else if (Mode=3) ;建模
      {
        快捷键:=M_G_MP
        触发热键提示:="中键长按"
      }
    }
  }
  
  if GetKeyState("Space", "P")
  {
    ToolTip
    ToolTip, , , ,2
    快捷键设置:=1
    快捷键:=StrSplit(快捷键,"|")
    快捷键配置:=快捷键[1]
    功能说明:=快捷键[2]
    goto 快捷键设置
  }
}
gosub SK
GM:=0
return

~RButton:: ;右键
IniRead, Mode, 软件设置.ini, Mode, Mode
loop
{
  Sleep 30
  if !GetKeyState("RButton", "P")
  {
    break
  }
}
if (RButton_presses > 0) ; SetTimer 已经启动, 所以我们记录键击.
{
  RButton_presses += 1
  return
}
else ; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动计时器
{
  RButton_presses := 1
  SetTimer, CRButton, -500 ; 在 500 毫秒内等待更多的键击.
  return
}

;Combo RButton
CRButton:
if (RButton_presses = 1) ; 此键按下了一次.
{
  ; ToolTip 单击
}
else if (RButton_presses = 2) ; 此键按下了两次 撤回
{
  BlockInput MouseMove
  MouseBlockInput:=1
  MouseMove, -1, 0, 0, R
  Send {LButton}
  Sleep 30
  Send {Ctrl Down}
  Send {z}
  Send {Ctrl Up}
  BlockInput MouseMoveOff
  MouseBlockInput:=0
  ; ToolTip 双击
}
else if (RButton_presses > 2) ; 此键按下了三次及以上 还原
{
  BlockInput MouseMove
  MouseBlockInput:=1
  MouseMove, -1, 0, 0, R
  Send {LButton}
  Sleep 30
  Send {Ctrl Down}
  Send {y}
  Send {Ctrl Up}
  BlockInput MouseMoveOff
  MouseBlockInput:=0
  ; ToolTip 三连击
}
RButton_presses := 0
return