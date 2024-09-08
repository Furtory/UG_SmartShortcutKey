;Gesture ToolTip 手势提示
GTT:
CoordMode, ToolTip, Screen
if (NX<LL)and(NY>LT)and(NY<LB) ;左滑
  TTD:=4
else if (NX>LR)and(NY>LT)and(NY<LB) ;右滑
  TTD:=6
else if (NY<LT)and(NX>LL)and(NX<LR) ;上滑
  TTD:=8
else if (NY>LB)and(NX>LL)and(NX<LR) ;下滑
  TTD:=2
else if (NX<LL)and(NY<LT) ;左上滑
  TTD:=7
else if (NX<LL)and(NY>LB) ;左下滑
  TTD:=1
else if (NX>LR)and(NY<LT) ;右上滑
  TTD:=9
else if (NX>LR)and(NY>LB) ;右下滑
  TTD:=3
else if (NX>LL) and (NX<LR) and (NY>LT) and (NY<LB) and (TTD!=0) ;没有滑动
  TTD:=-3

;Gesture Mode 手势模式 0无 1左右键 2中键
if GetKeyState("LButton", "P") or GetKeyState("LButton", "P")
  GM:=1
else if GetKeyState("MButton", "P")
  GM:=2
; MsgBox GM%GM%
;===========================================================================

if (GM=1) ;手势触发快捷键 左右键
{
  Send {LButton Up}
  Send {RButton Up}
  Sleep 30
  
  if (Mode=2) ;草图
  {
    if (TTD=4) ;左滑
    {
      快捷键:=S_G_LR4
      触发热键提示:="右键加左键左滑"
    }
    else if (TTD=6) ;右滑
    {
      快捷键:=S_G_LR6
      触发热键提示:="右键加左键右滑"
    }
    else if (TTD=8) ;上滑
    {
      快捷键:=S_G_LR8
      触发热键提示:="右键加左键上滑"
    }
    else if (TTD=2) ;下滑
    {
      快捷键:=S_G_LR2
      触发热键提示:="右键加左键下滑"
    }
    else if (TTD=7) ;左上滑
    {
      快捷键:=S_G_LR7
      触发热键提示:="右键加左键左上滑"
    }
    else if (TTD=9) ;右上滑
    {
      快捷键:=S_G_LR9
      触发热键提示:="右键加左键右上滑"
    }
    else if (TTD=3) ;右下滑
    {
      快捷键:=S_G_LR3
      触发热键提示:="右键加左键右下滑"
    }
    else if (TTD=1) ;左下滑
    {
      快捷键:=S_G_LR1
      触发热键提示:="右键加左键左下滑"
    }
  }
  else if (Mode=3) ;建模
  {
    if (TTD=4) ;左滑
    {
      快捷键:=M_G_LR4
      触发热键提示:="右键加左键左滑"
    }
    else if (TTD=6) ;右滑
    {
      快捷键:=M_G_LR6
      触发热键提示:="右键加左键右滑"
    }
    else if (TTD=8) ;上滑
    {
      快捷键:=M_G_LR8
      触发热键提示:="右键加左键上滑"
    }
    else if (TTD=2) ;下滑
    {
      快捷键:=M_G_LR2
      触发热键提示:="右键加左键下滑"
    }
    else if (TTD=7) ;左上滑
    {
      快捷键:=M_G_LR7
      触发热键提示:="右键加左键左上滑"
    }
    else if (TTD=9) ;右上滑
    {
      快捷键:=M_G_LR9
      触发热键提示:="右键加左键右上滑"
    }
    else if (TTD=3) ;右下滑
    {
      快捷键:=M_G_LR3
      触发热键提示:="右键加左键右下滑"
    }
    else if (TTD=1) ;左下滑
    {
      快捷键:=M_G_LR1
      触发热键提示:="右键加左键左下滑"
    }
  }
}
else if (GM=2) ;手势触发快捷键 中键
{
  if (Mode=2) ;草图
  {
    if (TTD=4) ;左滑
    {
      快捷键:=S_G_M4
      触发热键提示:="中键左滑"
    }
    else if (TTD=6) ;右滑
    {
      快捷键:=S_G_M6
      触发热键提示:="中键右滑"
    }
    else if (TTD=8) ;上滑
    {
      快捷键:=S_G_M8
      触发热键提示:="中键上滑"
    }
    else if (TTD=2) ;下滑
    {
      快捷键:=S_G_M2
      触发热键提示:="中键下滑"
    }
    else if (TTD=7) ;左上滑
    {
      快捷键:=S_G_M7
      触发热键提示:="中键左上滑"
    }
    else if (TTD=9) ;右上滑
    {
      快捷键:=S_G_M9
      触发热键提示:="中键右上滑"
    }
    else if (TTD=3) ;右下滑
    {
      快捷键:=S_G_M3
      触发热键提示:="中键右下滑"
    }
    else if (TTD=1) ;左下滑
    {
      快捷键:=S_G_M1
      触发热键提示:="中键左下滑"
    }
  }
  else if (Mode=3) ;建模
  {
    if (TTD=4) ;左滑
    {
      快捷键:=M_G_M4
      触发热键提示:="中键左滑"
    }
    else if (TTD=6) ;右滑
    {
      快捷键:=M_G_M6
      触发热键提示:="中键右滑"
    }
    else if (TTD=8) ;上滑
    {
      快捷键:=M_G_M8
      触发热键提示:="中键上滑"
    }
    else if (TTD=2) ;下滑
    {
      快捷键:=M_G_M2
      触发热键提示:="中键下滑"
    }
    else if (TTD=7) ;左上滑
    {
      快捷键:=M_G_M7
      触发热键提示:="中键左上滑"
    }
    else if (TTD=9) ;右上滑
    {
      快捷键:=M_G_M9
      触发热键提示:="中键右上滑"
    }
    else if (TTD=3) ;右下滑
    {
      快捷键:=M_G_M3
      触发热键提示:="中键右下滑"
    }
    else if (TTD=1) ;左下滑
    {
      快捷键:=M_G_M1
      触发热键提示:="中键左下滑"
    }
  }
}

if (GM>0) and (过滤器选择中!=1) and (TTD>0)
{
  快捷键手势提示:=StrSplit(快捷键,"|")
  快捷键手势提示:=快捷键手势提示[2]
  ToolTip, %快捷键手势提示%
}
else if (TTD<0)
{
  ToolTip
}

if (TTD=4) and (过滤器选择中!=1) ;左滑
  ToolTip, ←, IX-Round(40*(A_ScreenHeight/1080)), IY-Round(10*(A_ScreenHeight/1080)), 2
else if (TTD=6) and (过滤器选择中!=1) ;右滑
  ToolTip, →, IX+Round(16*(A_ScreenHeight/1080)), IY-Round(10*(A_ScreenHeight/1080)), 2
else if (TTD=8) and (过滤器选择中!=1) ;上滑
  ToolTip, ` ↑` , IX-Round(13*(A_ScreenHeight/1080)), IY-Round(40*(A_ScreenHeight/1080)), 2
else if (TTD=2) and (过滤器选择中!=1) ;下滑
  ToolTip, ` ↓` , IX-Round(13*(A_ScreenHeight/1080)), IY+Round(20*(A_ScreenHeight/1080)), 2
else if (TTD=7) and (过滤器选择中!=1) ;左上滑
  ToolTip, ↖, IX-Round(40*(A_ScreenHeight/1080)) , IY-Round(40*(A_ScreenHeight/1080)), 2
else if (TTD=1) and (过滤器选择中!=1) ;左下滑
  ToolTip, ↙, IX-Round(40*(A_ScreenHeight/1080)), IY+Round(20*(A_ScreenHeight/1080)), 2
else if (TTD=9) and (过滤器选择中!=1) ;右上滑
  ToolTip, ↗, IX+Round(16*(A_ScreenHeight/1080)), IY-Round(40*(A_ScreenHeight/1080)), 2
else if (TTD=3) and (过滤器选择中!=1) ;右下滑
  ToolTip, ↘, IX+Round(16*(A_ScreenHeight/1080)), IY+Round(20*(A_ScreenHeight/1080)), 2
else if (TTD<=0) and (过滤器选择中!=1) ;没有滑动
  ToolTip, , , ,2
return