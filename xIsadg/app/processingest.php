<?
//date_default_timezone_set('Europe/Berlin');

// Ingest Informationen verarbeiten
if ($_POST['wdir']=='') { die; } else {$wdir = $_POST['wdir']; }
if ($_POST['metadatafile']=='') { die; } else {$metadatafile = $_POST['metadatafile']; }
if (!is_file("./$wdir/$metadatafile")) { { header ("location: ./input.php"); } }

// include class file for "PHP Input Filter"
require_once("class.inputfilter.php");
$myFilter = new InputFilter();
$collsig   = utf8_encode( $myFilter->process( stripslashes($_POST['collsig'] ) ) );
$colltitle = utf8_encode( $myFilter->process( stripslashes($_POST['colltitle']) ) );
$collstyle = utf8_encode( $myFilter->process( stripslashes($_POST['collstyle']) ) );
$xschema = utf8_encode( $myFilter->process( stripslashes($_POST['xschema']) ) );

// Referenzdatei für die Signaturnummerierung
$reffile = "./$wdir/_signaturereference.xml";
@unlink($reffile);

// Disable libxml errors
libxml_use_internal_errors(true);

// Load the XML source
$xml = new DOMDocument;
$xml->load("./$wdir/$metadatafile");

if ($collstyle == 'fortlaufend') {
    // Signatur generieren: Liste aller Objektreferenzen erzeugen
    // Load the XSLT source
    $xsl = new DOMDocument;
    $xsl->load('xIcreateRef.xsl');
    // Configure the transformer
    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl); // attach the xsl rules
    // Set parameter
    $proc->setParameter('', 'archsig', $collsig);
    // Transform according to the xsl rules
    $reflist = $proc->transformToXML($xml);
    
    // Signatur generieren: Liste aller Objektreferenzen fortlaufend nummerieren
    // Load the XML source
    $xml_ref = new DOMDocument;
    $xml_ref->loadXML($reflist);
    // Load the XSLT source
    $xsl = new DOMDocument;
    $xsl->load('xInumberRef.xsl');
    // Configure the transformer
    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl); // attach the xsl rules
    // Transform according to the xsl rules
    $numlist = $proc->transformToXML($xml_ref);
    file_put_contents("$reffile", $numlist);
}
else {
    $reffile = 'null.xml';
}

// Load the XSLT source
$xsl = new DOMDocument;
if ($xschema == 'xIsadg') {
    $xsl->load('eCH2xIsadg.xsl');
}
else {
    $xsl->load('eCH2EAD.xsl');
}
// Configure the transformer
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl); // attach the xsl rules
// Set parameter
$proc->setParameter('', 'fondtitle', $colltitle);
$proc->setParameter('', 'archsig', $collsig);
$proc->setParameter('', 'reffilename', "$reffile");
// Transform according to the xsl rules
$xisadg = $proc->transformToXML($xml);

// alle Dateien im Arbeitsverzeichnis "$wdir" löschen
if ($handle = opendir($wdir)) {
    while (false !== ($file = readdir($handle))) {
        if ($file != "." && $file != ".." && $file != ".svn") {
            @unlink("$wdir/$file");
        }
    }
closedir($handle);
// Userverzeichnis im Arbeitsverzeichnis löschen
@rmdir($wdir);
}

// We'll be outputting a XML
header('Content-type: application/xml');
echo $xisadg;

// HTML Header ausgeben und damit ein Redirect auslösen
//file_put_contents("./$wdir/out.xml", $xisadg);
//header ("location: ./$wdir/out.xml");
?>
