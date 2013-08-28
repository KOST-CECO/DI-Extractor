<?
// Ein tempor„res User Verzeichnis im Arbeitsverzeichnis anlegen
$wdir = './wdir';
$tmpfile = tempnam('', 'usr_');
@unlink ($tmpfile);
$tmpdir = basename($tmpfile, '.tmp');
@mkdir("$wdir/$tmpdir", 0700);

// IP und Userid festhalten
$timestamp = date('Y-m-d H:i:s');
file_put_contents ( "$wdir/usr.txt", "$timestamp\t$_SERVER[REMOTE_ADDR]\t$tmpdir\n", FILE_APPEND);

// HTML Header ausgeben und damit ein Redirect auslösen
header ("location: ./ingest.php?usr=$tmpdir");
?>
