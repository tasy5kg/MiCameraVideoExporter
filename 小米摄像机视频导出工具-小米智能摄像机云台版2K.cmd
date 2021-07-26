@echo off
cls
echo 小米摄像机视频导出工具 - 适用于小米智能摄像机云台版2K
echo tasy5kg@qq.com
echo.
echo 本工具可将小米摄像机录制的视频以小时为单位导出。
echo.
if not exist %cd%\bin\ffmpeg.exe (
echo 缺少运行所需的组件，请完整解压压缩包，然后重新运行本工具。
echo 按任意键退出。
pause > nul
exit /b
)
echo 请将摄像机的储存卡取出，将其通过读卡器连接此电脑。
echo 连接好后，打开文件资源管理器，查看储存卡的盘符。
echo 最后，将盘符输入到本窗口。
echo 例如：若储存卡位于 F 盘，则输入 F。
:InputDriver
set /p driver=输入储存卡所在盘符：
if not exist %driver%:\MIJIA_RECORD_VIDEO (
echo.
echo 这好像不是储存卡所在的盘符。请检查后再次输入。
goto InputDriver
)
echo.
echo 请按照 年月日时 的方式，输入要导出的视频的时间。
echo 例如：要导出 2021 年 7 月 15 日 19:00 至 19:59 的视频，则输入 2021071519。
:InputVideoDate
set /p video_date=输入视频日期（年月日时）：
if not exist %driver%:\MIJIA_RECORD_VIDEO\%video_date% (
echo.
echo 未找到此时的视频。请重新输入。
goto InputVideoDate
)
echo.
set size=0
for /f "tokens=*" %%x in ('dir %driver%:\MIJIA_RECORD_VIDEO\%video_date% /s /a /b %1') do set /a size+=%%~zx
set /a size=%size%/1024/1024
echo 已找到约 %size% MB 的视频，请按任意键开始导出。
pause > nul
echo.
echo 正在导出视频，大约需要一分钟。
echo 导出过程中，不要关闭此窗口或拔出储存卡。
set timestamp=%time::=.%
set timestamp=%timestamp: =.%
set video_source_dir=%driver%:\MIJIA_RECORD_VIDEO\%video_date%
set working_directory=%cd%
set file_list_path=%temp%\tasy5kg_file_list_%timestamp%.txt
set file_list_path_attached=%temp%\tasy5kg_file_list_%timestamp%_attached.txt
cd /d %video_source_dir%
dir *.mp4 /b /s /o d > %file_list_path%
if exist %file_list_path_attached% (del %file_list_path_attached%)
for /f "tokens=*" %%i in (%file_list_path%) do (>> %file_list_path_attached% echo file '%%i')
if exist %file_list_path% (del %file_list_path%)
cd /d %working_directory%
set num=1
set exported_file_name=%video_date%.mp4
:ExportFileNameChanged
set "exported_file_path=%userprofile%\desktop\%exported_file_name%"
if exist %exported_file_path% (
set /a num=%num%+1
set "exported_file_name=%video_date%(%num%).mp4"
goto ExportFileNameChanged
)
%cd%\bin\ffmpeg -hide_banner -loglevel error -f concat -safe 0 -i "%file_list_path_attached%" -c:v copy -c:a aac %exported_file_path%
if exist %file_list_path_attached% (del %file_list_path_attached%)
echo.
echo 导出已完成。导出的视频 %exported_file_name% 保存在桌面上，请查看。
echo 按任意键退出。
pause > nul
