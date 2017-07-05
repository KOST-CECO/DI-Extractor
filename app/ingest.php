<?php
// wenn kein User Verzeichnis existiert wird ein Redirect auf input.php ausgelöst
$usr = '';
if (array_key_exists('usr', $_GET)) {
    if ($_GET['usr']!='') { $usr = $_GET['usr']; }
}
if (array_key_exists('usr', $_POST)) {
    if ($_POST['usr']!='') { $usr = $_POST['usr']; }
}
if ($usr=='') { header ("location: ./input.php"); }

// Arbeitsverzeichnis setzen (relativ zum Applikationspfad)
$wdir = "wdir/$usr";
if (!is_dir($wdir)) { header ("location: ./input.php"); }
$metadatafile = '';
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
  <head>
    <link href="ingest.css" rel="stylesheet" type="text/css"/>
    <title>KOST Referenzimplementierung</title>
  </head>
  <body background="background.jpg">
    <h1>KOST Referenzimplementierung - Descriptive Information 2.0 <span class="versionText">(Rev. 42)</span></h1>
    <?php include 'helptext.php'; ?>
    <i>Eine eCH-0160 Metadaten Datei f&uuml;r die Konvertierung ausw&auml;hlen:</i>
    <br>
    <!-- Upload Formular, zweispaltig -->
    <table>
        <tr>
          <th>
            <form enctype="multipart/form-data" action="ingest.php" method="post">
              <input name="MAX_FILE_SIZE"  value="100000000" type="hidden">
              <input name="usr" value=<?=$usr?> type="hidden">
              <input name="uploadedfile" size="80" type="file" style="font-size:100%">
              <input value="Datei &uuml;bermitteln" type="submit" style="font-size:100%">
            </form>
          </th>
          <th>
            <form action="ingest.php" method="post">
              <input name="usr" value=<?=$usr?> type="hidden">
              <input name="RESET" value="true" type="hidden">
              <input value="Reset" type="submit" style="font-size:100%">
            </form>
          </th>
        </tr>
    </table>
    <hr>
<?php
// alle Dateien im Arbeitsverzeichnis "$wdir/$usr" löschen
if (array_key_exists('RESET', $_POST)) {
    if ($_POST['RESET']=='true') {
        if ($handle = opendir($wdir)) {
            while (false !== ($file = readdir($handle))) {
                if ($file != "." && $file != ".." && $file != ".svn") {
                    unlink("$wdir/$file");
                }
            }
        closedir($handle);
        }
    }
}

// hochgeladene Datei ins Arbeitsverzeichnis kopieren
if (array_key_exists('uploadedfile', $_FILES)) {
    if ($_FILES['uploadedfile']['name'] != "") {
        $target_file = "$wdir/" . basename($_FILES['uploadedfile']['name']);
// Achtung: verhindert das Kopieren von php Dateien auf den Webserver
        $target_file = str_replace('.php', '.p~p', $target_file);
        if (!move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_file)) {
            echo "<p><b>Beim &uuml;bernehmen der Datei ist ein Fehler aufgetreten!</b></p>";
        }
    }
}

// hochgeladene Datei in Liste anzeigen
echo "<i>Folgende Dateien sind bereits &uuml;bertragen:</i>";
libxml_use_internal_errors(true);
if ($handle = opendir($wdir)) {
    echo "<ul>";
    while (false !== ($file = readdir($handle))) {
        if ($file != "." && $file != ".." && $file != ".svn") {
            echo "<li>";
            echo "$file&nbsp;&nbsp;&nbsp; (" . filesize("$wdir/$file") . " bytes)";
            if (substr($file, -4) == ".xml") {
                $xml = new DOMDocument();
                $xml->load("$wdir/$file");
                if ($xml->schemaValidate('./xsd_v4/arelda.xsd')) {
                   echo "&nbsp;&nbsp;&nbsp; eCH-0160 1.0 / arelda_v4 SIP Metadata";
                   // konvertierung wird initialisiert
                   $metadatafile = "$file";
                }
                elseif ($xml->schemaValidate('./xsd_v4.1/arelda.xsd')) {
                   echo "&nbsp;&nbsp;&nbsp; eCH-0160 1.1 / arelda_v4.1 SIP Metadata";
                   // konvertierung wird initialisiert
                   $metadatafile = "$file";
                }
                elseif ($xml->schemaValidate('./xsd_v3.13.2/arelda_v3.13.2.xsd')) {
                    echo "&nbsp;&nbsp;&nbsp; arelda_v3.13.2 SIP Metadata";
                }
                elseif ($xml->schemaValidate('./xIsadg_v1.6.1.xsd')) {
                    echo "&nbsp;&nbsp;&nbsp; xIsadg_v1.6 DI Metadata";
                }
                elseif ($xml->schemaValidate('./xIsadg_v2.0.xsd')) {
                    echo "&nbsp;&nbsp;&nbsp; xIsadg_v2.0 DI Metadata";
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
    echo "</ul>";
    closedir($handle);
}
if ($metadatafile != '') {
include 'maninput.php';
}
include 'copyright.php'; ?>
  </body>
</html>
