@ECHO OFF
SETLOCAL

SET WORKDIR=%CD%

robocopy.exe %WORKDIR% P:\KOST\Tools\DI-Extractor\_workbench\app /MIR

PAUSE
