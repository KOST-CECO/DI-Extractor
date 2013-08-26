<?
if ($wdir=='') { header ("location: ./input.php"); }
?>
<p>
Diese Referenzimplementierung konvertier eine eCH-0160 Metadaten Datei in eine xIsadg Datei<br>
Die Metadaten Datei wird mit einer Schema Validierung überprüft, verschiedene Metadatenschema werden erkannt<br>
Grundlage der Konvertierung ist der folgender Crosswalk <a href="eCH-0160 zu xIsadg_v3.xlsx">eCH-0160 zu xIsadg_v3.xlsx</a><br>
Technisch basiert die Konvertierung auf folgender XSLT Transformation <a href="eCH2xIsadg.zip">eCH2xIsadg.zip</a>
</p>
