Process, Priority, , Realtime
#NoTrayIcon
#MenuMaskKey vkE8
#Persistent
#SingleInstance Force
#MaxHotkeysPerInterval 2000
#KeyHistory 2000
SetBatchLines, -1

IniRead, Mode, 软件设置.ini, Mode, Mode
IniRead, StaticCountLimit, 软件设置.ini, Mode, StaticCountLimit
OldMode:=Mode
刷新阈值:=1
阈值写入校验:=0

;Get Mode
loop
{
  SearchRecord:=A_TickCount
  IniRead, ModeSearch, 软件设置.ini, Mode, ModeSearch
  if (ModeSearch=0)
  {
    If (WinExist("调试窗口")!=0)
    {
      WinGet, 调试窗口ID, ID , 调试窗口
      WinGetPos 调试窗口X, 调试窗口Y, , , ahk_id %调试窗口ID%
      IniWrite, %调试窗口X%, 软件设置.ini, Mode, 调试窗口X
      IniWrite, %调试窗口Y%, 软件设置.ini, Mode, 调试窗口Y
    }
    ExitApp
  }
  
  IniRead, FM, 软件设置.ini, Mode, FM
  if (FM>0)
  {
    Mode:=FM
    if (OldMode!=Mode)
    {
      IniWrite, %Mode%, 软件设置.ini, Mode, Mode
      OldMode:=Mode
    }
    ToolTip, , , , 3
  }
  else
  {
    MouseGetPos, MX, MY, WinID
    
    ;获取控件数量
    WinGet, ControlList, ControlList, ahk_id %WinID%
    WinGetClass, 弹出式窗口ID, ahk_id %WinID%
    
    StaticCountRecord:=StaticCount
    StaticCount:=0
    Loop, % StrLen(ControlList)
    {
      if (SubStr(ControlList, A_Index, 6) = "Static")
      {
        StaticCount++
      }
    }
    
    ;控件匹配
    if (WinExist("ahk_class NX_SURFACE_WND_DIALOG")!=0) ;必须弹出窗口才智能匹配 在等待窗口关闭后校验
    {
      刷新阈值:=1
    }
    IniRead, StaticSearch, 软件设置.ini, Mode, StaticSearch
    IniRead, SmartStaticSearch, 软件设置.ini, Mode, SmartStaticSearch
    if (SmartStaticSearch=1) and (刷新阈值=1) and (WinExist("ahk_class NX_SURFACE_WND_DIALOG")=0) ;弹出窗口时候不进行智能匹配
    {
      ; ToolTip Smart Static Search Record Done!
      if (StaticCount=StaticCountRecord)
        阈值写入校验:=阈值写入校验+1
      else if (StaticCount!=StaticCountRecord)
        阈值写入校验:=0
      
      if (阈值写入校验>=15)
      {
        ; MsgBox 阈值写入校验
        StaticCountLimit:=StaticCount
        IniWrite, %StaticCountLimit%, 软件设置.ini, Mode, StaticCountLimit
        阈值写入校验:=0
        刷新阈值:=0
      }
    }
    else ;手动模式
    {
      IniRead, StaticCountLimit, 软件设置.ini, Mode, StaticCountLimit
    }
    
    ;记录控件数量历史
    if (StaticCount!=StaticCountRecord)
    {
      StaticCountRecord:=StaticCount
      IniWrite, %StaticCountRecord%, 软件设置.ini, Mode, StaticCountRecord
    }
    
    ;匹配模式
    if (StaticCount>StaticCountLimit) and (StaticSearch=1)
    {
      Mode:=1 ;数字
      匹配项:="控件"
    }
    else if (InStr(ControlList, "Static")=0) and (StaticSearch!=1)
    {
      CoordMode Pixel Screen
      ImageSearch, NX, NY, MX-150, MY-150, MX+250, MY+250, *10 %A_ScriptDir%\Number.png
      if (ErrorLevel=0) and (MX>NX-100) and (MX<NX+100) and (MY>NY-100) and (MY<NY+100)
      {
        Mode:=1 ;数字
        匹配项:="图片"
      }
    }
    else if (弹出式窗口ID="NX_SURFACE_WND_DIALOG")
    {
      Mode:=1 ;数字
      匹配项:="窗口"
    }
    else IfWinExist, NX - 草图
    {
      Mode:=2 ;草图
      匹配项:="标题"
    }
    else IfWinExist, NX - 建模
    {
      Mode:=3 ;建模
      匹配项:="标题"
    }
    else
    {
      Mode:=-1 ;无法识别
      匹配项:="无法识别"
    }
    
    if (OldMode!=Mode)
    {
      IniWrite, %Mode%, 软件设置.ini, Mode, Mode
      OldMode:=Mode
    }
  }
  
  SearchTime:=A_TickCount-SearchRecord
  if (SearchTime<30)
  {
    Sleep 30-SearchTime
  }
  
  IniRead, 调试模式, 软件设置.ini, 设置, 调试模式
  if (调试模式=1)
  {
    CoordMode, Mouse, Screen
    CoordMode, ToolTip, Screen
    MouseGetPos, 调试MX, 调试MY, 调试WID
    WinGetClass, 调试WC, ahk_id %调试WID%
    WinGet, 调试EXE, ProcessName, ahk_id %调试WID%
    WinGetPos, 调试WX, 调试WY, 调试WW, 调试WH, ahk_id %调试WID%
    ToolTip 耗时%SearchTime%ms`n模式%Mode%`n匹配项:%匹配项%`n控件数量:%StaticCount% 识别阈值:%StaticCountLimit%`nX %调试MX%   Y%调试MY%`nID:%调试WID%`nClass:%调试WC%`nX%调试WX% Y%调试WY% W%调试WW% H%调试WH%, 调试MX+150, 调试MY-10, 3
    
    If (WinExist("调试窗口")!=0)
    {
      if (暂停=0) and (调试EXE="ugraf.exe")
      {
        控件名单:=ControlList
        GuiControl, 调试窗口:Text, 控件名单, %控件名单%
      }
    }
    else
    {
      暂停:=0
      控件名单:=ControlList
      Gui 调试窗口:+DPIScale -MinimizeBox -MaximizeBox -Resize -SysMenu +AlwaysOnTop
      Gui 调试窗口:Font, s9, Segoe UI
      Gui 调试窗口:Add, Edit, x8 y6 w652 h951 v控件名单, %控件名单%
      Gui 调试窗口:Add, Button, Default x581 y968 w80 h23 g调试控制, 暂停
      Gui 调试窗口:Show, w669 h1002, 调试窗口
      WinGet, 调试窗口ID, ID , 调试窗口
      
      IniRead, 调试窗口X, 软件设置.ini, Mode, 调试窗口X
      IniRead, 调试窗口Y, 软件设置.ini, Mode, 调试窗口Y
      Loop
      {
        Sleep 30
        If (WinExist("调试窗口")!=0)
        {
          WinMove ahk_id %调试窗口ID%, , 调试窗口X, 调试窗口Y
          WinGetPos, 调试窗口检测X, 调试窗口检测Y, , , ahk_id %调试窗口ID%
          ; ToolTip ID%调试窗口ID%`n调试窗口检测X%调试窗口检测X% 调试窗口X%调试窗口X%`n调试窗口检测Y%调试窗口检测Y% 调试窗口Y%调试窗口Y%
          if (调试窗口检测X=调试窗口X) and (调试窗口检测Y=调试窗口Y)
          {
            break
          }
          else if (调试窗口X="") or (调试窗口X="ERROR") or (调试窗口Y="") or (调试窗口Y="ERROR")
          {
            break
          }
        }
      }
    }
  }
  else
  {
    ToolTip, , , , 3
    
    If (WinExist("调试窗口")!=0)
    {
      WinGet, 调试窗口ID, ID , 调试窗口
      WinGetPos 调试窗口X, 调试窗口Y, , , ahk_id %调试窗口ID%
      IniWrite, %调试窗口X%, 软件设置.ini, Mode, 调试窗口X
      IniWrite, %调试窗口Y%, 软件设置.ini, Mode, 调试窗口Y
      ; ToolTip ID%调试窗口ID%`n调试窗口检测X%调试窗口检测X% 调试窗口X%调试窗口X%`n调试窗口检测Y%调试窗口检测Y% 调试窗口Y%调试窗口Y%Q
      Gui, 调试窗口:Destroy
    }
  }
}
return

调试控制:
if (暂停=1)
{
  暂停:=0
  GuiControl, 调试窗口:Text, 继续, 暂停
}
else
{
  暂停:=1
  GuiControl, 调试窗口:Text, 暂停, 继续
}
return