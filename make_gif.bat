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

@rem フレームレートの入力
:frame_rate
echo +-------------------------------------------------------+
echo  Enter frame rate in number
echo +-------------------------------------------------------+
set frame_rate=
set /p frame_rate=

if "%frame_rate%"=="" goto "frame_rate"

@rem 横幅ピクセルのサイズを指定（アスペクト比維持）
:width_pic
echo +-------------------------------------------------------+
echo  Enter width pixel size in numver
echo +-------------------------------------------------------+
set width_pic=
set /p width_pic=

if "%width_pic%"=="" goto "width_pic"

@rem 動画の再生速度を変える処理
:change_video_rate
ffmpeg -i %file% -vf scale=%width_pic%:-1 -r %frame_rate% gif_from_video.gif

:end
pause