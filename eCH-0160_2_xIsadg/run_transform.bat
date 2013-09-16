@ECHO OFF
SETLOCAL

CALL transform.bat "../SIP_20070923_RIS_3Dossier"      "xIsadg_metadata.xml"
CALL transform.bat "../SIP_20070923_RIS_3Dossier_plus" "xIsadg_metadata_plus.xml"
