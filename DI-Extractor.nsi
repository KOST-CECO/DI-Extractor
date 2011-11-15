; InstallOptions script demonstrating custom buttons
;----------------------------------------------------

!include WinMessages.nsh

; The name of the installer
Name "DI-Extractor"

; The file to write
OutFile "DI-Extractor.exe"

; Show install details
ShowInstDetails show

; Called before anything else as installer initialises
Function .onInit
	; Extract InstallOptions files
	; $PLUGINSDIR will automatically be removed when the installer closes
	InitPluginsDir
	File /oname=$PLUGINSDIR\test.ini "extractor.ini"
	; Initialise certain dialog values but don't show it yet
	WriteINIStr "$PLUGINSDIR\test.ini" "Field 5" "State" "$EXEDIR\"
	WriteINIStr "$PLUGINSDIR\test.ini" "Field 7" "State" "$EXEDIR"
FunctionEnd

; Our custom page
Page custom ShowCustom LeaveCustom ": Select SIP"

Function ShowCustom
	; Initialise the dialog but don't show it yet
	InstallOptions::initDialog "$PLUGINSDIR\test.ini"
	; In this mode InstallOptions returns the window handle so we can use it
	Pop $0
	; Now show the dialog and wait for it to finish
	InstallOptions::show
	; Finally fetch the InstallOptions status value (we don't care what it is though)
	Pop $0
FunctionEnd

Function LeaveCustom
	; At this point the user has either pressed Next or one of our custom buttons
	; We find out which by reading from the INI file
	ReadINIStr $0 "$PLUGINSDIR\test.ini" "Settings" "State"
	StrCmp $0 0 validate		; Next button?
	StrCmp $0 2 droplist		; "Folder|ZIP" drop-list?
	StrCmp $0 3 clearbtn		; "Clear" button?
	Abort ; Return to the page

clearbtn:
	; Clear all text fields
	ReadINIStr $1 "$PLUGINSDIR\test.ini" "Field 5" "HWND"
	SendMessage $1 ${WM_SETTEXT} 0 "STR:"
	ReadINIStr $1 "$PLUGINSDIR\test.ini" "Field 7" "HWND"
	SendMessage $1 ${WM_SETTEXT} 0 "STR:"
	Abort ; Return to the page

droplist:
	; Make the DirRequest field depend on the droplist
	ReadINIStr $0 "$PLUGINSDIR\test.ini" "Field 2" "State"
	; Folder format is selected
	StrCmp $0 "SIP (Folder Format)" 0 +12
		ReadINIStr $1 "$PLUGINSDIR\test.ini" "Field 5" "HWND"
		EnableWindow $1 0
		ReadINIStr $1 "$PLUGINSDIR\test.ini" "Field 5" "HWND2"
		EnableWindow $1 0
		WriteINIStr "$PLUGINSDIR\test.ini" "Field 5" "Flags" "DISABLED"
		; -----------
		ReadINIStr $1 "$PLUGINSDIR\test.ini" "Field 7" "HWND"
		EnableWindow $1 1
		ReadINIStr $1 "$PLUGINSDIR\test.ini" "Field 7" "HWND2"
		EnableWindow $1 1
		WriteINIStr "$PLUGINSDIR\test.ini" "Field 7" "Flags" ""
		Goto +11
	; ZIP Format is selected
		ReadINIStr $1 "$PLUGINSDIR\test.ini" "Field 5" "HWND"
		EnableWindow $1 1
		ReadINIStr $1 "$PLUGINSDIR\test.ini" "Field 5" "HWND2"
		EnableWindow $1 1
		WriteINIStr "$PLUGINSDIR\test.ini" "Field 5" "Flags" ""
		; -----------
		ReadINIStr $1 "$PLUGINSDIR\test.ini" "Field 7" "HWND"
		EnableWindow $1 0
		ReadINIStr $1 "$PLUGINSDIR\test.ini" "Field 7" "HWND2"
		EnableWindow $1 0
		WriteINIStr "$PLUGINSDIR\test.ini" "Field 7" "Flags" "DISABLED"
	Abort ; Return to the page
	
validate:
	; Make the validation depend on the droplist
	ReadINIStr $0 "$PLUGINSDIR\test.ini" "Field 2" "State"
	StrCmp $0 "SIP (Folder Format)" foldersip zipsip

foldersip:
	ReadINIStr $0 "$PLUGINSDIR\test.ini" "Field 7" "State"
	IfFileExists "$0/header/metadata.xml" done
		MessageBox MB_OK "$0 is not a valid SIP"
		Abort ; Return to the page

zipsip:
	MessageBox MB_OK "SIP in ZIP format not yet supported"
	Abort ; Return to the page

done:
FunctionEnd

; Installation page
Page instfiles

Section
	;Get Install Options dialog user input
	ReadINIStr $0 "$PLUGINSDIR\test.ini" "Field 2" "State"
	DetailPrint "Install X=$0"
	ReadINIStr $0 "$PLUGINSDIR\test.ini" "Field 5" "State"
	DetailPrint "Install X=$0"
	ReadINIStr $0 "$PLUGINSDIR\test.ini" "Field 7" "State"
	DetailPrint "Install X=$0"
SectionEnd
