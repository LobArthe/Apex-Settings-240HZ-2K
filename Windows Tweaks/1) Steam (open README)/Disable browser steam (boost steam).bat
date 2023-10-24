echo off
setlocal EnableDelayedExpansion

set "steam_path=C:\Program Files (x86)\Steam"

:: kill steam if is running
tasklist | findstr /i "steam.exe" && taskkill /f /im "steam.exe"

:: rename binary back to .exe as steam requires it to initialize
for %%a in ("cef.win7", "cef.win7x64") do (
    set "bin=!steam_path!\bin\cef\%%~a\steamwebhelper.exee"
    if exist "!bin!" (
        ren "!bin!" "steamwebhelper.exe"
    )
)

:: open steam
start "" "!steam_path!\steam.exe" +open steam://open/minigameslist

:: only continue if steamwebhelper is running in case steam is updating
:query_steamwebhelper
tasklist | findstr /i "steamwebhelper.exe" || goto :query_steamwebhelper

:: allow a few seconds for steam to initialize/login
timeout /t 5 /nobreak

:: rename binary and kill the process
for %%a in ("cef.win7", "cef.win7x64") do (
    set "bin=!steam_path!\bin\cef\%%~a\steamwebhelper.exe"
    if exist "!bin!" (
        ren "!bin!" "steamwebhelper.exee"
    )
)

taskkill /f /im "steamwebhelper.exe"