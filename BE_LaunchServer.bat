@echo off

echo initiating startup sequence. don't kill this. it'll die with the server.
start "Bedrock Dedicated Server" "%~dp0\bedrock_server.exe"

for /F "TOKENS=1,2,*" %%a in ('tasklist /FI "IMAGENAME eq bedrock_server.exe"') do set ServerPID=%%b
echo server PID: %ServerPID%

Powershell.exe -executionpolicy remotesigned -File  SendWebHook.ps1 -content "Starting (Server)"
echo Server Started

timeout /t 20 >nul

Powershell.exe -executionpolicy remotesigned -File  SendWebHook.ps1 -content "@everyone Server should be running. Try connecting twice."
echo Server is running. Hide this Window

:loop
tasklist | find " %ServerPID% " >nul
if not errorlevel 1 (
    timeout /t 10 >nul
    goto :loop
)

echo Server process died.
Powershell.exe -executionpolicy remotesigned -File  SendWebHook.ps1 -content "Server process died."