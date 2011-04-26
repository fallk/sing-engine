@echo off
color 5A
echo 			 XashXT Group 2010 (C)
echo			Sing Project 2011 (c)
echo 			   Create Sing SDK
echo.

if not exist xash_sdk mkdir xash_sdk\
if not exist xash_sdk\engine mkdir xash_sdk\engine\
if not exist xash_sdk\common mkdir xash_sdk\common\
if not exist xash_sdk\mainui mkdir xash_sdk\mainui\
if not exist xash_sdk\mainui\legacy mkdir xash_sdk\mainui\legacy
if not exist xash_sdk\utils mkdir xash_sdk\utils\
if not exist xash_sdk\utils\vgui mkdir xash_sdk\utils\vgui
if not exist xash_sdk\utils\vgui\include mkdir xash_sdk\utils\vgui\include
if not exist xash_sdk\utils\vgui\lib mkdir xash_sdk\utils\vgui\lib
if not exist xash_sdk\utils\vgui\lib\win32_vc6 mkdir xash_sdk\utils\vgui\lib\win32_vc6
if not exist xash_sdk\game_launch mkdir xash_sdk\game_launch\
if not exist xash_sdk\cl_dll mkdir xash_sdk\cl_dll\
if not exist xash_sdkcl_dll\hl mkdir xash_sdk\cl_dll\hl\
if not exist xash_sdk\dlls mkdir xash_sdk\dlls\
if not exist xash_sdk\dlls\wpn_shared mkdir xash_sdk\dlls\wpn_shared\
if not exist xash_sdk\game_shared mkdir xash_sdk\game_shared\
if not exist xash_sdk\pm_shared mkdir xash_sdk\pm_shared\
@copy /Y engine\*.h xash_sdk\engine\*.h
@copy /Y game_launch\*.* xash_sdk\game_launch\*.*
@copy /Y mainui\*.* xash_sdk\mainui\*.*
@copy /Y mainui\legacy\*.* xash_sdk\mainui\legacy\*.*
@copy /Y common\*.* xash_sdk\common\*.*
@copy /Y cl_dll\*.* xash_sdk\cl_dll\*.*
@copy /Y cl_dll\hl\*.* xash_sdk\cl_dll\hl\*.*
@copy /Y dlls\*.* xash_sdk\dlls\*.*
@copy /Y dlls\wpn_shared\*.* xash_sdk\dlls\wpn_shared\*.*
@copy /Y utils\vgui\include\*.* xash_sdk\utils\vgui\include\*.*
@copy /Y utils\vgui\lib\win32_vc6\*.* xash_sdk\utils\vgui\lib\win32_vc6\*.*
@copy /Y game_shared\*.* xash_sdk\game_shared\*.*
@copy /Y pm_shared\*.* xash_sdk\pm_shared\*.*
@copy /Y xash_sdk.sln xash_sdk\xash_sdk.sln
echo 			     Prepare OK!
echo 		     Please wait: creating SDK in progress
"C:\Program Files (x86)\WinRar\rar" a xash_sdk -dh -k -r -s -df -m5 @xash_sdk.lst >>makesdk.log
if errorlevel 1 goto error
if errorlevel 0 goto ok
:ok
cls
echo 		     SDK was sucessfully created
echo 		     and stored in RAR-chive "xash_sdk"
echo 		      Press any key for exit. :-)
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