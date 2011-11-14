@ECHO OFF
SETLOCAL

REM ein neues SVN Repository "DI-Extractor" anlegen
svnadmin.exe create N:/KOST/SVN/DI-Extractor

REM das aktuelle Verzeichnis ins neue SVN Repository kopieren
svn.exe import . file:///N:/KOST/SVN/DI-Extractor

REM das aktuelle Projekt in das Arbeitsverzeichnis _workbench auschecken
svn checkout file:///N:/KOST/SVN/DI-Extractor _workbench
