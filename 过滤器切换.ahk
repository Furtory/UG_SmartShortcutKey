上一个选择过滤器:
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
if (Mode=3)
{
  if (过滤器选择中=0)
  {
    过滤器选择中:=1
    BlockInput MouseMove
    MouseGetPos, GLQX, GLQY
    MouseMove 选择过滤器X, 下拉三角Y, 0
    Sleep 30
    Send {LButton}
    
    gosub 列表识别
    最大建模选择过滤器位置:=最大选择过滤器位置
    
    上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*建模选择过滤器位置
    上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
    MouseMove, 上下移动X, 上下移动Y, 0
    
    return
  }
  
  建模选择过滤器位置:=建模选择过滤器位置-1
  if (建模选择过滤器位置<1)
  {
    建模选择过滤器位置:=最大建模选择过滤器位置
  }
  上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*建模选择过滤器位置
  上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
  MouseMove, 上下移动X, 上下移动Y, 0
}
else if (Mode=2)
{
  if (过滤器选择中=0)
  {
    过滤器选择中:=1
    BlockInput MouseMove
    MouseGetPos, GLQX, GLQY
    MouseMove 选择过滤器X, 下拉三角Y, 0
    Sleep 30
    Send {LButton}
    
    gosub 列表识别
    最大草图选择过滤器位置:=最大选择过滤器位置
    
    上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*草图选择过滤器位置
    上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
    MouseMove, 上下移动X, 上下移动Y, 0
    
    return
  }
  
  草图选择过滤器位置:=草图选择过滤器位置-1
  if (草图选择过滤器位置<1)
  {
    草图选择过滤器位置:=最大草图选择过滤器位置
  }
  上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*草图选择过滤器位置
  上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
  MouseMove, 上下移动X, 上下移动Y, 0
}
return

下一个选择过滤器:
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
if (Mode=3)
{
  if (过滤器选择中=0)
  {
    过滤器选择中:=1
    BlockInput MouseMove
    MouseGetPos, GLQX, GLQY
    MouseMove 选择过滤器X, 下拉三角Y, 0
    Sleep 30
    Send {LButton}
    
    gosub 列表识别
    最大建模选择过滤器位置:=最大选择过滤器位置
    
    上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*建模选择过滤器位置
    上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
    MouseMove, 上下移动X, 上下移动Y, 0
    return
  }
  
  建模选择过滤器位置:=建模选择过滤器位置+1
  if (建模选择过滤器位置>最大建模选择过滤器位置)
  {
    建模选择过滤器位置:=1
  }
  上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*建模选择过滤器位置
  上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
  MouseMove, 上下移动X, 上下移动Y, 0
}
else if (Mode=2)
{
  if (过滤器选择中=0)
  {
    过滤器选择中:=1
    BlockInput MouseMove
    MouseGetPos, GLQX, GLQY
    MouseMove 选择过滤器X, 下拉三角Y, 0
    Sleep 30
    Send {LButton}
    
    gosub 列表识别
    最大草图选择过滤器位置:=最大选择过滤器位置
    
    上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*草图选择过滤器位置
    上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
    MouseMove, 上下移动X, 上下移动Y, 0
    return
  }
  
  草图选择过滤器位置:=草图选择过滤器位置+1
  if (草图选择过滤器位置>最大草图选择过滤器位置)
  {
    草图选择过滤器位置:=1
  }
  上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*草图选择过滤器位置
  上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
  MouseMove, 上下移动X, 上下移动Y, 0
}
return

[::
if GetKeyState("]", "P")
{
  return
}
IniRead, Mode, 软件设置.ini, Mode, Mode
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
loop
{
  if GetKeyState("[", "P") and GetKeyState("]", "P")
  {
    重置选择过滤器:=1
  }
  if !GetKeyState("[", "P")
  {
    break
  }
}
if (下拉三角Y=0) or (下拉三角Y="") or (下拉三角Y="ERROR")
{
  gosub 下拉三角位置获取
}
BlockInput MouseMove
MouseGetPos, GLQX, GLQY
MouseMove 选择过滤器X, 下拉三角Y, 0
Sleep 30
Send {LButton}
if (Mode=3)
{
  gosub 列表识别
  最大建模选择过滤器位置:=最大选择过滤器位置
  
  if (重置选择过滤器=1)
  {
    过滤器选择中:=1
    建模选择过滤器位置:=1
  }
  else
  {
    if (过滤器选择中=0)
    {
      过滤器选择中:=1
    }
    else
    {
      建模选择过滤器位置:=建模选择过滤器位置-1
      if (建模选择过滤器位置<1)
      {
        建模选择过滤器位置:=最大建模选择过滤器位置
      }
    }
  }
  
  上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*建模选择过滤器位置
  上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
  MouseMove, 上下移动X, 上下移动Y, 0
  loop
  {
    Sleep 50
    if (A_Index=30) or GetKeyState("[", "P") or GetKeyState("]", "P") or (重置选择过滤器=1)
    {
      重置选择过滤器:=0
      break
    }
  }
  退出循环:=0
  loop
  {
    Sleep 30
    if GetKeyState("[", "P")
    {
      退出循环:=0
      建模选择过滤器位置:=建模选择过滤器位置-1
      if (建模选择过滤器位置<1)
      {
        建模选择过滤器位置:=最大建模选择过滤器位置
      }
      上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*建模选择过滤器位置
      上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
      MouseMove, 上下移动X, 上下移动Y, 0
      KeyWait [
    }
    else if GetKeyState("]", "P")
    {
      退出循环:=0
      建模选择过滤器位置:=建模选择过滤器位置+1
      if (建模选择过滤器位置>最大建模选择过滤器位置)
      {
        建模选择过滤器位置:=1
      }
      上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*建模选择过滤器位置
      上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
      MouseMove, 上下移动X, 上下移动Y, 0
      KeyWait ]
    }
    
    退出循环:=退出循环+1
    if (退出循环>10)
    {
      break
    }
  }
  Send {LButton}
  Sleep 30
  MouseMove, GLQX, GLQY
  过滤器选择中:=0
}
else if (Mode=2)
{
  gosub 列表识别
  最大草图选择过滤器位置:=最大选择过滤器位置
  
  if (重置选择过滤器=1)
  {
    过滤器选择中:=1
    草图选择过滤器位置:=1
  }
  else
  {
    if (过滤器选择中=0)
    {
      过滤器选择中:=1
    }
    else
    {
      草图选择过滤器位置:=草图选择过滤器位置-1
      if (草图选择过滤器位置<1)
      {
        草图选择过滤器位置:=最大草图选择过滤器位置
      }
    }
  }
  
  上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*草图选择过滤器位置
  上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
  MouseMove, 上下移动X, 上下移动Y, 0
  loop
  {
    Sleep 50
    if (A_Index=30) or GetKeyState("[", "P") or GetKeyState("]", "P") or (重置选择过滤器=1)
    {
      重置选择过滤器:=0
      break
    }
  }
  退出循环:=0
  loop
  {
    Sleep 30
    if GetKeyState("[", "P")
    {
      退出循环:=0
      草图选择过滤器位置:=草图选择过滤器位置-1
      if (草图选择过滤器位置<1)
      {
        草图选择过滤器位置:=最大草图选择过滤器位置
      }
      上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*草图选择过滤器位置
      上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
      MouseMove, 上下移动X, 上下移动Y, 0
      KeyWait [
    }
    else if GetKeyState("]", "P")
    {
      退出循环:=0
      草图选择过滤器位置:=草图选择过滤器位置+1
      if (草图选择过滤器位置>最大草图选择过滤器位置)
      {
        草图选择过滤器位置:=1
      }
      上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*草图选择过滤器位置
      上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
      MouseMove, 上下移动X, 上下移动Y, 0
      KeyWait ]
    }
    
    退出循环:=退出循环+1
    if (退出循环>10)
    {
      break
    }
  }
  Send {LButton}
  Sleep 30
  MouseMove, GLQX, GLQY
  过滤器选择中:=0
}
BlockInput MouseMoveOff
ToolTip
return

]::
if GetKeyState("[", "P")
{
  return
}
IniRead, Mode, 软件设置.ini, Mode, Mode
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
loop
{
  if GetKeyState("[", "P") and GetKeyState("]", "P")
  {
    重置选择过滤器:=1
  }
  if !GetKeyState("]", "P")
  {
    break
  }
}
if (下拉三角Y=0) or (下拉三角Y="") or (下拉三角Y="ERROR")
{
  gosub 下拉三角位置获取
}
BlockInput MouseMove
MouseGetPos, GLQX, GLQY
MouseMove 选择过滤器X, 下拉三角Y, 0
Sleep 30
Send {LButton}
if (Mode=3)
{
  gosub 列表识别
  最大建模选择过滤器位置:=最大选择过滤器位置
  
  if (重置选择过滤器=1)
  {
    过滤器选择中:=1
    建模选择过滤器位置:=1
  }
  else
  {
    if (过滤器选择中=0)
    {
      过滤器选择中:=1
    }
    else
    {
      建模选择过滤器位置:=建模选择过滤器位置+1
      if (建模选择过滤器位置>最大建模选择过滤器位置)
      {
        建模选择过滤器位置:=1
      }
    }
  }
  
  上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*建模选择过滤器位置
  上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
  MouseMove, 上下移动X, 上下移动Y, 0
  loop
  {
    Sleep 50
    if (A_Index=30) or GetKeyState("[", "P") or GetKeyState("]", "P") or (重置选择过滤器=1)
    {
      重置选择过滤器:=0
      break
    }
  }
  退出循环:=0
  loop
  {
    Sleep 30
    if GetKeyState("[", "P")
    {
      退出循环:=0
      建模选择过滤器位置:=建模选择过滤器位置-1
      if (建模选择过滤器位置<1)
      {
        建模选择过滤器位置:=最大建模选择过滤器位置
      }
      上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*建模选择过滤器位置
      上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
      MouseMove, 上下移动X, 上下移动Y, 0
      KeyWait [
    }
    else if GetKeyState("]", "P")
    {
      退出循环:=0
      建模选择过滤器位置:=建模选择过滤器位置+1
      if (建模选择过滤器位置>最大建模选择过滤器位置)
      {
        建模选择过滤器位置:=1
      }
      上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*建模选择过滤器位置
      上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
      MouseMove, 上下移动X, 上下移动Y, 0
      KeyWait ]
    }
    
    退出循环:=退出循环+1
    if (退出循环>10)
    {
      break
    }
  }
  Send {LButton}
  Sleep 30
  MouseMove, GLQX, GLQY
  过滤器选择中:=0
}
else if (Mode=2)
{
  gosub 列表识别
  最大草图选择过滤器位置:=最大选择过滤器位置
  
  if (重置选择过滤器=1)
  {
    过滤器选择中:=1
    草图选择过滤器位置:=1
  }
  else
  {
    if (过滤器选择中=0)
    {
      过滤器选择中:=1
    }
    else
    {
      建模选择过滤器位置:=建模选择过滤器位置+1
      if (草图选择过滤器位置>最大草图选择过滤器位置)
      {
        草图选择过滤器位置:=1
      }
    }
  }
  
  上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*草图选择过滤器位置
  上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
  MouseMove, 上下移动X, 上下移动Y, 0
  loop
  {
    Sleep 50
    if (A_Index=30) or GetKeyState("[", "P") or GetKeyState("]", "P") or (重置选择过滤器=1)
    {
      重置选择过滤器:=0
      break
    }
  }
  退出循环:=0
  loop
  {
    Sleep 30
    if GetKeyState("[", "P")
    {
      退出循环:=0
      草图选择过滤器位置:=草图选择过滤器位置-1
      if (草图选择过滤器位置<1)
      {
        草图选择过滤器位置:=最大草图选择过滤器位置
      }
      上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*草图选择过滤器位置
      上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
      MouseMove, 上下移动X, 上下移动Y, 0
      KeyWait [
    }
    else if GetKeyState("]", "P")
    {
      退出循环:=0
      草图选择过滤器位置:=草图选择过滤器位置+1
      if (草图选择过滤器位置>最大草图选择过滤器位置)
      {
        草图选择过滤器位置:=1
      }
      上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*草图选择过滤器位置
      上下移动X:=选择过滤器X-Round(A_ScreenHeight/1080*20)
      MouseMove, 上下移动X, 上下移动Y, 0
      KeyWait ]
    }
    
    退出循环:=退出循环+1
    if (退出循环>10)
    {
      break
    }
  }
  Send {LButton}
  Sleep 30
  MouseMove, GLQX, GLQY
  过滤器选择中:=0
}
BlockInput MouseMoveOff
ToolTip
return

`;::
IniRead, Mode, 软件设置.ini, Mode, Mode
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
if (下拉三角Y=0) or (下拉三角Y="") or (下拉三角Y="ERROR")
{
  gosub 下拉三角位置获取
}
BlockInput MouseMove
MouseGetPos, GLQX, GLQY
MouseMove 选择范围X, 下拉三角Y, 0
Sleep 30
Send {LButton}
选择范围位置:=选择范围位置-1
if (选择范围位置<1)
{
  选择范围位置:=1
}
上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*选择范围位置
上下移动X:=选择范围X-Round(A_ScreenHeight/1080*20)
MouseMove, 上下移动X, 上下移动Y, 0
Sleep 30
Send {LButton}
Sleep 30
MouseMove, GLQX, GLQY
BlockInput MouseMoveOff
ToolTip
return

'::
IniRead, Mode, 软件设置.ini, Mode, Mode
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
if (下拉三角Y=0) or (下拉三角Y="") or (下拉三角Y="ERROR")
{
  gosub 下拉三角位置获取
}
BlockInput MouseMove
MouseGetPos, GLQX, GLQY
MouseMove 选择范围X, 下拉三角Y, 0
Sleep 30
Send {LButton}
选择范围位置:=选择范围位置+1
if (选择范围位置>3)
{
  选择范围位置:=3
}
上下移动Y:=下拉三角Y+Round(A_ScreenHeight/1080*22)*选择范围位置
上下移动X:=选择范围X-Round(A_ScreenHeight/1080*20)
MouseMove, 上下移动X, 上下移动Y, 0
Sleep 30
Send {LButton}
Sleep 30
MouseMove, GLQX, GLQY
BlockInput MouseMoveOff
ToolTip
return

下拉三角位置获取:
IniRead, Mode, 软件设置.ini, Mode, Mode
ImageSearch 过滤器X, 过滤器Y, 0, 0, A_ScreenWidth, A_ScreenHeight, *1 %A_ScriptDir%\Image\过滤器深色.png
if (ErrorLevel=0)
{
  ToolTip 过滤器深色图标 X%过滤器X% Y%过滤器Y%
}
else
{
  ToolTip 过滤器深色图标获取失败
  Sleep 500
  ImageSearch 过滤器X, 过滤器Y, 0, 0, A_ScreenWidth, A_ScreenHeight, *1 %A_ScriptDir%\Image\过滤器浅色.png
  if (ErrorLevel=0)
  {
    ToolTip 过滤器浅色图标 X%过滤器X% Y%过滤器Y%
  }
  else
  {
    ToolTip 过滤器浅色图标获取失败
  }
}

Sleep 500
if (过滤器X!=0) and (过滤器Y!=0)
{
  ImageSearch 下拉三角X, 下拉三角Y, 过滤器X-40, 过滤器Y-10, 过滤器X+10, 过滤器Y+30, *10 %A_ScriptDir%\Image\下拉三角.png
  if (ErrorLevel=0)
  {
    选择过滤器X:=下拉三角X+Round(A_ScreenHeight/1080*5)
    ToolTip 选择过滤器 %选择过滤器X%
  }
  else
  {
    ToolTip 选择过滤器获取失败
  }
  
  Sleep 500
  ImageSearch 下拉三角X, 下拉三角Y, 过滤器X+150, 过滤器Y-10, 过滤器X+200, 过滤器Y+30, *10 %A_ScriptDir%\Image\下拉三角.png
  if (ErrorLevel=0)
  {
    选择范围X:=下拉三角X+Round(A_ScreenHeight/1080*5)
    ToolTip 选择过滤器 %选择范围X%
  }
  else
  {
    ToolTip 选择范围获取失败
  }
  
  下拉三角Y:=下拉三角Y+Round(A_ScreenHeight/1080*3)
  IniWrite, %下拉三角Y%, 软件设置.ini, 设置, 下拉三角Y
  IniWrite, %选择过滤器X%, 软件设置.ini, 设置, 选择过滤器X
  IniWrite, %选择范围X%, 软件设置.ini, 设置, 选择范围X
}
return

手动下拉三角位置获取:
KeyWait, LButton
loop
{
  ToolTip 请在选择过滤器下拉三角处点击左键以设置
  if GetKeyState("LButton", "P")
  {
    MouseGetPos, 选择过滤器X, 下拉三角Y
    IniWrite, %下拉三角Y%, 软件设置.ini, 设置, 下拉三角Y
    IniWrite, %选择过滤器X%, 软件设置.ini, 设置, 选择过滤器X
    KeyWait, LButton
    break
  }
}
loop
{
  ToolTip 请在选择范围下拉三角处点击左键以设置
  if GetKeyState("LButton", "P")
  {
    MouseGetPos, 选择范围X
    IniWrite, %选择范围X%, 软件设置.ini, 设置, 选择范围X
    break
  }
}
loop 500
{
  ToolTip 选择过滤器设置完成: X%选择过滤器X% Y%下拉三角Y%`n选择范围设置完成: X%选择范围X% Y%下拉三角Y%
  Sleep 30
}
ToolTip
return

列表识别:
CoordMode, Mouse, Screen
CoordMode, ToolTip, Screen
MouseGetPos, 调试MX, 调试MY, 调试WID
WinGetClass, 调试WC, ahk_id %调试WID%
WinGetPos, 调试WX, 调试WY, 调试WW, 调试WH, ahk_id %调试WID%
最大选择过滤器位置:=Floor(调试WH/(A_ScreenHeight/1080*22))
return