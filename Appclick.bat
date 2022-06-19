@echo off
cd /d %~dp0

@rem pythonファイルの実行
:exe_code
python Appclick.py
pause