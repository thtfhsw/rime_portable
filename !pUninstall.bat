@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> 检查管理员权限
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges （请求管理员权限）...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

REM 找到安装版本所在文件夹
for /D %%d in (*weasel-*) do (
   SET INSTVER=%%d
)

REM 删除安装
"%~dp0%INSTVER%\WeaselServer.exe" /quit
"%~dp0%INSTVER%\WeaselSetup.exe" /u

REG DELETE HKEY_CURRENT_USER\Software\Rime /f

REG DELETE HKLM\Software\Microsoft\Windows\CurrentVersion\Run\ /v WeaselServer /f

DEL /Q "%~dp0data\installation.yaml"
DEL /Q "%~dp0data\user.yaml"
RD /S /Q "%~dp0data\build"

