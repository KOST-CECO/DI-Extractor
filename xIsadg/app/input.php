<?
// Ein temporäres User Verzeichnis im Arbeitsverzeichnis anlegen
$wdir = './wdir';
$tmpfile = tempnam('', 'usr_');
@unlink ($tmpfile);
$tmpdir = basename($tmpfile, '.tmp');
@mkdir("$wdir/$tmpdir", 0700);

// HTML Header ausgeben und damit ein Redirect auslösen
header ("location: ./ingest.php?usr=$tmpdir");
?>
