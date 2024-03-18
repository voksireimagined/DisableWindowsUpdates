@echo off
color 0a

REM Check if script is running with administrative privileges
>nul 2>&1 net session
if %errorlevel% neq 0 (
    echo This script requires administrative privileges. Please run it as an administrator.
    pause
    exit /b
)

:WindowsTool
cls
echo ---- Windows Tool ----
echo 1. Toggle Windows Updates
echo 2. Credits
echo 3. Exit

REM Check the current status of Windows Updates
sc query wuauserv | findstr /C:"STATE" | findstr "STOPPED" > nul
if errorlevel 1 (
    set WUStatus=Enabled
) else (
    set WUStatus=Disabled
)

echo.
echo Current Status:
echo - Windows Updates: %WUStatus%
echo.

set /p choice=Enter your choice: 

if "%choice%"=="1" (
    if "%WUStatus%"=="Disabled" (
        sc config wuauserv start=demand
        net start wuauserv
        echo Windows Updates enabled.
    ) else (
        net stop wuauserv
        sc config wuauserv start=disabled
        echo Windows Updates disabled.
    )
    pause
    goto WindowsTool
) else if "%choice%"=="2" (
    echo.
    echo Hello :)
    echo Made by Alenify
    echo sodium.exe is a goated person
    pause
    goto WindowsTool
) else if "%choice%"=="3" (
    exit /b
) else (
    echo Invalid choice. Please try again.
    pause
    goto WindowsTool
)
