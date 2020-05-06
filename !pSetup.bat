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

REM 开始安装
SET DataFolder=%~dp0AppData\
SET DataFolder=%DataFolder:~0,-1%

REM 设置用户目录
REG ADD HKEY_CURRENT_USER\Software\Rime\Weasel /v RimeUserDir /d "%DataFolder%"

REM 不弹出确认窗口
REG ADD HKEY_CURRENT_USER\Software\Rime\Weasel /v Hant /t REG_DWORD /d 0

REM 不检查软件更新
REG ADD HKEY_CURRENT_USER\Software\Rime\Weasel\Updates /v CheckForUpdates /d 0

"%~dp0%INSTVER%\WeaselSetup.exe" /i
"%~dp0%INSTVER%\WeaselDeployer.exe" /install

REM 开机自动启动服务
REG ADD HKLM\Software\Microsoft\Windows\CurrentVersion\Run /v WeaselServer /d "%~dp0%INSTVER%\WeaselServer.exe" /f

REM 打开输入法 
start "" "%~dp0%INSTVER%\WeaselServer.exe"
