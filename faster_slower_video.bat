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

@rem 動画の再生速度をどれだけ変更させるか聞く
:video_times
echo +-------------------------------------------------------+
echo  How many times do you want to make your video faster?
echo  Enter the Number.
echo +-------------------------------------------------------+
set video_times=
set /p video_times=
 
if "%video_times%"=="" goto:video_times

@rem 動画の再生速度を変える処理
:change_video_rate
ffmpeg -i %file% -vf setpts=PTS/%video_times% -af atempo=%video_times% changed_rate_video.mp4

:end
pause