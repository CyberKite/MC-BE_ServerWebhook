@echo off

echo initiating startup sequence. don't kill this. it'll die with the server.
start "Bedrock Dedicated Server" "%~dp0\bedrock_server.exe"

for /F "TOKENS=1,2,*" %%a in ('tasklist /FI "IMAGENAME eq bedrock_server.exe"') do set ServerPID=%%b
echo server PID: %ServerPID%

::Change up the string in here to modify the Message sent
Powershell.exe -executionpolicy remotesigned -File LogToWebHook.ps1 -content "Starting (Server)"
echo Server Started

::Estimated server startup time

timeout /t 20 >nul

::look above
Powershell.exe -executionpolicy remotesigned -File LogToWebHook.ps1 -content "Server should be running. Try connecting."
echo Server is running. Hide this Window

::Wait until Process PID not found

:loop
tasklist | find " %ServerPID% " >nul
if not errorlevel 1 (
    timeout /t 10 >nul
    goto :loop
)
echo Server process died.

::You know what by now
Powershell.exe -executionpolicy remotesigned -File LogToWebHook.ps1 -content "Server process died."
