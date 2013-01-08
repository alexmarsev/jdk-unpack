@echo off
setlocal

set sz=%ProgramFiles%\7-Zip\7zG.exe
set file=%~f1
set dir=%file:~0,-4%

if exist "%dir%" goto :err1
if not exist "%file%" goto :err2
mkdir "%dir%"
cd "%dir%"
mkdir _step1
"%sz%" -y e "%file%" -o_step1
mkdir _step2
"%sz%" -y e _step1\111 -o_step2
"%sz%" -y e _step1\110
"%sz%" -y x _step2\tools.zip
rmdir /s /q _step1 _step2
for /f  %%i in ('dir /b /s *.pack') do call :unpack %%i
echo your shiny new jdk is here: %dir%
goto :eof

:unpack
set file=%*
echo unpacking %file%
bin\unpack200.exe -r "%file%" "%file:~0,-4%jar"
goto :eof

:err1
echo output dir already exists
exit /b 1

:err2
echo file does not exist
exit /b 2
