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
<script src="./jquery.min.js"></script>
<script src="./rico.js"></script>
    <title>KOST Descriptive Information Converter 2.1</title>
  </head>
  <body background="./background.jpg" onload="ricOff()">
    <h1>KOST Descriptive Information Converter 2.1 <span class="versionText">(Rev. 166)</span></h1>
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
              <!-- actual upload which is hidden -->
              <input name="uploadedfile" size="80" type="file" class="custom-file-input" id="actual-btn" hidden/> 
              <!-- custom upload button -->
              <label class="btn" for="actual-btn"> Datei ausw&auml;hlen </label> 
              <!-- name of file chosen -->
              <span class="custom-file-label" id="file-chosen"> Keine Datei ausgew&auml;hlt </span>
              <!-- submit button -->
              <input class="btn" value="Datei &uuml;bermitteln" type="submit">
            </form>
          </th>
          <th>
            <form action="ingest.php" method="post">
              <input name="usr" value=<?=$usr?> type="hidden">
              <input name="RESET" value="true" type="hidden">
              <!-- reset button -->
              &nbsp;&nbsp;&nbsp;<input class="btn" value="Reset" type="submit" style="font-size:100%">
            </form>
          </th>
        </tr>
    </table>
<script>
// Add the following code if you want the name of the file appear on select
$(".custom-file-input").on("change", function() {
var fileName = $(this).val().split("\\").pop();
$(this).siblings(".custom-file-label").addClass("selected").html(fileName);
});
</script>
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
                elseif ($xml->schemaValidate('./xIsadg_v2.1.xsd')) {
                    echo "&nbsp;&nbsp;&nbsp; xIsadg_v2.1 DI Metadata";
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
