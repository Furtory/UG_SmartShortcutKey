﻿$^Enter::
$^NumpadEnter::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_Enter
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_Enter
  goto SK
}
return

$^1::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_1
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_1
  goto SK
}
return

$^2::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_2
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_2
  goto SK
}
return

$^3::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_3
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_3
  goto SK
}
return

$^4::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_4
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_4
  goto SK
}
return

$^5::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_5
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_5
  goto SK
}
return

$^6::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_6
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_6
  goto SK
}
return

$^7::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_7
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_7
  goto SK
}
return

$^8::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_8
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_8
  goto SK
}
return

$^9::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_9
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_9
  goto SK
}
return

$^0::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_0
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_P0
  goto SK
}
return

$^.::
$^NumpadDot::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_Dot
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_Dot
  goto SK
}
return

$^NumpadAdd::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_PAdd
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_PAdd
  goto SK
}
return

$^NumpadSub::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_PSub
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_PSub
  goto SK
}
return

$^NumpadMult::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_PMult
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_PMult
  goto SK
}
return

$^NumpadDiv::
if (SK=1)
  return
IniRead, Mode, 软件设置.ini, Mode, Mode
if (Mode=2)
{
  快捷键:=S_C_PDiv
  goto SK
}
else if (Mode=3)
{
  快捷键:=M_C_PDiv
  goto SK
}
return