@echo off
color 5A
echo 			 XashXT Group 2010 (C)
echo			Sing Project 2011 (c)
echo 			   Create Sing Nightly Release
echo.

if not exist sing_build mkdir sing_build\
if not exist sing_build\valve mkdir sing_build\valve
if not exist sing_build\dmc mkdir sing_build\dmc
if not exist sing_build\tools mkdir sing_build\tools
@xcopy /Y /E valve sing_build\valve
@xcopy /Y /E dmc sing_build\dmc
@xcopy /Y /E tools sing_build\tools
@xcopy *.exe sing_build\
@xcopy *.dll sing_build\
echo 			     Prepare OK!
echo 		     Please wait: creating SDK in progress
"C:\Program Files (x86)\WinRar\rar" a sing_build -dh -k -r -s -df -m5 -ag-DD-MM-YYYY sing_build >>make_nightly.log
if errorlevel 1 goto error
if errorlevel 0 goto ok
:ok
cls
echo 		     Nightly was sucessfully created
echo 		     and stored in RAR-chive "sing_build"
echo 		      Press any key for exit. :-)
pause>nul
if exist makesdk.log del /f /q makesdk.log
exit
:error
echo 		    ******************************
echo 		    ***********Error!*************
echo 		    ******************************
echo 		    *See make_nightly.log for details**
echo 		    ******************************
echo 		    ******************************
echo.
echo 		      press any key for exit :-(
pause>nul
exit