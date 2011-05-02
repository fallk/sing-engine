@echo off
color 5A
echo 			 XashXT Group 2010 (C)
echo			Sing Project 2011 (c)
echo 			   Create Sing SDK
echo.

if not exist sing_sdk mkdir sing_sdk\
if not exist sing_sdk\engine mkdir sing_sdk\engine\
if not exist sing_sdk\common mkdir sing_sdk\common\
if not exist sing_sdk\mainui mkdir sing_sdk\mainui\
if not exist sing_sdk\mainui\legacy mkdir sing_sdk\mainui\legacy
if not exist sing_sdk\utils mkdir sing_sdk\utils\
if not exist sing_sdk\game_launch mkdir sing_sdk\game_launch\
if not exist sing_sdk\cl_dll mkdir sing_sdk\cl_dll\
if not exist sing_sdk\cl_dll\hl mkdir sing_sdk\cl_dll\hl\
if not exist sing_sdk\dlls mkdir sing_sdk\dlls\
if not exist sing_sdk\dlls\wpn_shared mkdir sing_sdk\dlls\wpn_shared\
if not exist sing_sdk\game_shared mkdir sing_sdk\game_shared\
if not exist sing_sdk\pm_shared mkdir sing_sdk\pm_shared\
if not exist sing_sdk\dmc mkdir sing_sdk\dmc
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst engine\*.h sing_sdk\engine\*.h
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst game_launch\*.* sing_sdk\game_launch\*.*
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst mainui\*.* sing_sdk\mainui\*.*
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst mainui\legacy\*.* sing_sdk\mainui\legacy\*.*
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst common\*.* sing_sdk\common\*.*
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst cl_dll\*.* sing_sdk\cl_dll\*.*
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst cl_dll\hl\*.* sing_sdk\cl_dll\hl\*.*
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst dlls\*.* sing_sdk\dlls\*.*
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst dlls\wpn_shared\*.* sing_sdk\dlls\wpn_shared\*.*
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst dmc\cl_dll\*.* sing_sdk\dmc\cl_dll\*.*
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst dmc\cl_dll\quake\*.* sing_sdk\dmc\cl_dll\quake\*.*
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst dmc\dlls\*.* sing_sdk\dmc\dlls\*.*
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst dmc\pm_shared\*.* sing_sdk\dmc\pm_shared\*.*
@xcopy /Y /E /EXCLUDE:sing_sdk_exclude.lst utils sing_sdk\utils
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst game_shared\*.* sing_sdk\game_shared\*.*
@xcopy /Y /EXCLUDE:sing_sdk_exclude.lst pm_shared\*.* sing_sdk\pm_shared\*.*
@copy /Y sing_sdk.sln sing_sdk\sing_sdk.sln
echo 			     Prepare OK!
echo 		     Please wait: creating SDK in progress
"C:\Program Files (x86)\WinRar\rar" a sing_sdk.rar -dh -k -r -s -df -m5 sing_sdk >>makesdk.log
if errorlevel 1 goto error
if errorlevel 0 goto ok
:ok
cls
echo 		     SDK was sucessfully created
echo 		     and stored in RAR-chive "sing_sdk"
echo 		      Press any key for exit. :-)
pause>nul
if exist makesdk.log del /f /q makesdk.log
exit
:error
echo 		    ******************************
echo 		    ***********Error!*************
echo 		    ******************************
echo 		    *See makesdk.log for details**
echo 		    ******************************
echo 		    ******************************
echo.
echo 		      press any key for exit :-(
pause>nul
exit