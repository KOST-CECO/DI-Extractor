<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<?
// Arbeitsverzeichnis setzen (relativ zum Applikationspfad)
$target = 'wdir';
$flag = '';
?>
<html>
    <head>
        <title>KOST Referenzimplementierung</title>
    </head> 
    <body>
        <h3>KOST Referenzimplementierung - Descriptive Information</h3>
        <i>eCH-0160 metadata.xml für Konvertierung auswählen:</i>
        <br>
        <table border="0">
            <tr>
                <th>
                    <form enctype="multipart/form-data" action="ingest.php" method="post"> 
                        <input type="hidden" name="MAX_FILE_SIZE" value="1000000">
                        <input name="uploadedfile" type="file" size="60">
                        <input type="submit" value="Datei übermitteln">
                    </form>
                </th> 
                <th>
                    <form action="ingest.php" method="post">
                        <input type="hidden" name="RESET" value="true">
                        <input type="submit" value="Reset">
                    </form>
                </th>
            </tr>
        </table>
        <hr>
<?

// alle Dateien im Arbeitsverzeichnis "$target" löschen
if ($_POST['RESET']=='true') {
    if ($handle = opendir($target)) {
        while (false !== ($file = readdir($handle))) {
            if ($file != "." && $file != ".." && $file != ".svn") {
                unlink("$target/$file");
            }
        }
    closedir($handle);
    }
}

// hochgeladene Datei ins Arbeitsverzeichnis kopieren
if ($_FILES['uploadedfile']['name'] != "") {
    $target_file = "$target/" . basename($_FILES['uploadedfile']['name']);
// Achtung: verhindert das Kopieren von php Dateien auf den Webserver
    $target_file = str_replace('.php', '.p~p', $target_file);
    if (!move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_file)) {
        echo "<p><b>Beim übernehmen der Datei ist ein Fehler aufgetreten!</b></p>";
    }
}
echo "<i>Folgende Datei steht zur Konvertierung bereit:</i>";
libxml_use_internal_errors(true);
if ($handle = opendir($target)) {
    while (false !== ($file = readdir($handle))) {
        if ($file != "." && $file != ".." && $file != ".svn") {
            echo "<li>";
            echo "$file&nbsp;&nbsp;&nbsp; (" . filesize("$target/$file") . " bytes)";
            if (substr($file, -4) == ".xml") {
                $xml = new DOMDocument(); 
                $xml->load("$target/$file");
                if ($xml->schemaValidate('./xsd/arelda.xsd')) { 
                   echo "&nbsp;&nbsp;&nbsp; <b><i>eCH-0160 / arelda_v4 SIP Metadata</i></b>";
                   $flag = "$target/$file";
                } 
                elseif ($xml->schemaValidate('./xsd_v3.13.2/arelda_v3.13.2.xsd')) { 
                    echo "&nbsp;&nbsp;&nbsp; arelda_v3.13.2 SIP Metadata";
                }
                elseif ($xml->schemaValidate('./xIsadg_v1.6.1.xsd')) { 
                    echo "&nbsp;&nbsp;&nbsp; xIsadg_v1.6 SIP Metadata";
                }
                elseif ($xml->schemaValidate('./ead.xsd')) { 
                    echo "&nbsp;&nbsp;&nbsp; EAD Metadata";
                }
                else { 
                    echo "&nbsp;&nbsp;&nbsp; unbekannte XML Datei";
                }
            }
            echo "</li>";
        }
    }
closedir($handle);
}
if ($flag != '') {
include 'maninput.php';
}
?>
    </body>
</html>
