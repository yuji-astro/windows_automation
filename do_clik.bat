@echo off
cd /d %~dp0

ECHO +---------------------------------------------------------------+
ECHO  [click.py]
ECHO  Click at specified point on your screen at every specified time.
ECHO  -Parameters
ECHO    -INT_TIME [s]:The time interval you want to click (Required)
ECHO    -POS_X [pixel]: x position on your screen (Optional) 
ECHO    -POS_Y [pixel]: y position on your screen (Optional)
ECHO +---------------------------------------------------------------+

@rem クリックのインターバル時間を入力
:input_time
set /p INT_TIME="Please enter click interval time[s]: "

if "%INT_TIME%"=="" goto :exe_code

@rem クリック座標の入力
:input_x
set /p POS_X= "Please enter x cordinate [pixel]: "
if "%POS_X%"=="" goto :exe_code

@rem クリック座標の入力
:input_y
set /p POS_Y= "Please enter y cordinate [pixel]: "
if "%POS_Y%"=="" goto :exe_code

@rem pythonファイルの実行
:exe_code
python click.py %INT_TIME% %POS_X% %POS_Y%
pause