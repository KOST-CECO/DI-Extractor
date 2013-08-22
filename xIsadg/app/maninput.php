<hr>
<i>Folgende Datei steht zur Konvertierung bereit: <b><?=$metadatafile?></b></i><br><br>
<hr>
<form action="processingest.php" method="get">
    <input name="metadatafile" value="<? echo $metadatafile; ?>" type="hidden">
    <input name="wdir" value="<? echo $$wdir; ?>" type="hidden">
    <table border="0">
        <tr>
            <td colspan="2" rowspan="1">
                <i>Manuelle Angaben zur Zielakzession (Archivtektonik):</i></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Bestand-Signatur:</td>
            <td>
                <input name="collsig" size="20" type="text" title="Signatur (Archiv- & Bestandkürzel) des Knoten in der Archivtektonik an den die Ablieferung eingehängt werden soll"> Bestandtitel:
                <input name="colltitle" size="60" type="text" title="Beschreibung des Knotens in der Archivtektonik an den die Ablieferung eingehängt werden soll"></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td colspan="2" rowspan="1">
                <i>Angaben zur Signaturbildung:</i></td>
        </tr>
        <tr>
            <td style="text-align: right;">
                Signaturstil:</td>
            <td>
                <input type="radio" name="collstyle" value="fortlaufend" title="Fortlaufend nummeriert in der Art SIG.1 SIG.2 SIG.3" checked> fortlaufende Nummerierung
                <input type="radio" name="collstyle" value="dezimal" title="Hierarchische Dezimalgliederung in der Art SIG.1 SIG.1.1 SIG.1.2 SIG.1.3">
                dezimal Gliederung</td>
        </tr>
        <tr>
            <td colspan="2" rowspan="1" style="text-align: right;">
                <input value="Konvertieren" type="submit"></td>
        </tr>
    </table>
</form>
<hr>
