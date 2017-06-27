<?php
if ($wdir=='') { header ("location: ./input.php"); }
?>
<hr>
<i> Folgende Datei steht zur Konvertierung bereit:
    <b>
        <?=$metadatafile?></b></i>
<br>
<br>
<!-- Formular für manuellen Dateninput, dreispaltig -->
<form action="processingest.php" method="post">
    <input name="metadatafile" value="<?php echo $metadatafile; ?>" type="hidden">
    <input name="wdir" value=<?=$wdir?> type="hidden">
    <table style="width: 100%;">
        <tr>
            <td colspan="3" rowspan="1">
                <i>Manuelle Angaben zur Zielakzession (Archivtektonik):</i></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Bestand-Signatur:</td>
            <td colspan="2" rowspan="1">
                <input name="collsig" size="20" type="text" title="Signatur (Archiv- & Bestandk&uuml;rzel) des Knoten in der Archivtektonik an den die Ablieferung eingeh&auml;ngt werden soll"> Bestandtitel:
                <input name="colltitle" size="60" type="text" title="Beschreibung des Knotens in der Archivtektonik an den die Ablieferung eingeh&auml;ngt werden soll"></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td colspan="3" rowspan="1">
                <i>Angaben zur Signaturbildung:</i></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Signaturstil:</td>
            <td colspan="2" rowspan="1">
                <input type="radio" name="collstyle" value="fortlaufend" title="Fortlaufend nummeriert in der Art SIG.1 SIG.2 SIG.3" checked> fortlaufende Nummerierung
                <input type="radio" name="collstyle" value="dezimal" title="Hierarchische Dezimalgliederung in der Art SIG.1 SIG.1.1 SIG.1.2 SIG.1.3">
                dezimal Gliederung</td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Ausgabeformat:</td>
            <td>
                <input type="radio" name="xschema" value="xIsadg" title="Ausgabe als xIsadg Metadaten Datei" checked> xIsadg
                <input type="radio" name="xschema" value="xI2sadg" title="Ausgabe als xIsadg Metadaten Datei Version 2.0" > xIsadg 2.0
                <input type="radio" name="xschema" value="EAD" title="Ausgabe als EAD Metadaten Datei (METS Matterhorn Style)">
                EAD</td>
            <td>
                <div style="text-align: right;">
                    <input value="Konvertieren" type="submit" style="font-size:100%">
                </div></td>
        </tr>
    </table>
</form>
