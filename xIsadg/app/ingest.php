<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<?
// Arbeitsverzeichnis setzen (relativ zum Applikationspfad)
$wdir = 'wdir';
$metadatafile = '';
?>
<html>
  <head>
    <link href="ingest.css" rel="stylesheet" type="text/css"/>
    <title>KOST Referenzimplementierung</title>
  </head>
  <body>
    <h3>KOST Referenzimplementierung - Descriptive Information</h3>
    <i>eCH-0160 metadata.xml f&uuml;r Konvertierung ausw&auml;hlen:</i>
    <br>
    <table border="0">
      <tbody>
        <tr>
          <th>
            <form enctype="multipart/form-data" action="ingest.php" method="post">
              <input name="MAX_FILE_SIZE"  value="1000000" type="hidden">
              <input name="uploadedfile" size="60" type="file">
              <input value="Datei &uuml;bermitteln" type="submit">
            </form>
          </th>
          <th>
            <form action="ingest.php" method="post">
              <input name="RESET" value="true" type="hidden">
              <input value="Reset" type="submit">
            </form>
          </th>
        </tr>
      </tbody>
    </table>
    <hr>
<?
// alle Dateien im Arbeitsverzeichnis "$wdir" l�schen
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
// hochgeladene Datei ins Arbeitsverzeichnis kopieren
if ($_FILES['uploadedfile']['name'] != "") {
    $target_file = "$wdir/" . basename($_FILES['uploadedfile']['name']);
// Achtung: verhindert das Kopieren von php Dateien auf den Webserver
    $target_file = str_replace('.php', '.p~p', $target_file);
    if (!move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_file)) {
        echo "<p><b>Beim &uuml;bernehmen der Datei ist ein Fehler aufgetreten!</b></p>";
    }
}
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
                if ($xml->schemaValidate('./xsd/arelda.xsd')) {
                   echo "&nbsp;&nbsp;&nbsp; eCH-0160 / arelda_v4 SIP Metadata";
                   $metadatafile = "$file";
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
    echo "</ul>";
    closedir($handle);
}
if ($metadatafile != '') {
include 'maninput.php';
}
    ?>
  </body>
</html>