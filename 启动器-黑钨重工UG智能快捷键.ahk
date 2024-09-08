full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
  try
  {
    if A_IsCompiled
      Run *RunAs "%A_ScriptFullPath%" /restart
    else
      Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
  }
  ExitApp
}

Menu, Tray, Icon, %A_ScriptDir%\LOGO.ico
Process, Priority, , Realtime
#MenuMaskKey vkE8
#Persistent
#SingleInstance Force
#MaxHotkeysPerInterval 2000
#KeyHistory 2000
SetBatchLines, -1
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SetKeyDelay, 30, 50

/*
UG NX 12.0+
1.按下Ctrl + 2
2.选择角色并导入MTX文件
*/

; Menu, Tray, NoStandard ;不显示默认的AHK右键菜单
Menu, Tray, Add
Menu, Tray, Add, 调试模式, 调试模式
Menu, Tray, Add, 控件匹配, 控件匹配
Menu, Tray, Add, 控件智能匹配, 控件智能匹配
Menu, Tray, Add, 过滤器位置, 手动下拉三角位置获取
Menu, Tray, Add
Menu, Tray, Add, 3D摇杆, 3D摇杆
Menu, Tray, Add, Z轴旋转, Z轴旋转 ;添加新的右键菜单
Menu, Tray, Add, 上下反向, 上下反向 ;添加新的右键菜单
Menu, Tray, Add, 左右反向, 左右反向 ;添加新的右键菜单
Menu, Tray, Add
Menu, Tray, Add, 配置文件, 配置文件
Menu, Tray, Add, 按键提示, 按键提示
Menu, Tray, Add, 自动锁定, 自动锁定
Menu, Tray, Add
Menu, Tray, Add, 开机自启, 开机自启 ;添加新的右键菜单
autostartLnk:=A_StartupCommon . "\FurtoryAutoShortcutKeyForUG.lnk" ;开机启动文件的路径
IfExist, % autostartLnk ;检查开机启动的文件是否存在
{
  FileGetShortcut, %autostartLnk%, lnkTarget ;获取开机启动文件的信息
  if (lnkTarget!=A_ScriptFullPath) ;如果启动文件执行的路径和当前脚本的完整路径不一致
  {
    FileCreateShortcut, %A_ScriptFullPath%, %autostartLnk%, %A_WorkingDir% ;将启动文件执行的路径改成和当前脚本的完整路径一致
  }
  
  autostart:=1
  Menu, Tray, Check, 开机自启 ;右键菜单打勾
}
else
{
  autostart:=0
  Menu, Tray, UnCheck, 开机自启 ;右键菜单不打勾
}
Menu, Tray, Add, 暂停软件, 暂停数字
Menu, Tray, Add, 重启软件, 重启软件
Menu, Tray, Add, 退出软件, 退出软件

gosub ReadSK

IniRead, 3D摇杆, 软件设置.ini, 设置, 3D摇杆
if (3D摇杆="ERROR") or (3D摇杆="")
{
  3D摇杆:=0
  IniWrite, %3D摇杆%, 软件设置.ini, 设置, 3D摇杆
}
else if (3D摇杆=1)
{
  Menu, Tray, Check, 3D摇杆 ;右键菜单打勾
  Menu, Tray, Icon, %A_ScriptDir%\3DLOGO.ico
}
else
{
  Hotkey, $Left, Off
  Hotkey, $Right, Off
  Hotkey, $Up, Off
  Hotkey, $Down, Off
}

IniRead, 调试模式, 软件设置.ini, 设置, 调试模式
if (调试模式="ERROR") or (调试模式="")
{
  调试模式:=0
  IniWrite, %调试模式%, 软件设置.ini, 设置, 调试模式
}
else if (调试模式=1)
{
  Menu, Tray, Check, 调试模式 ;右键菜单打勾
}

IniRead, AutoLock, 软件设置.ini, 设置, AutoLock
if (AutoLock="ERROR") or (AutoLock="")
{
  AutoLock:=0
  IniWrite, %AutoLock%, 软件设置.ini, 设置, AutoLock
}
else if (AutoLock=1)
{
  Menu, Tray, Check, 自动锁定 ;右键菜单打勾
}

IniRead, StaticSearch, 软件设置.ini, Mode, StaticSearch
if (StaticSearch="ERROR") or (StaticSearch="")
{
  StaticSearch:=1
  IniWrite, %StaticSearch%, 软件设置.ini, Mode, StaticSearch
}
else if (StaticSearch=1)
{
  Menu, Tray, Check, 控件匹配 ;右键菜单打勾
}

IniRead, SmartStaticSearch, 软件设置.ini, Mode, SmartStaticSearch
if (SmartStaticSearch="ERROR") or (SmartStaticSearch="")
{
  SmartStaticSearch:=1
  IniWrite, %SmartStaticSearch%, 软件设置.ini, Mode, SmartStaticSearch
}
else if (SmartStaticSearch=1)
{
  Menu, Tray, Check, 控件智能匹配 ;右键菜单打勾
}
else
{
  Hotkey, ~$Space, Off
}

IniRead, KeyToolTip, 软件设置.ini, 设置, KeyToolTip
if (KeyToolTip="ERROR") or (KeyToolTip="")
{
  KeyToolTip:=1
  IniWrite, %KeyToolTip%, 软件设置.ini, 设置, KeyToolTip
}
else if (KeyToolTip=1)
{
  Menu, Tray, Check, 按键提示 ;右键菜单打勾
}

IniRead, 背景样式, 软件设置.ini, 设置, 背景样式
if (背景样式="ERROR") or (背景样式="")
{
  背景样式:=1
  IniWrite, %背景样式%, 软件设置.ini, 设置, 背景样式
}

IfExist, %A_ScriptDir%\软件设置.ini ;如果配置文件存在则读取
{
  IniRead, 下拉三角Y, 软件设置.ini, 设置, 下拉三角Y
  IniRead, 选择过滤器X, 软件设置.ini, 设置, 选择过滤器X
  IniRead, 选择范围X, 软件设置.ini, 设置, 选择范围X
}
草图选择过滤器位置:=1
建模选择过滤器位置:=1
选择范围位置:=1
过滤器选择中:=0

IfExist, %A_ScriptDir%\摇杆设置.ini ;如果配置文件存在则读取
{
  IniRead, 自动切换, 摇杆设置.ini, 设置, 自动切换
  IniRead, 旋转Y, 摇杆设置.ini, 设置, 旋转Y
  IniRead, 上下反向, 摇杆设置.ini, 设置, 上下反向
  if (上下反向)
  {
    Menu, Tray, Check, 上下反向 ;右键菜单打勾
  }
  IniRead, 左右反向, 摇杆设置.ini, 设置, 左右反向
  if (左右反向)
  {
    Menu, Tray, Check, 左右反向 ;右键菜单打勾
  }
}
else
{
  自动切换:=0
  IniWrite, %自动切换%, 摇杆设置.ini, 设置, 自动切换
  上下反向:=0
  IniWrite, %上下反向%, 摇杆设置.ini, 设置, 上下反向
  左右反向:=0
  IniWrite, %左右反向%, 摇杆设置.ini, 设置, 左右反向
}
摇杆:=1
双击计时:=0
SleepDuration := 1  ; 这里有时可以根据下面的值进行细微调整(例如 2 与 3 的区别).
TimePeriod := 3 ; 尝试 7 或 3. 请参阅下面的注释.

GM:=0
SK:=0
TTD:=0
后退拖动:=0
WheelTickCount:=0
旧前进按下:=A_TickCount
旧后退按下:=A_TickCount
暂停数字:=0
MouseBlockInput:=0

ModeSearch:=1
IniWrite, %ModeSearch%, 软件设置.ini, Mode, ModeSearch
Run, %A_ScriptDir%\模式识别.ahk, , ,模式识别ID
; ToolTip 模式识别ID%模式识别ID%
Sleep 100
IniRead, Mode, 软件设置.ini, Mode, Mode
Return

;=================================================================
开机自启: ;模式切换
Critical, On
if (autostart=1) ;关闭开机自启动
{
  IfExist, % autostartLnk ;如果开机启动的文件存在
  {
    FileDelete, %autostartLnk% ;删除开机启动的文件
  }
  
  autostart:=0
  Menu, Tray, UnCheck, 开机自启 ;右键菜单不打勾
}
else ;开启开机自启动
{
  IfExist, % autostartLnk ;如果开机启动的文件存在
  {
    FileGetShortcut, %autostartLnk%, lnkTarget ;获取开机启动文件的信息
    if (lnkTarget!=A_ScriptFullPath) ;如果启动文件执行的路径和当前脚本的完整路径不一致
    {
      FileCreateShortcut, %A_ScriptFullPath%, %autostartLnk%, %A_WorkingDir% ;将启动文件执行的路径改成和当前脚本的完整路径一致
    }
  }
  else ;如果开机启动的文件不存在
  {
    FileCreateShortcut, %A_ScriptFullPath%, %autostartLnk%, %A_WorkingDir% ;创建和当前脚本的完整路径一致的启动文件
  }
  
  autostart:=1
  Menu, Tray, Check, 开机自启 ;右键菜单打勾
}
Critical, Off
return

配置文件:
Run, %A_ScriptDir%\快捷键设置.ini
return

$^Down::
3D摇杆:
Critical, On
if (3D摇杆=1)
{
  3D摇杆:=0
  Hotkey, $Left, Off
  Hotkey, $Right, Off
  Hotkey, $Up, Off
  Hotkey, $Down, Off
  IniWrite, %3D摇杆%, 软件设置.ini, 设置, 3D摇杆
  Menu, Tray, UnCheck, 3D摇杆 ;右键菜单不打勾
  Menu, Tray, Icon, %A_ScriptDir%\LOGO.ico
  loop 50
  {
    ToolTip 已关闭摇杆功能
    Sleep 30
  }
}
else
{
  3D摇杆:=1
  Hotkey, $Left, On
  Hotkey, $Right, On
  Hotkey, $Up, On
  Hotkey, $Down, On
  IniWrite, %3D摇杆%, 软件设置.ini, 设置, 3D摇杆
  Menu, Tray, Check, 3D摇杆 ;右键菜单打勾
  Menu, Tray, Icon, %A_ScriptDir%\3DLOGO.ico
  loop 50
  {
    ToolTip 已打开摇杆功能
    Sleep 30
  }
}
ToolTip
Critical, Off
return

上下反向:
Critical, On
if (上下反向=1)
{
  上下反向:=0
  Menu, Tray, UnCheck, 上下反向 ;右键菜单不打勾
  IniWrite, %上下反向%, 摇杆设置.ini, 设置, 上下反向
}
else ;开启开机自启动
{
  上下反向:=1
  Menu, Tray, Check, 上下反向 ;右键菜单打勾
  IniWrite, %上下反向%, 摇杆设置.ini, 设置, 上下反向
}
Critical, Off
return

左右反向:
Critical, On
if (左右反向=1)
{
  左右反向:=0
  Menu, Tray, UnCheck, 左右反向 ;右键菜单不打勾
  IniWrite, %左右反向%, 摇杆设置.ini, 设置, 左右反向
}
else ;开启开机自启动
{
  左右反向:=1
  Menu, Tray, Check, 左右反向 ;右键菜单打勾
  IniWrite, %左右反向%, 摇杆设置.ini, 设置, 左右反向
}
Critical, Off
return

Z轴旋转:
KeyWait, LButton
loop
{
  ToolTip 请在Z轴旋转处点击左键以设置
  if GetKeyState("LButton", "P")
  {
    MouseGetPos, , 旋转Y
    IniWrite, %旋转Y%, 摇杆设置.ini, 设置, 旋转Y
    break
  }
}
loop 100
{
  ToolTip Z轴旋转处设置完成 Y%旋转Y%
  Sleep 30
}
ToolTip
return

暂停数字:
Critical, On
if (暂停数字=1)
{
  gosub HotkeyOn
  暂停数字:=0
  IniWrite, %暂停数字%, 软件设置.ini, 设置, 暂停数字
  Menu, Tray, UnCheck, 暂停软件 ;右键菜单不打勾
}
else
{
  gosub HotkeyOff
  暂停数字:=1
  IniWrite, %暂停数字%, 软件设置.ini, 设置, 暂停数字
  Menu, Tray, Check, 暂停软件 ;右键菜单打勾
}
Critical, Off
return

调试模式:
Critical, On
if (调试模式=1)
{
  调试模式:=0
  IniWrite, %调试模式%, 软件设置.ini, 设置, 调试模式
  Menu, Tray, UnCheck, 调试模式 ;右键菜单不打勾
}
else
{
  调试模式:=1
  IniWrite, %调试模式%, 软件设置.ini, 设置, 调试模式
  Menu, Tray, Check, 调试模式 ;右键菜单打勾
}
Critical, Off
return

自动锁定:
Critical, On
if (AutoLock=1)
{
  AutoLock:=0
  IniWrite, %AutoLock%, 软件设置.ini, 设置, AutoLock
  Menu, Tray, UnCheck, 自动锁定 ;右键菜单不打勾
}
else
{
  AutoLock:=1
  IniWrite, %AutoLock%, 软件设置.ini, 设置, AutoLock
  Menu, Tray, Check, 自动锁定 ;右键菜单打勾
}
Critical, Off
return

F12::
控件匹配:
Critical, On
if (StaticSearch=1)
{
  StaticSearch:=0
  IniWrite, %StaticSearch%, 软件设置.ini, Mode, StaticSearch
  Menu, Tray, UnCheck, 控件匹配 ;右键菜单不打勾
  
  
  if (SmartStaticSearch=1)
  {
    SmartStaticSearch:=0
    IniWrite, %SmartStaticSearch%, 软件设置.ini, Mode, SmartStaticSearch
    Menu, Tray, UnCheck, 控件智能匹配 ;右键菜单不打勾
  }
}
else
{
  StaticSearch:=1
  IniWrite, %StaticSearch%, 软件设置.ini, Mode, StaticSearch
  Menu, Tray, Check, 控件匹配 ;右键菜单打勾
}
Critical, Off
return

控件智能匹配:
Critical, On
if (SmartStaticSearch=1)
{
  Hotkey, ~$Space, Off
  SmartStaticSearch:=0
  IniWrite, %SmartStaticSearch%, 软件设置.ini, Mode, SmartStaticSearch
  Menu, Tray, UnCheck, 控件智能匹配 ;右键菜单不打勾
}
else
{
  Hotkey, ~$Space, On
  SmartStaticSearch:=1
  IniWrite, %SmartStaticSearch%, 软件设置.ini, Mode, SmartStaticSearch
  Menu, Tray, Check, 控件智能匹配 ;右键菜单打勾
}
Critical, Off
return

按键提示:
Critical, On
if (KeyToolTip=1)
{
  KeyToolTip:=0
  IniWrite, %KeyToolTip%, 软件设置.ini, 设置, KeyToolTip
  Menu, Tray, UnCheck, 按键提示 ;右键菜单不打勾
}
else
{
  KeyToolTip:=1
  IniWrite, %KeyToolTip%, 软件设置.ini, 设置, KeyToolTip
  Menu, Tray, Check, 按键提示 ;右键菜单打勾
}
Critical, Off
return
;=================================================================

F9::
重启软件:
FM:=-1
IniWrite, %FM%, 软件设置.ini, Mode, FM
Mode:=0
IniWrite, %Mode%, 软件设置.ini, Mode, FM
ModeSearch:=0
IniWrite, %ModeSearch%, 软件设置.ini, Mode, ModeSearch
Process, Close, %模式识别ID%
Process, WaitClose, %模式识别ID%
Reload

^Del::
退出软件:
FM:=-1
IniWrite, %FM%, 软件设置.ini, Mode, FM
Mode:=0
IniWrite, %Mode%, 软件设置.ini, Mode, FM
ModeSearch:=0
IniWrite, %ModeSearch%, 软件设置.ini, Mode, ModeSearch
Process, Close, %模式识别ID%
Process, WaitClose, %模式识别ID%
ExitApp

#IfWinActive ahk_exe ugraf.exe

#Include %A_ScriptDir%\快捷键函数.ahk
#Include %A_ScriptDir%\侧键.ahk
#Include %A_ScriptDir%\Ctrl侧键.ahk
#Include %A_ScriptDir%\Shift侧键.ahk
#Include %A_ScriptDir%\Alt侧键.ahk
#Include %A_ScriptDir%\前进后退键.ahk
#Include %A_ScriptDir%\滚轮.ahk
#Include %A_ScriptDir%\其他快捷键.ahk
#Include %A_ScriptDir%\中键左右键手势.ahk
#Include %A_ScriptDir%\手势识别.ahk
#Include %A_ScriptDir%\过滤器切换.ahk
#Include %A_ScriptDir%\3D摇杆.ahk

ReadSK:
/*
第一个字母
S-草图Sketch M-建模Modeling
第二个字母(若有)
X1-XButton1后退 X2-XButton2前进 C-Ctrl S-Shift A-Alt G-Gesture手势
第三项
P-Pad小键盘 M-MButton中键 LR-LButtonRButton左右键
*/
IniRead, S_G_MC, 快捷键设置.ini, 草图设置, 中键点击
IniRead, S_G_MP, 快捷键设置.ini, 草图设置, 中键长按
IniRead, S_G_M8, 快捷键设置.ini, 草图设置, 中键上滑
IniRead, S_G_M2, 快捷键设置.ini, 草图设置, 中键下滑
IniRead, S_G_M4, 快捷键设置.ini, 草图设置, 中键左滑
IniRead, S_G_M6, 快捷键设置.ini, 草图设置, 中键右滑
IniRead, S_G_M7, 快捷键设置.ini, 草图设置, 中键左上滑
IniRead, S_G_M1, 快捷键设置.ini, 草图设置, 中键左下滑
IniRead, S_G_M9, 快捷键设置.ini, 草图设置, 中键右上滑
IniRead, S_G_M3, 快捷键设置.ini, 草图设置, 中键右下滑

IniRead, M_G_MC, 快捷键设置.ini, 建模设置, 中键点击
IniRead, M_G_MP, 快捷键设置.ini, 建模设置, 中键长按
IniRead, M_G_M8, 快捷键设置.ini, 建模设置, 中键上滑
IniRead, M_G_M2, 快捷键设置.ini, 建模设置, 中键下滑
IniRead, M_G_M4, 快捷键设置.ini, 建模设置, 中键左滑
IniRead, M_G_M6, 快捷键设置.ini, 建模设置, 中键右滑
IniRead, M_G_M7, 快捷键设置.ini, 建模设置, 中键左上滑
IniRead, M_G_M1, 快捷键设置.ini, 建模设置, 中键左下滑
IniRead, M_G_M9, 快捷键设置.ini, 建模设置, 中键右上滑
IniRead, M_G_M3, 快捷键设置.ini, 建模设置, 中键右下滑

IniRead, S_G_LRC, 快捷键设置.ini, 草图设置, 右键加左键点击
IniRead, S_G_LRP, 快捷键设置.ini, 草图设置, 右键加左键长按
IniRead, S_G_LR8, 快捷键设置.ini, 草图设置, 右键加左键上滑
IniRead, S_G_LR2, 快捷键设置.ini, 草图设置, 右键加左键下滑
IniRead, S_G_LR4, 快捷键设置.ini, 草图设置, 右键加左键左滑
IniRead, S_G_LR6, 快捷键设置.ini, 草图设置, 右键加左键右滑
IniRead, S_G_LR7, 快捷键设置.ini, 草图设置, 右键加左键左上滑
IniRead, S_G_LR1, 快捷键设置.ini, 草图设置, 右键加左键左下滑
IniRead, S_G_LR9, 快捷键设置.ini, 草图设置, 右键加左键右上滑
IniRead, S_G_LR3, 快捷键设置.ini, 草图设置, 右键加左键右下滑

IniRead, M_G_LRC, 快捷键设置.ini, 建模设置, 右键加左键点击
IniRead, M_G_LRP, 快捷键设置.ini, 建模设置, 右键加左键长按
IniRead, M_G_LR8, 快捷键设置.ini, 建模设置, 右键加左键上滑
IniRead, M_G_LR2, 快捷键设置.ini, 建模设置, 右键加左键下滑
IniRead, M_G_LR4, 快捷键设置.ini, 建模设置, 右键加左键左滑
IniRead, M_G_LR6, 快捷键设置.ini, 建模设置, 右键加左键右滑
IniRead, M_G_LR7, 快捷键设置.ini, 建模设置, 右键加左键左上滑
IniRead, M_G_LR1, 快捷键设置.ini, 建模设置, 右键加左键左下滑
IniRead, M_G_LR9, 快捷键设置.ini, 建模设置, 右键加左键右上滑
IniRead, M_G_LR3, 快捷键设置.ini, 建模设置, 右键加左键右下滑

IniRead, S_1, 快捷键设置.ini, 草图设置, 数字1
IniRead, S_2, 快捷键设置.ini, 草图设置, 数字2
IniRead, S_3, 快捷键设置.ini, 草图设置, 数字3
IniRead, S_4, 快捷键设置.ini, 草图设置, 数字4
IniRead, S_5, 快捷键设置.ini, 草图设置, 数字5
IniRead, S_6, 快捷键设置.ini, 草图设置, 数字6
IniRead, S_7, 快捷键设置.ini, 草图设置, 数字7
IniRead, S_8, 快捷键设置.ini, 草图设置, 数字8
IniRead, S_9, 快捷键设置.ini, 草图设置, 数字9
IniRead, S_0, 快捷键设置.ini, 草图设置, 数字0
IniRead, S_Dot, 快捷键设置.ini, 草图设置, Dot
IniRead, S_Enter, 快捷键设置.ini, 草图设置, Enter
IniRead, S_PAdd, 快捷键设置.ini, 草图设置, 小键盘Add
IniRead, S_PSub, 快捷键设置.ini, 草图设置, 小键盘Sub
IniRead, S_PMult, 快捷键设置.ini, 草图设置, 小键盘Mult
IniRead, S_PDiv, 快捷键设置.ini, 草图设置, 小键盘Div

IniRead, M_1, 快捷键设置.ini, 建模设置, 数字1
IniRead, M_2, 快捷键设置.ini, 建模设置, 数字2
IniRead, M_3, 快捷键设置.ini, 建模设置, 数字3
IniRead, M_4, 快捷键设置.ini, 建模设置, 数字4
IniRead, M_5, 快捷键设置.ini, 建模设置, 数字5
IniRead, M_6, 快捷键设置.ini, 建模设置, 数字6
IniRead, M_7, 快捷键设置.ini, 建模设置, 数字7
IniRead, M_8, 快捷键设置.ini, 建模设置, 数字8
IniRead, M_9, 快捷键设置.ini, 建模设置, 数字9
IniRead, M_0, 快捷键设置.ini, 建模设置, 数字0
IniRead, M_Dot, 快捷键设置.ini, 建模设置, Dot
IniRead, M_Enter, 快捷键设置.ini, 建模设置, Enter
IniRead, M_PAdd, 快捷键设置.ini, 建模设置, 小键盘Add
IniRead, M_PSub, 快捷键设置.ini, 建模设置, 小键盘Sub
IniRead, M_PMult, 快捷键设置.ini, 建模设置, 小键盘Mult
IniRead, M_PDiv, 快捷键设置.ini, 建模设置, 小键盘Div

IniRead, S_X1_1, 快捷键设置.ini, 草图设置, 后退数字1
IniRead, S_X1_2, 快捷键设置.ini, 草图设置, 后退数字2
IniRead, S_X1_3, 快捷键设置.ini, 草图设置, 后退数字3
IniRead, S_X1_4, 快捷键设置.ini, 草图设置, 后退数字4
IniRead, S_X1_5, 快捷键设置.ini, 草图设置, 后退数字5
IniRead, S_X1_6, 快捷键设置.ini, 草图设置, 后退数字6
IniRead, S_X1_7, 快捷键设置.ini, 草图设置, 后退数字7
IniRead, S_X1_8, 快捷键设置.ini, 草图设置, 后退数字8
IniRead, S_X1_9, 快捷键设置.ini, 草图设置, 后退数字9
IniRead, S_X1_0, 快捷键设置.ini, 草图设置, 后退数字0
IniRead, S_X1_Dot, 快捷键设置.ini, 草图设置, 后退Dot
IniRead, S_X1_Enter, 快捷键设置.ini, 草图设置, 后退Enter
IniRead, S_X1_PAdd, 快捷键设置.ini, 草图设置, 后退小键盘Add
IniRead, S_X1_PSub, 快捷键设置.ini, 草图设置, 后退小键盘Sub
IniRead, S_X1_PMult, 快捷键设置.ini, 草图设置, 后退小键盘Mult
IniRead, S_X1_PDiv, 快捷键设置.ini, 草图设置, 后退小键盘Div

IniRead, M_X1_1, 快捷键设置.ini, 建模设置, 后退数字1
IniRead, M_X1_2, 快捷键设置.ini, 建模设置, 后退数字2
IniRead, M_X1_3, 快捷键设置.ini, 建模设置, 后退数字3
IniRead, M_X1_4, 快捷键设置.ini, 建模设置, 后退数字4
IniRead, M_X1_5, 快捷键设置.ini, 建模设置, 后退数字5
IniRead, M_X1_6, 快捷键设置.ini, 建模设置, 后退数字6
IniRead, M_X1_7, 快捷键设置.ini, 建模设置, 后退数字7
IniRead, M_X1_8, 快捷键设置.ini, 建模设置, 后退数字8
IniRead, M_X1_9, 快捷键设置.ini, 建模设置, 后退数字9
IniRead, M_X1_0, 快捷键设置.ini, 建模设置, 后退数字0
IniRead, M_X1_Dot, 快捷键设置.ini, 建模设置, 后退Dot
IniRead, M_X1_Enter, 快捷键设置.ini, 建模设置, 后退Enter
IniRead, M_X1_PAdd, 快捷键设置.ini, 建模设置, 后退小键盘Add
IniRead, M_X1_PSub, 快捷键设置.ini, 建模设置, 后退小键盘Sub
IniRead, M_X1_PMult, 快捷键设置.ini, 建模设置, 后退小键盘Mult
IniRead, M_X1_PDiv, 快捷键设置.ini, 建模设置, 后退小键盘Div

IniRead, S_C_1, 快捷键设置.ini, 草图设置, Ctrl数字1
IniRead, S_C_2, 快捷键设置.ini, 草图设置, Ctrl数字2
IniRead, S_C_3, 快捷键设置.ini, 草图设置, Ctrl数字3
IniRead, S_C_4, 快捷键设置.ini, 草图设置, Ctrl数字4
IniRead, S_C_5, 快捷键设置.ini, 草图设置, Ctrl数字5
IniRead, S_C_6, 快捷键设置.ini, 草图设置, Ctrl数字6
IniRead, S_C_7, 快捷键设置.ini, 草图设置, Ctrl数字7
IniRead, S_C_8, 快捷键设置.ini, 草图设置, Ctrl数字8
IniRead, S_C_9, 快捷键设置.ini, 草图设置, Ctrl数字9
IniRead, S_C_0, 快捷键设置.ini, 草图设置, Ctrl数字0
IniRead, S_C_Dot, 快捷键设置.ini, 草图设置, CtrlDot
IniRead, S_C_Enter, 快捷键设置.ini, 草图设置, CtrlEnter
IniRead, S_C_PAdd, 快捷键设置.ini, 草图设置, Ctrl小键盘Add
IniRead, S_C_PSub, 快捷键设置.ini, 草图设置, Ctrl小键盘Sub
IniRead, S_C_PMult, 快捷键设置.ini, 草图设置, Ctrl小键盘Mult
IniRead, S_C_PDiv, 快捷键设置.ini, 草图设置, Ctrl小键盘Div

IniRead, M_C_1, 快捷键设置.ini, 建模设置, Ctrl数字1
IniRead, M_C_2, 快捷键设置.ini, 建模设置, Ctrl数字2
IniRead, M_C_3, 快捷键设置.ini, 建模设置, Ctrl数字3
IniRead, M_C_4, 快捷键设置.ini, 建模设置, Ctrl数字4
IniRead, M_C_5, 快捷键设置.ini, 建模设置, Ctrl数字5
IniRead, M_C_6, 快捷键设置.ini, 建模设置, Ctrl数字6
IniRead, M_C_7, 快捷键设置.ini, 建模设置, Ctrl数字7
IniRead, M_C_8, 快捷键设置.ini, 建模设置, Ctrl数字8
IniRead, M_C_9, 快捷键设置.ini, 建模设置, Ctrl数字9
IniRead, M_C_0, 快捷键设置.ini, 建模设置, Ctrl数字0
IniRead, M_C_Dot, 快捷键设置.ini, 建模设置, CtrlDot
IniRead, M_C_Enter, 快捷键设置.ini, 建模设置, CtrlEnter
IniRead, M_C_PAdd, 快捷键设置.ini, 建模设置, Ctrl小键盘Add
IniRead, M_C_PSub, 快捷键设置.ini, 建模设置, Ctrl小键盘Sub
IniRead, M_C_PMult, 快捷键设置.ini, 建模设置, Ctrl小键盘Mult
IniRead, M_C_PDiv, 快捷键设置.ini, 建模设置, Ctrl小键盘Div

IniRead, S_S_1, 快捷键设置.ini, 草图设置, Shift数字1
IniRead, S_S_2, 快捷键设置.ini, 草图设置, Shift数字2
IniRead, S_S_3, 快捷键设置.ini, 草图设置, Shift数字3
IniRead, S_S_4, 快捷键设置.ini, 草图设置, Shift数字4
IniRead, S_S_5, 快捷键设置.ini, 草图设置, Shift数字5
IniRead, S_S_6, 快捷键设置.ini, 草图设置, Shift数字6
IniRead, S_S_7, 快捷键设置.ini, 草图设置, Shift数字7
IniRead, S_S_8, 快捷键设置.ini, 草图设置, Shift数字8
IniRead, S_S_9, 快捷键设置.ini, 草图设置, Shift数字9
IniRead, S_S_0, 快捷键设置.ini, 草图设置, Shift数字0
IniRead, S_S_Dot, 快捷键设置.ini, 草图设置, ShiftDot
IniRead, S_S_Enter, 快捷键设置.ini, 草图设置, ShiftEnter
IniRead, S_S_PAdd, 快捷键设置.ini, 草图设置, Shift小键盘Add
IniRead, S_S_PSub, 快捷键设置.ini, 草图设置, Shift小键盘Sub
IniRead, S_S_PMult, 快捷键设置.ini, 草图设置, Shift小键盘Mult
IniRead, S_S_PDiv, 快捷键设置.ini, 草图设置, Shift小键盘Div

IniRead, M_S_1, 快捷键设置.ini, 建模设置, Shift数字1
IniRead, M_S_2, 快捷键设置.ini, 建模设置, Shift数字2
IniRead, M_S_3, 快捷键设置.ini, 建模设置, Shift数字3
IniRead, M_S_4, 快捷键设置.ini, 建模设置, Shift数字4
IniRead, M_S_5, 快捷键设置.ini, 建模设置, Shift数字5
IniRead, M_S_6, 快捷键设置.ini, 建模设置, Shift数字6
IniRead, M_S_7, 快捷键设置.ini, 建模设置, Shift数字7
IniRead, M_S_8, 快捷键设置.ini, 建模设置, Shift数字8
IniRead, M_S_9, 快捷键设置.ini, 建模设置, Shift数字9
IniRead, M_S_0, 快捷键设置.ini, 建模设置, Shift数字0
IniRead, M_S_Dot, 快捷键设置.ini, 建模设置, ShiftDot
IniRead, M_S_Enter, 快捷键设置.ini, 建模设置, ShiftEnter
IniRead, M_S_PAdd, 快捷键设置.ini, 建模设置, Shift小键盘Add
IniRead, M_S_PSub, 快捷键设置.ini, 建模设置, Shift小键盘Sub
IniRead, M_S_PMult, 快捷键设置.ini, 建模设置, Shift小键盘Mult
IniRead, M_S_PDiv, 快捷键设置.ini, 建模设置, Shift小键盘Div

IniRead, S_A_1, 快捷键设置.ini, 草图设置, Alt数字1
IniRead, S_A_2, 快捷键设置.ini, 草图设置, Alt数字2
IniRead, S_A_3, 快捷键设置.ini, 草图设置, Alt数字3
IniRead, S_A_4, 快捷键设置.ini, 草图设置, Alt数字4
IniRead, S_A_5, 快捷键设置.ini, 草图设置, Alt数字5
IniRead, S_A_6, 快捷键设置.ini, 草图设置, Alt数字6
IniRead, S_A_7, 快捷键设置.ini, 草图设置, Alt数字7
IniRead, S_A_8, 快捷键设置.ini, 草图设置, Alt数字8
IniRead, S_A_9, 快捷键设置.ini, 草图设置, Alt数字9
IniRead, S_A_0, 快捷键设置.ini, 草图设置, Alt数字0
IniRead, S_A_Dot, 快捷键设置.ini, 草图设置, AltDot
IniRead, S_A_Enter, 快捷键设置.ini, 草图设置, AltEnter
IniRead, S_A_PAdd, 快捷键设置.ini, 草图设置, Alt小键盘Add
IniRead, S_A_PSub, 快捷键设置.ini, 草图设置, Alt小键盘Sub
IniRead, S_A_PMult, 快捷键设置.ini, 草图设置, Alt小键盘Mult
IniRead, S_A_PDiv, 快捷键设置.ini, 草图设置, Alt小键盘Div

IniRead, M_A_1, 快捷键设置.ini, 建模设置, Alt数字1
IniRead, M_A_2, 快捷键设置.ini, 建模设置, Alt数字2
IniRead, M_A_3, 快捷键设置.ini, 建模设置, Alt数字3
IniRead, M_A_4, 快捷键设置.ini, 建模设置, Alt数字4
IniRead, M_A_5, 快捷键设置.ini, 建模设置, Alt数字5
IniRead, M_A_6, 快捷键设置.ini, 建模设置, Alt数字6
IniRead, M_A_7, 快捷键设置.ini, 建模设置, Alt数字7
IniRead, M_A_8, 快捷键设置.ini, 建模设置, Alt数字8
IniRead, M_A_9, 快捷键设置.ini, 建模设置, Alt数字9
IniRead, M_A_0, 快捷键设置.ini, 建模设置, Alt数字0
IniRead, M_A_Dot, 快捷键设置.ini, 建模设置, AltDot
IniRead, M_A_Enter, 快捷键设置.ini, 建模设置, AltEnter
IniRead, M_A_PAdd, 快捷键设置.ini, 建模设置, Alt小键盘Add
IniRead, M_A_PSub, 快捷键设置.ini, 建模设置, Alt小键盘Sub
IniRead, M_A_PMult, 快捷键设置.ini, 建模设置, Alt小键盘Mult
IniRead, M_A_PDiv, 快捷键设置.ini, 建模设置, Alt小键盘Div
Return