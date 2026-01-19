@echo off
chcp 65001>nul
setlocal enabledelayedexpansion

set opt[0]=泡麵
set opt[1]=全家麵包
set opt[2]=全家微波
set opt[3]=自己

set /a index=%random% %% 4
echo 今天吃：!opt[%index%]!
pause
