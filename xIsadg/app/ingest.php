<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<?
// Arbeitsverzeichnis setzen (relativ zum Applikationspfad)
$target = "wdir";
?>
<html>
    <head>
        <title>KOST Referenzimplementierung</title>
    </head>
    <body>
        <h3>KOST Referenzimplementierung - Ingest</h3>
        <form enctype="multipart/form-data" action="ris_ingest.php" method="post">
            <i>Dateien f�r Ingest w�hlen:</i><br>
            <input type="hidden" name="MAX_FILE_SIZE" value="1000000">
            <input name="uploadedfile" type="file" size="60">
            <input type="submit" value="Datei �bermitteln">
        </form>
    <hr>

<?
if ($_FILES['uploadedfile']['name'] != "") {
    $target_file = "$target/" . basename($_FILES['uploadedfile']['name']);
// Achtung: verhindert das Kopieren von php Dateien auf den Webserver
    $target_file = str_replace('.php', '.p~p', $target_file);
    if (!move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_file)) {
        echo "<p><b>Beim �bernehmen der Datei ist ein Fehler aufgetreten!</b></p>";
    }
}
echo "<i>Folgende Dateien stehen zum Ingest bereit:</i>";
if ($handle = opendir($target)) {
    while (false !== ($file = readdir($handle))) {
        if ($file != "." && $file != "..") {
            if (substr($file, 0, 10) == "geschaeft_") {
            $geschaeft = $file;
            }
            echo "<li>$file&nbsp;&nbsp;&nbsp; (" . filesize("$target/$file") . " bytes)</li>";
        }
    }
closedir($handle);
}

if ($geschaeft != '') {
include 'maninput.php';
}
?>
    </body>
</html>
