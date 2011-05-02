;--------------------------------
;Include Modern UI

  !include "MUI.nsh"
  !include "nsDialogs.nsh"

;--------------------------------
;General

!define VERSION "0.1"

Name "Sing Engine ${VERSION}"
OutFile "sing-engine-${VERSION}-install.exe"
DirText "Please select installation directory:"
InstallDir "$PROGRAMFILES\Sing.Engine"


;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages


  !define MUI_WELCOMEPAGE_TITLE "Welcome!"
  !define MUI_FINISHPAGE_TITLE "Installation Complete."

  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_INSTFILES
Var REDIST
Var RedistInstalled

Function InstallVC90Redistributable
	DetailPrint "Installing Microsoft Visual Studio 2008 SP1 redistributable ..."
	StrCpy $REDIST "$TEMP\vcredist_x86.exe"
	NSISdl::download "http://download.microsoft.com/download/d/d/9/dd9a82d0-52ef-40db-8dab-795376989c03/vcredist_x86.exe" $REDIST
	Pop $0
	StrCmp "$0" "success" DownloadSuccessful
	
	DetailPrint "* Download of Microsoft Visual Studio 2008 SP1 redistributable failed:"
	DetailPrint "* $0"
	DetailPrint "* Installation continuing anyway"
	MessageBox MB_ICONSTOP "Unable to download Microsoft Visual Studio 2008 SP1 redistributable"
	Goto InstallEnd
	
DownloadSuccessful:
	ExecWait '"$REDIST"'
	ClearErrors
	ReadRegDWORD $R0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{9A25302D-30C0-39D9-BD6F-21E6EC160475}" "Version"
	IfErrors VC90RedistInstallFailed
	
	StrCpy $RedistInstalled "1"
	Goto InstallEnd

VC90RedistInstallFailed:
	StrCpy $RedistInstalled "0"
	DetailPrint "* Some error occured installing Microsoft Visual Studio 2008 SP1 redistributable"
	DetailPrint "* It is required in order to run Multi Theft Auto : San Andreas"
	DetailPrint "* Installation continuing anyway"
	MessageBox MB_ICONSTOP "Unable to install Microsoft Visual Studio 2008 SP1 redistributable"

InstallEnd:

	StrCmp "$RedistInstalled" "1" InstallEnd2
	MessageBox MB_ICONSTOP "Unable to download Microsoft Visual Studio 2008 SP1 redistributable.\
	$\r$\nHowever installation will continue.\
	$\r$\nPlease reinstall if there are problems later."
	StrCpy $RedistInstalled "1"

InstallEnd2:
FunctionEnd

  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

ShowInstDetails show

SectionGroup /e "Engine" SECGCLIENT
	; Core
	Section "Core"
		SetOutPath $INSTDIR

		Call InstallVC90Redistributable
		
		File menu.dll
		File vgui.dll
		File engine.dll

		WriteUninstaller Sing.Uninstall.exe
	SectionEnd

	Section "Dedicated Server"
		File hlds.exe
	SectionEnd
SectionGroupEnd

SectionGroup /e "Games" SECGGAMES

	Section "Half-Life"
		; Half-Life
		SetOutPath $INSTDIR
		File hl.exe

		SetOutPath $INSTDIR\valve\dlls
		File valve\dlls\hl.dll

		SetOutPath $INSTDIR\valve\cl_dlls
		File valve\cl_dlls\client.dll
	SectionEnd

	Section "Deathmatch Classic"
		; Deathmatch Classic
		SetOutPath $INSTDIR
		File dmc.exe

		SetOutPath $INSTDIR\dmc\dlls
		File dmc\dlls\dmc.dll

		SetOutPath $INSTDIR\dmc\cl_dlls
		File dmc\cl_dlls\client.dll
	SectionEnd
SectionGroupEnd

SectionGroup /e "Tools" SECGTOOLS
	Section "Common"
		; Tools
		SetOutPath $INSTDIR\tools

		File tools\hlbsp.exe
		File tools\hlrad.exe
		File tools\hlcsg.exe
		File tools\hlvis.exe
		File tools\ripent.exe
		File tools\zhlt.wad
	SectionEnd
	
	SectionGroup /e "FGD Files" SECGFGDS
		; FGD's
		Section "Half-Life"
			File tools\halflife.fgd
		SectionEnd
		Section "Deathmatch Classic"
			File tools\dmc.fgd
		SectionEnd
		Section "Counter-Strike"
			File tools\cs.fgd
		SectionEnd
		Section "Team-Fortress Classic"
			File tools\tfc.fgd
		SectionEnd
	SectionGroupEnd
SectionGroupEnd

SectionGroup /e "Development" SECGDEV
	; SDK

	Section "SDK"
		SetOutPath $INSTDIR\development
		File src_main\sing_sdk.rar
	SectionEnd

	Section "Engine Source Code"
		SetOutPath $INSTDIR\development
		File src_main\sing_source.rar
	SectionEnd
SectionGroupEnd

Section "Uninstall"
	; Engine
	Delete $INSTDIR\hlds.exe
	Delete $INSTDIR\menu.dll
	Delete $INSTDIR\vgui.dll
	Delete $INSTDIR\engine.dll

	; Half-Life
	Delete $INSTDIR\hl.exe

	; Deathmatch Classic
	Delete $INSTDIR\dmc.exe

	; Tools
	Delete $INSTDIR\tools\hlbsp.exe
	Delete $INSTDIR\tools\hlrad.exe
	Delete $INSTDIR\tools\hlcsg.exe
	Delete $INSTDIR\tools\hlvis.exe
	Delete $INSTDIR\tools\ripent.exe
	Delete $INSTDIR\tools\zhlt.wad
	
	; FGD's
	Delete $INSTDIR\tools\halflife.fgd
	Delete $INSTDIR\tools\dmc.fgd
	Delete $INSTDIR\tools\cs.fgd
	Delete $INSTDIR\tools\tfc.fgd

	; SDK
	Delete $INSTDIR\src_main\sing_sdk.rar
	Delete $INSTDIR\src_main\sing_source.rar
SectionEnd
