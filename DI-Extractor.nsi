; DI-Extractor.nsi
;--------------------------------

; The name of the installer
Name "DI-Extractor"

; The file to write
OutFile "DI-Extractor.exe"

; The default installation directory
; InstallDir $DESKTOP
InstallDir $EXEDIR\

; Request application privileges for Windows Vista
RequestExecutionLevel user

; Text above the controls, to the right of the installation icon
DirText "Select directory to designated SIP" "SIP Folder" "" "Select directory to designated SIP"

; Overrides the default install button text (of "Install") with the specified text
InstallButtonText "Show SIP..."

;--------------------------------

; Pages

Page directory "" "" stayInDirectory
Page instfiles

;--------------------------------

Function stayInDirectory
  IfFileExists "$INSTDIR/header/metadata.xml" no goto_abort
  goto_abort:
    MessageBox MB_OK "$INSTDIR is not a valid SIP"
    Abort
   no:
FunctionEnd

;--------------------------------

; The stuff to install
Section "" ;No components page, name is not important

  ; Set output path to the installation directory.
  ;SetOutPath $INSTDIR
  
  ; Put file there
  ;File example1.nsi

  ; Execute the specified program and continue immediately
  Exec '"$PROGRAMFILES\Internet Explorer\iexplore.exe" "file:\\$EXEDIR\index.html?sip=$INSTDIR"'

  Quit
  
SectionEnd ; end the section
