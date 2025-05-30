上一个选择过滤器:
    ; Critical, On
    CoordMode Mouse, Screen
    CoordMode Pixel, Screen

    GetUGPos()
    if (错误=1)
    {
        loop
        {
            GetUGPos()
            if (错误=0)
            {
                break
            }
            else if (错误=1) and (A_Index>3)
            {
                ToolTip 警告:UG窗口错误!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
                BlockInput MouseMoveOff
                ; Critical, Off
                Return
            }
        }
    }


    if (下拉三角Y=0) or (下拉三角Y="") or (下拉三角Y="ERROR")
    {
        gosub 手动下拉三角位置获取
    }

    if (WinExist("ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW")=0)
    {
        BlockInput MouseMove
        MouseGetPos 初始位置X, 初始位置Y
        MouseMove UGX+选择过滤器X, UGY+下拉三角Y, 0
        Sleep 30
        Send {LButton}
        gosub 列表识别
        if (超时=1)
        {
            ToolTip 警告:超时!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
            BlockInput MouseMoveOff
            ; Critical, Off
            Return
        }

        if (Mode=3)
        {
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*建模选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
        }
        else if (Mode=2)
        {
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*草图选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
        }
        SetTimer 确认选择过滤器, -1500
    }
    else if (WinExist("ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW")!=0)
    {
        SetTimer 确认选择过滤器, -800
        if (Mode=3)
        {
            if (过滤器选择中=0)
            {
                过滤器选择中:=1

                gosub 列表识别
                if (超时=1)
                {
                    ToolTip 警告:超时!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
                    BlockInput MouseMoveOff
                    ; Critical, Off
                    Return
                }
                最大建模选择过滤器位置:=最大选择过滤器位置

                上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*建模选择过滤器位置
                上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
                MouseMove 上下移动X, 上下移动Y, 0

                return
            }

            建模选择过滤器位置:=建模选择过滤器位置-1
            if (建模选择过滤器位置<1)
            {
                建模选择过滤器位置:=最大建模选择过滤器位置
            }
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*建模选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
        }
        else if (Mode=2)
        {
            if (过滤器选择中=0)
            {
                过滤器选择中:=1

                gosub 列表识别
                if (超时=1)
                {
                    ToolTip 警告:超时!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
                    BlockInput MouseMoveOff
                    ; Critical, Off
                    Return
                }
                最大草图选择过滤器位置:=最大选择过滤器位置

                上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*草图选择过滤器位置
                上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
                MouseMove 上下移动X, 上下移动Y, 0

                return
            }

            草图选择过滤器位置:=草图选择过滤器位置-1
            if (草图选择过滤器位置<1)
            {
                草图选择过滤器位置:=最大草图选择过滤器位置
            }
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*草图选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
        }
    }
    ; Critical, Off
return

下一个选择过滤器:
    ; Critical, On
    CoordMode Mouse, Screen
    CoordMode Pixel, Screen

    GetUGPos()
    if (错误=1)
    {
        loop
        {
            GetUGPos()
            if (错误=0)
            {
                break
            }
            else if (错误=1) and (A_Index>3)
            {
                ToolTip 警告:UG窗口错误!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
                BlockInput MouseMoveOff
                ; Critical, Off
                Return
            }
        }
    }

    if (下拉三角Y=0) or (下拉三角Y="") or (下拉三角Y="ERROR")
    {
        gosub 手动下拉三角位置获取
    }


    if (WinExist("ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW")=0)
    {
        BlockInput MouseMove
        MouseGetPos 初始位置X, 初始位置Y
        MouseMove UGX+选择过滤器X, UGY+下拉三角Y, 0
        Sleep 30
        Send {LButton}
        gosub 列表识别
        if (超时=1)
        {
            ToolTip 警告:超时!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
            BlockInput MouseMoveOff
            ; Critical, Off
            Return
        }

        if (Mode=3)
        {
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*建模选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
        }
        else if (Mode=2)
        {
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*草图选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
        }
        SetTimer 确认选择过滤器, -1500
    }
    else if (WinExist("ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW")!=0)
    {
        SetTimer 确认选择过滤器, -800
    if (Mode=3)
    {
        if (过滤器选择中=0)
        {
            过滤器选择中:=1

            gosub 列表识别
            if (超时=1)
            {
                ToolTip 警告:超时!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
                BlockInput MouseMoveOff
                ; Critical, Off
                Return
            }
            最大建模选择过滤器位置:=最大选择过滤器位置

            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*建模选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
            return
        }

        建模选择过滤器位置:=建模选择过滤器位置+1
        if (建模选择过滤器位置>最大建模选择过滤器位置)
        {
            建模选择过滤器位置:=1
        }
        上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*建模选择过滤器位置
        上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
        MouseMove 上下移动X, 上下移动Y, 0
    }
    else if (Mode=2)
    {
        if (过滤器选择中=0)
        {
            过滤器选择中:=1

            gosub 列表识别
            if (超时=1)
            {
                ToolTip 警告:超时!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
                BlockInput MouseMoveOff
                ; Critical, Off
                Return
            }
            最大草图选择过滤器位置:=最大选择过滤器位置

            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*草图选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
            return
        }

        草图选择过滤器位置:=草图选择过滤器位置+1
        if (草图选择过滤器位置>最大草图选择过滤器位置)
        {
            草图选择过滤器位置:=1
        }
        上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*草图选择过滤器位置
        上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
        MouseMove 上下移动X, 上下移动Y, 0
        }
    }
    ; Critical, Off
return

[::
    Critical, On
    ; ToolTip 1
    if GetKeyState("]", "P")
    {
        return
    }
    IniRead Mode, 软件设置.ini, Mode, Mode
    CoordMode Mouse, Screen
    CoordMode Pixel, Screen

    GetUGPos()
    if (错误=1)
    {
        loop
        {
            GetUGPos()
            if (错误=0)
            {
                break
            }
            else if (错误=1) and (A_Index>3)
            {
                ToolTip 警告:UG窗口错误!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
                BlockInput MouseMoveOff
                Critical, Off
                Return
            }
        }
    }

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
        gosub 手动下拉三角位置获取
    }

    if (WinExist("ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW")=0)
    {
        BlockInput MouseMove
        MouseGetPos 初始位置X, 初始位置Y
        MouseMove UGX+选择过滤器X, UGY+下拉三角Y, 0
        Sleep 30
        Send {LButton}
        gosub 列表识别
        if (超时=1)
        {
            ToolTip 警告:超时!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
            BlockInput MouseMoveOff
            Critical, Off
            Return
        }

        if (Mode=3)
        {
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*建模选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
        }
        else if (Mode=2)
        {
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*草图选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
        }
        SetTimer 确认选择过滤器, -1500
    }
    else if (WinExist("ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW")!=0)
    {
        SetTimer 确认选择过滤器, -800
        if (Mode=3)
        {
            最大建模选择过滤器位置:=最大选择过滤器位置

            if (重置选择过滤器=1)
            {
                过滤器选择中:=1
                建模选择过滤器位置:=1
                重置选择过滤器:=0
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

            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*建模选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0

            建模选择过滤器位置:=建模选择过滤器位置-1
            if (建模选择过滤器位置<1)
            {
                建模选择过滤器位置:=最大建模选择过滤器位置
            }
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*建模选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
            KeyWait [
            过滤器选择中:=0
        }
        else if (Mode=2)
        {
            最大草图选择过滤器位置:=最大选择过滤器位置

            if (重置选择过滤器=1)
            {
                过滤器选择中:=1
                草图选择过滤器位置:=1
                重置选择过滤器:=0
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

            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*草图选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0

            草图选择过滤器位置:=草图选择过滤器位置-1
            if (草图选择过滤器位置<1)
            {
                草图选择过滤器位置:=最大草图选择过滤器位置
            }
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*草图选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
            KeyWait [
            过滤器选择中:=0
        }
    }
    Critical, Off
return

]::
    if GetKeyState("[", "P")
    {
        return
    }
    Critical, On
    IniRead Mode, 软件设置.ini, Mode, Mode
    CoordMode Mouse, Screen
    CoordMode Pixel, Screen

    GetUGPos()
    if (错误=1)
    {
        loop
        {
            GetUGPos()
            if (错误=0)
            {
                break
            }
            else if (错误=1) and (A_Index>3)
            {
                ToolTip 警告:UG窗口错误!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
                BlockInput MouseMoveOff
                Critical, Off
                Return
            }
        }
    }

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
        gosub 手动下拉三角位置获取
    }


    if (WinExist("ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW")=0)
    {
        BlockInput MouseMove
        MouseGetPos 初始位置X, 初始位置Y
        MouseMove UGX+选择过滤器X, UGY+下拉三角Y, 0
        Sleep 30
        Send {LButton}
        gosub 列表识别
        if (超时=1)
        {
            ToolTip 警告:超时!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
            BlockInput MouseMoveOff
            Critical, Off
            Return
        }

        if (Mode=3)
        {
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*建模选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
        }
        else if (Mode=2)
        {
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*草图选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
        }
        SetTimer 确认选择过滤器, -1500
    }
    else if (WinExist("ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW")!=0)
    {
        SetTimer 确认选择过滤器, -800
        if (Mode=3)
        {
            最大建模选择过滤器位置:=最大选择过滤器位置

            if (重置选择过滤器=1)
            {
                过滤器选择中:=1
                建模选择过滤器位置:=1
                重置选择过滤器:=0
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

            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*建模选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0

            建模选择过滤器位置:=建模选择过滤器位置+1
            if (建模选择过滤器位置>最大建模选择过滤器位置)
            {
                建模选择过滤器位置:=1
            }
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*建模选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
            KeyWait ]
            过滤器选择中:=0
        }
        else if (Mode=2)
        {
            最大草图选择过滤器位置:=最大选择过滤器位置

            if (重置选择过滤器=1)
            {
                过滤器选择中:=1
                草图选择过滤器位置:=1
                重置选择过滤器:=0
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

            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*草图选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0

            草图选择过滤器位置:=草图选择过滤器位置+1
            if (草图选择过滤器位置>最大草图选择过滤器位置)
            {
                草图选择过滤器位置:=1
            }
            上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*草图选择过滤器位置
            上下移动X:=UGX+选择过滤器X-Round(缩放率*20)
            MouseMove 上下移动X, 上下移动Y, 0
            KeyWait ]
            过滤器选择中:=0
        }
    }
    Critical, Off
return

`;::
Critical, On
IniRead Mode, 软件设置.ini, Mode, Mode
CoordMode Mouse, Screen
CoordMode Pixel, Screen

GetUGPos()
if (错误=1)
{
    loop
    {
        GetUGPos()
        if (错误=0)
        {
            break
        }
        else if (错误=1) and (A_Index>3)
        {
            ToolTip 警告:UG窗口错误!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
            BlockInput MouseMoveOff
            Critical, Off
            Return
        }
    }
}

if (下拉三角Y=0) or (下拉三角Y="") or (下拉三角Y="ERROR")
{
    gosub 手动下拉三角位置获取
}
BlockInput MouseMove
MouseGetPos 初始位置X, 初始位置Y
MouseMove UGX+选择范围X, UGY+下拉三角Y, 0
Sleep 30
Send {LButton}
选择范围位置:=选择范围位置-1
if (选择范围位置<1)
{
    选择范围位置:=1
}
上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*选择范围位置
上下移动X:=UGX+选择范围X-Round(缩放率*20)
MouseMove 上下移动X, 上下移动Y, 0
Sleep 30
Send {LButton}
Sleep 30
MouseMove 初始位置X, 初始位置Y
BlockInput MouseMoveOff
ToolTip
Critical, Off
return

确认选择过滤器:
    Send {LButton}
    Sleep 30
    MouseMove 初始位置X, 初始位置Y, 0
    BlockInput MouseMoveOff
    ToolTip
Return

$Enter::
    if (WinExist("ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW")!=0)
    {
        SetTimer 确认选择过滤器, -1
    }
Return

'::
    Critical, On
    IniRead Mode, 软件设置.ini, Mode, Mode
    CoordMode Mouse, Screen
    CoordMode Pixel, Screen

    GetUGPos()
    if (错误=1)
    {
        loop
        {
            GetUGPos()
            if (错误=0)
            {
                break
            }
            else if (错误=1) and (A_Index>3)
            {
                ToolTip 警告:UG窗口错误!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
                BlockInput MouseMoveOff
                Critical, Off
                Return
            }
        }
    }

    if (下拉三角Y=0) or (下拉三角Y="") or (下拉三角Y="ERROR")
    {
        gosub 手动下拉三角位置获取
    }
    BlockInput MouseMove
    MouseGetPos 初始位置X, 初始位置Y
    MouseMove UGX+选择范围X, UGY+下拉三角Y, 0
    Sleep 30
    Send {LButton}
    选择范围位置:=选择范围位置+1
    if (选择范围位置>3)
    {
        选择范围位置:=3
    }
    上下移动Y:=UGY+下拉三角Y+Round(缩放率*22)*选择范围位置
    上下移动X:=UGX+选择范围X-Round(缩放率*20)
    MouseMove 上下移动X, 上下移动Y, 0
    Sleep 30
    Send {LButton}
    Sleep 30
    MouseMove 初始位置X, 初始位置Y
    BlockInput MouseMoveOff
    ToolTip
    Critical, Off
return

GetUGPos(){
    global 错误
    global UGX, UGY, UGW, UGH
    global UGXOLD, UGYOLD, UGWOLD, UGHOLD

    错误:=0
    if (UGX!="") and (UGY!="") and (UGW!="") and (UGH!="")
    {
        UGXOLD:=UGX
        UGYOLD:=UGY
        UGWOLD:=UGW
        UGHOLD:=UGH
    }

    WinGetPos UGX, UGY, UGW, UGH, ahk_exe ugraf.exe
    if (UGXOLD!="") and (UGYOLD!="") and (UGWOLD!="") and (UGHOLD!="")
    {
        if (UGH<=A_ScreenHeight*0.8) or (UGW<=1000) ;or (UGW<=A_ScreenWidth*0.6)
        {
            UGX:=UGXOLD
            UGY:=UGYOLD
            UGW:=UGWOLD
            UGH:=UGHOLD
        }
    }
    else if (UGH<=A_ScreenHeight*0.8) or (UGW<=1000) ;or (UGW<=A_ScreenWidth*0.6)
    {
        错误:=1
    }
    Return
}

手动下拉三角位置获取:
    KeyWait LButton
    WinActivate ahk_exe ugraf.exe
    Sleep 500
    CoordMode Mouse, Window
    CoordMode ToolTip, Window

    GetUGPos()
    if (错误=1)
    {
        loop
        {
            GetUGPos()
            if (错误=0)
            {
                break
            }
            else if (错误=1) and (A_Index>3)
            {
                ToolTip 警告:UG窗口错误!`nUG X%UGX% Y%UGY% W%UGW% H%UGH%
                BlockInput MouseMoveOff
                Critical, Off
                Return
            }
        }
    }

    loop
    {
        ToolTip 请在选择过滤器下拉三角处点击左键以设置
        if GetKeyState("LButton", "P")
        {
            Sleep 300
            KeyWait LButton
            loop
            {
                if (WinExist("ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW")!=0)
                    Break
                else if A_Index>1000
                    Return
                Sleep 30
            }

            WinGetPos 下拉列表X, 下拉列表Y, 下拉列表W, 下拉列表H, ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW
            选择过滤器X:=下拉列表X-UGX+下拉列表W-Round(缩放率*20/2)
            下拉三角Y:=下拉列表Y-UGY-Round(缩放率*22/2)
            IniWrite %下拉三角Y%, 软件设置.ini, 设置, 下拉三角Y
            IniWrite %选择过滤器X%, 软件设置.ini, 设置, 选择过滤器X
            break
        }
    }
    Sleep 100
    send {Esc}
    loop
    {
        ToolTip 请在选择范围下拉三角处点击左键以设置
        if GetKeyState("LButton", "P")
        {
            Sleep 300
            KeyWait LButton
            loop
            {
                if (WinExist("ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW")!=0)
                    Break
                else if A_Index>100
                    Return
                Sleep 30
            }

            WinGetPos 下拉列表X, 下拉列表Y, 下拉列表W, 下拉列表H, ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW
            选择范围X:=下拉列表X-UGX+下拉列表W-Round(缩放率*20/2)
            IniWrite %选择范围X%, 软件设置.ini, 设置, 选择范围X
            break
        }
    }
    Sleep 100
    send {Esc}
    ToolTip 选择范围, 选择范围X, 下拉三角Y, 3
    ToolTip 选择过滤器, 选择过滤器X, 下拉三角Y, 2
    loop 200
    {
        ToolTip 选择过滤器设置完成: X%选择过滤器X% Y%下拉三角Y%`n选择范围设置完成: X%选择范围X% Y%下拉三角Y%
        Sleep 30
    }
    ToolTip
    ToolTip, , , ,2
    ToolTip, , , ,3
return

列表识别:
    超时:=0
    loop
    {
        if (WinExist("ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW")!=0)
            Break
        else if A_Index>100
        {
            超时:=1
            Return
        }
        Sleep 30
    }

    WinGetPos 下拉列表X, 下拉列表Y, 下拉列表W, 下拉列表H, ahk_class NX_SURFACE_WND_WITH_SYS_DROPSHADOW
    最大选择过滤器位置:=Floor(下拉列表H/(缩放率*22))
    ; ToolTip 最大选择过滤器位置%最大选择过滤器位置%
return