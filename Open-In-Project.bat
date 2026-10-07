@echo off
rem Double-click to open the newest exported plan from Downloads in MS Project (saved as .mpp).
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Open-In-Project.ps1" %*
pause
