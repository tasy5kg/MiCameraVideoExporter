@echo off
cls
echo С���������Ƶ�������� - ������С�������������׼��
echo tasy5kg@qq.com
echo.
echo �����߿ɽ�С�������¼�Ƶ���Ƶ��СʱΪ��λ������
echo.
if not exist %cd%\bin\ffmpeg.exe (
echo ȱ������������������������ѹѹ������Ȼ���������б����ߡ�
echo ��������˳���
pause > nul
exit /b
)
echo �뽫������Ĵ��濨ȡ��������ͨ�����������Ӵ˵��ԡ�
echo ���Ӻú󣬴��ļ���Դ���������鿴���濨���̷���
echo ��󣬽��̷����뵽�����ڡ�
echo ���磺�����濨λ�� F �̣������� F��
:InputDriver
set /p driver=���봢�濨�����̷���
if not exist %driver%:\record (
echo.
echo ������Ǵ��濨���ڵ��̷���������ٴ����롣
goto InputDriver
)
echo.
echo �밴�� ������ �ķ�ʽ������Ҫ��������Ƶ�����ڡ�
echo ���磺Ҫ���� 2021 �� 7 �� 15 �յ���Ƶ�������� 20210715��
:InputVideoDate
set /p video_date=������Ƶ���ڣ������գ���
if not exist %driver%:\record\%video_date% (
echo.
echo δ�ҵ����յ���Ƶ�����������롣
goto InputVideoDate
)
echo.
echo ������Ҫ�����������Ƶ��
echo ���磺Ҫ���� 19 �㣬�� 19:00 �� 19:59 ����Ƶ�������� 19��
:InputVideoHour
set /p video_hour=����Ҫ�����������Ƶ��
if not exist %driver%:\record\%video_date%\%video_hour% (
echo.
echo δ�ҵ���ʱ����Ƶ�����������롣
goto InputVideoHour
)
echo.
set size=0
for /f "tokens=*" %%x in ('dir %driver%:\record\%video_date%\%video_hour% /s /a /b %1') do set /a size+=%%~zx
set /a size=%size%/1024/1024
echo ���ҵ�Լ %size% MB ����Ƶ���밴�������ʼ������
pause > nul
echo.
echo ���ڵ�����Ƶ����Լ��Ҫһ���ӡ�
echo ���������У���Ҫ�رմ˴��ڻ�γ����濨��
set timestamp=%time::=.%
set timestamp=%timestamp: =.%
set video_source_dir=%driver%:\record\%video_date%\%video_hour%
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
set exported_file_name=%video_date%%video_hour%.mp4
:ExportFileNameChanged
set "exported_file_path=%userprofile%\desktop\%exported_file_name%"
if exist %exported_file_path% (
set /a num=%num%+1
set "exported_file_name=%video_date%%video_hour%(%num%).mp4"
goto ExportFileNameChanged
)
%cd%\bin\ffmpeg -hide_banner -loglevel error -f concat -safe 0 -i "%file_list_path_attached%" -c:v copy -c:a aac %exported_file_path%
if exist %file_list_path_attached% (del %file_list_path_attached%)
echo.
echo ��������ɡ���������Ƶ %exported_file_name% �����������ϣ���鿴��
echo ��������˳���
pause > nul
