@echo off

@rem ffmpegがインストールされているかの確認
:ffmpeg_conf
echo +-------------------------------------------------------+
echo  Do you have FFMPEG installed on your PC?
echo (y/n)
echo +-------------------------------------------------------+
set ffmpeg_select=
set /p ffmpeg_select=
 
if "%ffmpeg_select%"== set ffmpeg_select=y
if /i not "%ffmpeg_select%"=="y"  exit/B

@rem フォルダの選択
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"

for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "file=%%p"

@rem 選択したフォルダの表示
echo selected  file is : "%file%"

@rem 回転だけしたいかどうか聞く
:rotate_conf
echo +-------------------------------------------------------+
echo  Do you ONLY want to rotate video?
echo (y/n)
echo +-------------------------------------------------------+
set rotate_select=
set /p rotate_select=
 
if "%rotate_select%"== set rotate_select=y
if /i "%rotate_select%"=="y"  goto :rotate_only

@rem トリミング開始点の入力
:input_start_time
echo +------------------------------------------------------------+
echo  Please enter trimming START time in the form of hh:mm:ss.ms
echo +------------------------------------------------------------+
set START_TIME=
set /p START_TIME=

if "%START_TIME%"=="" goto :input_start_time

@rem トリミング終了点の入力
:input_end_time
echo +------------------------------------------------------------+
echo  Please enter trimming END time in the form of hh:mm:ss.ms
echo +------------------------------------------------------------+
set END_TIME=
set /p END_TIME=

if "%END_TIME%"=="" goto :input_END_time

@rem ffmpegによるトリミングの実行
:trim_video
ffmpeg -ss %START_TIME% -to %END_TIME% -i %file% -c copy trimmed_output.mp4

@rem トリミングした動画を回転させるかの確認
echo +-------------------------------------------------------+
echo  Do you want to rotate trimmed video?
echo (y/n)
echo +-------------------------------------------------------+
set rotate_select=
set /p rotate_select=
 
if "%rotate_select%"== set rotate_select=y
if /i not "%rotate_select%"=="y"  exit/B

@rem 回転のタイプを指定
echo +-------------------------------------------------------+
echo  Select rotation type in the following
echo 1:+90deg CW
echo 2:-90deg CW
echo 3:+90deg CW, flip upside down
echo 0:-90deg CW, flip upside down
echo +-------------------------------------------------------+
set rotate_select=
set /p rotate_select=
 
if "%rotate_select%"== set rotate_select=y

@rem ffmpegによる回転の実行
:rotate_after_trim
ffmpeg -i trimmed_output.mp4 -vf "transpose=%rotate_select%" trimmed_and_rotated_output.mp4
goto :end

@rem ffmpegによる回転のみの実行
:rotate_only
@rem 回転のタイプを指定
echo +-------------------------------------------------------+
echo  Select rotation type in the following
echo 1:+90deg CW
echo 2:-90deg CW
echo 3:+90deg CW, flip upside down
echo 0:-90deg CW, flip upside down
echo +-------------------------------------------------------+
set rotate_select=
set /p rotate_select=
 
if "%rotate_select%"== set rotate_select=y
ffmpeg -i %file% -vf "transpose=%rotate_select%" rotated_output.mp4


:end
pause