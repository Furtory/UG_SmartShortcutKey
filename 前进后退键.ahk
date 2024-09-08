XButton2:: ;前进5
if (SK=1)
{
  return
}
IniRead, Mode, 软件设置.ini, Mode, Mode
Send {MButton Down} ;单击拖动旋转
前进按下:=A_TickCount
if (前进按下-旧前进按下<=250) or (Mode=2) ;双击拖动平移
{
  Send {Shift Down}
}
loop
{
  if !GetKeyState("XButton2", "P")
  {
    if (前进按下-旧前进按下<=250) or (Mode=2)
    {
      Send {Shift Up}
    }
    Send {MButton Up}
    break
  }
  Sleep 10
}
旧前进按下:=前进按下
return

XButton1:: ;后退4
IniRead, Mode, 软件设置.ini, Mode, Mode
滚轮触发:=0
CoordMode, Mouse, Screen
;Initial 初始位置
MouseGetPos, IX, IY
;limit 限制距离
LL:=Round(IX-5*(A_ScreenHeight/1080)) ;Left
LR:=Round(IX+5*(A_ScreenHeight/1080)) ;Right
LT:=Round(IY-5*(A_ScreenHeight/1080)) ;Top
LB:=Round(IY+5*(A_ScreenHeight/1080)) ;Bottom

if GetKeyState("RButton", "P")
{
  BlockInput MouseMove
  MouseMove, -1, 0, 0, R
  Send {LButton}
  Sleep 30
  Send {RButton Up}
  BlockInput MouseMoveOff
  loop
  {
    if !GetKeyState("XButton1", "P")
    {
      return
    }
    
    MouseGetPos, NX, NY
    if (NX>IX+50)
    {
      IX:=NX
      背景样式:=背景样式+1
      IniWrite, %背景样式%, 软件设置.ini, 设置, 背景样式
      if (背景样式>5)
      {
        背景样式:=5
      }
      gosub 背景更换
    }
    else if (NX<IX-50)
    {
      IX:=NX
      背景样式:=背景样式-1
      IniWrite, %背景样式%, 软件设置.ini, 设置, 背景样式
      if (背景样式<1)
      {
        背景样式:=1
      }
      gosub 背景更换
    }
    Sleep 30
  }
}

组合键:=0
后退按下:=A_TickCount
WheelTickCountRecord:=WheelTickCount
loop
{
  MouseGetPos, NX, NY
  if !GetKeyState("XButton1", "P")
  {
    break
  }
  else if (NX<LL) or (NX>LR) or (NY<LT) or (NY>LB) ;有移动
  {
    后退拖动:=1
    Send {Alt Down}
    Send {MButton Down} ;单击拖动屏幕中心旋转
    if (后退按下-旧后退按下<=250) ;双击放大缩小
    {
      Send {Alt Up}
      Send {Ctrl Down}
    }
    loop
    {
      if !GetKeyState("XButton1", "P")
      {
        if (后退按下-旧后退按下<=250)
        {
          Send {Ctrl Up}
        }
        else
        {
          Send {Alt Up}
        }
        Send {MButton Up}
        break
      }
      Sleep 10
    }
    break
  }
  else if (WheelTickCount>WheelTickCountRecord) and (Mode=1)
  {
    WheelTickCountRecord:=WheelTickCount
    Send {Shift Down}
    Send {Tab}
    Send {Shift Up}
    continue
  }
  else if (WheelTickCount<WheelTickCountRecord) and (Mode=1)
  {
    WheelTickCountRecord:=WheelTickCount
    Send {Tab}
    continue
  }
  else if GetKeyState("0", "P") ;复制
  {
    Send {0 Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      SendMode Input
      BlockInput On
      Send {Home}
      Send {Shift Down}
      Send {End}
      Send {Shift Up}
      Sleep 100
      Send {Ctrl Down}
      Sleep 50
      Send {c}
      Send {Ctrl Up}
      BlockInput Off
      SendMode Event
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_P0
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_P0
      gosub SK
    }
    KeyWait, 0
    组合键:=1
    continue
  }
  else if GetKeyState(".", "P") ;黏贴
  {
    Send {. Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      SendMode Input
      BlockInput On
      Send {Home}
      Send {Shift Down}
      Send {End}
      Send {Shift Up}
      Sleep 100
      Send {Ctrl Down}
      Sleep 50
      Send {v}
      Send {Ctrl Up}
      BlockInput Off
      SendMode Event
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_PDot
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_PDot
      gosub SK
    }
    KeyWait, .
    组合键:=1
    continue
  }
  else if GetKeyState("1", "P") ;开头
  {
    Send {1 Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      SendMode Input
      BlockInput On
      Send {Home}
      BlockInput Off
      SendMode Event
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_P1
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_P1
      gosub SK
    }
    KeyWait, 1
    组合键:=1
    continue
  }
  else if GetKeyState("2", "P") ;末尾
  {
    Send {2 Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      SendMode Input
      BlockInput On
      Send {End}
      BlockInput Off
      SendMode Event
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_P2
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_P2
      gosub SK
    }
    KeyWait, 2
    组合键:=1
    continue
  }
  else if GetKeyState("4", "P") ;向左一位
  {
    Send {4 Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      SendMode Input
      BlockInput On
      Send {Left}
      BlockInput Off
      SendMode Event
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_P4
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_P4
      gosub SK
    }
    KeyWait, 4
    组合键:=1
    continue
  }
  else if GetKeyState("5", "P") ;向右一位
  {
    Send {5 Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      SendMode Input
      BlockInput On
      Send {Right}
      BlockInput Off
      SendMode Event
    }
    else if (Mode=2)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      快捷键:=S_X1_P5
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_P5
      gosub SK
    }
    KeyWait, 5
    组合键:=1
    continue
  }
  else if GetKeyState("7", "P") ;左括号
  {
    Send {7 Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      SendMode Input
      BlockInput On
      Send (
      BlockInput Off
      SendMode Event
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_P7
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_P7
      gosub SK
    }
    KeyWait, 7
    组合键:=1
    continue
  }
  else if GetKeyState("8", "P") ;右括号
  {
    Send {8 Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      SendMode Input
      BlockInput On
      Send )
      BlockInput Off
      SendMode Event
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_P8
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_P8
      gosub SK
    }
    KeyWait, 8
    组合键:=1
    continue
  }
  else if GetKeyState("9", "P") ;加
  {
    Send {9 Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      SendMode Input
      BlockInput On
      Send {Text}+
      BlockInput Off
      SendMode Event
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_P9
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_P9
      gosub SK
    }
    KeyWait, 9
    组合键:=1
    continue
  }
  else if GetKeyState("6", "P") ;减
  {
    Send {6 Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      SendMode Input
      BlockInput On
      Send {Text}-
      BlockInput Off
      SendMode Event
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_P6
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_P6
      gosub SK
    }
    KeyWait, 6
    组合键:=1
    continue
  }
  else if GetKeyState("3", "P") ;乘
  {
    Send {3 Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      SendMode Input
      BlockInput On
      Send {Text}*
      BlockInput Off
      SendMode Event
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_P3
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_P3
      gosub SK
    }
    KeyWait, 3
    组合键:=1
    continue
  }
  else if GetKeyState("Enter", "P") ;除
  {
    Send {Enter Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      SendMode Input
      BlockInput On
      Send {Text}/
      BlockInput Off
      SendMode Event
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_PEnter
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_PEnter
      gosub SK
    }
    KeyWait, Enter
    组合键:=1
    continue
  }
  else if GetKeyState("NumpadAdd", "P")
  {
    Send {NumpadAdd Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      Send {Text}+
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_PAdd
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_PAdd
      gosub SK
    }
    KeyWait, NumpadAdd
    组合键:=1
    continue
  }
  else if GetKeyState("NumpadSub", "P")
  {
    Send {NumpadSub Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      Send {Text}-
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_PSub
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_PSub
      gosub SK
    }
    KeyWait, NumpadSub
    组合键:=1
    continue
  }
  else if GetKeyState("NumpadMult", "P")
  {
    Send {NumpadMult Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      Send {Text}*
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_PMult
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_PMult
      gosub SK
    }
    KeyWait, NumpadMult
    组合键:=1
    continue
  }
  else if GetKeyState("NumpadDiv", "P")
  {
    Send {NumpadDiv Up}
    if (Mode=1)
    {
      if (AutoLock=1)
      {
        BlockInput MouseMove
        MouseBlockInput:=1
      }
      Send {Text}/
    }
    else if (Mode=2)
    {
      快捷键:=S_X1_PDiv
      gosub SK
    }
    else if (Mode=3)
    {
      快捷键:=M_X1_PDiv
      gosub SK
    }
    KeyWait, NumpadDiv
    组合键:=1
    continue
  }
  Sleep 30
}

if (组合键=1)
{
  return
}

if (A_TickCount-后退按下<=300) and (后退拖动!=1) ;单击 删除
{
  SetTimer, 单击, -150
}
else if (A_TickCount-后退按下>300) and (后退拖动!=1) ;长按 全部删除
{
  SetTimer, 长按, -1
}
后退拖动:=0
旧后退按下:=后退按下
return

单击:
if !GetKeyState("XButton1", "P")
{
  if (Mode=1)
  {
    Send {Backspace}
  }
  else if (Mode=2)
  {
    Send {Shift Down}
    Send {F8}
    Send {Shift Up}
  }
  else if (Mode=3)
  {
    Send {h}
  }
}
return

长按:
if !GetKeyState("XButton1", "P")
{
  if (Mode=1)
  {
    Send {Home}
    Send {Shift Down}
    Send {End}
    Send {Shift Up}
    Send {Backspace}
  }
  else if (Mode=2)
  {
    
  }
  else if (Mode=3)
  {
    Send {Ctrl Down}
    Send {h}
    Send {Ctrl Up}
  }
}
return

背景更换:
if (背景样式=1)
{
  Send {Ctrl Down}
  Send {6}
  Send {Ctrl Up}
}
else if (背景样式=2)
{
  Send {Ctrl Down}
  Send {7}
  Send {Ctrl Up}
}
else if (背景样式=3)
{
  Send {Ctrl Down}
  Send {9}
  Send {Ctrl Up}
}
else if (背景样式=4)
{
  Send {Ctrl Down}
  Send {0}
  Send {Ctrl Up}
}
else if (背景样式=5)
{
  Send {Ctrl Down}
  Send {8}
  Send {Ctrl Up}
}
return