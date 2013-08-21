@ECHO OFF
SETLOCAL

SET WORKDIR=C:\Software\xampp\htdocs\isadg\app

robocopy.exe %WORKDIR% P:\KOST\Tools\DI-Extractor\_workbench\xIsadg\app /MIR

PAUSE
