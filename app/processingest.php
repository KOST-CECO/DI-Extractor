<?php
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
// The process-Function of the InputFilter is called and the value of xschema extracted.
$xschema = utf8_encode( $myFilter->process( stripslashes($_POST['xschema']) ) );

// echo 'Workingdirectory &nbsp';
// echo $wdir;
//exit;
// echo '&nbsp';
// echo 'Schema &nbsp';
// echo $xschema;

// ric-o paramater
$baseuri = utf8_encode( $myFilter->process( stripslashes($_POST['baseuri']) ) );
$language = utf8_encode( $myFilter->process( stripslashes($_POST['language']) ) );
$creator = utf8_encode( $myFilter->process( stripslashes($_POST['creator']) ) );
$submissionbody = utf8_encode( $myFilter->process( stripslashes($_POST['submissionbody']) ) );
$packagename = utf8_encode( $myFilter->process( stripslashes($_POST['packagename']) ) );

// /* TODO PHP filter_input sollte verwendet werden
// $collsig   = utf8_encode( stripslashes($_POST['collsig'] ) );
// $colltitle = utf8_encode( stripslashes($_POST['colltitle']) );
// $collstyle = utf8_encode( stripslashes($_POST['collstyle']) );
// $xschema = utf8_encode( stripslashes($_POST['xschema']) );
// */

// Referenzdatei f�r die Signaturnummerierung
$reffile = "./$wdir/_signaturereference.xml";
$listfile = "./$wdir/_signaturelist.xml";

// For the 'decimal' case
$listfile2 = "./$wdir/_signaturelist2.xml";

//This connects the ID-Attribute to the ReferenceNumber. 
//Necessary for the attribute "information" in <dateiRef>-Element
$idfile ="./$wdir/_idfile.json";
$idfilexml ="./$wdir/_idfile.xml";
//The unlink() function deletes a file
@unlink($reffile);
@unlink($idfile);
@unlink($idfilexml);

// Disable libxml errors
libxml_use_internal_errors(true);

// // Load the XML source
$xml = new DOMDocument;
$xml->load("./$wdir/$metadatafile");

//Map to contain referenceNo and original ID
$idMap;

if ($collstyle == 'fortlaufend') {
    // Signatur generieren: Liste aller Objektreferenzen erzeugen
    $xsl = new DOMDocument;
    $xsl->load('createRef.xsl');
    // Configure the transformer
    $proc = new XSLTProcessor;
    $proc->registerPHPFunctions();

    $result= $proc->importStyleSheet($xsl); // attach the xsl rules
    // echo 'xxxxxxx_';
    // echo $result; 
    // echo '_--------';

    // Set parameter
    $proc->setParameter('', 'archsig', $collsig);
    $proc->setParameter('', 'archstyle', $collstyle);
    // Transform according to the xsl rules
    $reflist = $proc->transformToXML($xml);
    // echo 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
    // echo $reflist;
    // echo '--------------------------------------';
    file_put_contents("$listfile", $reflist);
//file_put_contents("reflist.xml", $reflist); // TEST
    
    // Signatur generieren: Liste aller Objektelemente fortlaufend nummerieren
    $xml_ref = new DOMDocument;
    $xml_ref->loadXML($reflist);
    // Load the XSLT source
    $xsl = new DOMDocument;
    $xsl->load('elementRef.xsl');
    // Configure the transformer
    $proc = new XSLTProcessor;
    $proc->registerPHPFunctions();
    $proc->importStyleSheet($xsl); // attach the xsl rules
    // Transform according to the xsl rules
    $numlist = $proc->transformToXML($xml_ref);
    file_put_contents("$reffile", $numlist);
    //file_put_contents("elementlist.xml", $numlist); // TEST

    //Creates a json-Map which links the Entity-IDs in eCH016 to the referenceNumber in xIsadg
    //used for the "information"-Attribute in <dateiRef"

    $xml_id_simple=simplexml_load_file("$reffile");
    

   //print_r($xml_id_simple);
   // _signaturereference.xml
    foreach ($xml_id_simple->children() as $element) {
        $iden;
        $refno;
        foreach($element->children() as $name => $data) {
            if ($name == 'referenceNo')  {
                $refno=$collsig;
                $refno .= ".";
                $refno .=$data;
                // echo "The $name is '$refno'";
            }

            if ($name == 'identitaet')  {
                // echo "The $name is '$data'";
                $iden='';
                $iden .=$data;
                
            }     
        }

        //Add both as element, $refno is the key, $iden is the value.
        if ($iden != ''){
            $idMap[$refno]=$iden;
        }
        
    }

    // file_put_contents("$idfile", json_encode($idMap));
    // This function converts array to XML document where keys of the array 
    // are converted into values and values of the array are converted into the element of XML.

    //https://fuelingphp.com/array-to-xml-php/

    
    $xmlstr = <<<XML
    <?xml version='1.0' standalone='yes'?>
    <root>
    </root>
    XML;

    $json2xml = new SimpleXMLElement($xmlstr);
    foreach($idMap as $key => $value){
        $json2xml->addChild($value, $key);
    }

    //The idfile is used to assign th new refNo to the original Id. This is used in dateiRef
    //in order to assign the correct reference in the "information" attribute.
    $json2xml->saveXML("$idfilexml");

}
else {
        // Signatur generieren: Liste aller Objektreferenzen erzeugen
        $xsl = new DOMDocument;
        $xsl->load('createRefdecimal.xsl');
        // Configure the transformer
        $proc = new XSLTProcessor;
        $proc->registerPHPFunctions();
    
        $result= $proc->importStyleSheet($xsl); // attach the xsl rules
        // echo 'xxxxxxx_';
        // echo $result; 
        // echo '_--------';
    
        // Set parameter
        $proc->setParameter('', 'archsig', $collsig);
        $proc->setParameter('', 'archstyle', $collstyle);
        // Transform according to the xsl rules
        $reflist = $proc->transformToXML($xml);
        // echo 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        // echo $reflist;
        // echo '--------------------------------------';
        file_put_contents("$listfile2", $reflist);


    //Creates a json-Map which links the Entity-IDs in eCH016 to the referenceNumber in xIsadg
    //used for the "information"-Attribute in <dateiRef"
    $xml_id_simple=simplexml_load_file("$listfile2");
   //print_r($xml_id_simple);

    //Stringify by using '' in front of $iden and $refno
    foreach ($xml_id_simple->children() as $element) {
        $iden='';
        $refno;
        foreach($element->children() as $name => $data) {
            if ($name == 'referenceCode')  {
                $refno='';
                $refno.=$data;
                // echo "The $name is '$refno'";
            }

            if ($name == 'identitaet')  {
                // echo "The $name is '$data'";
                $iden='';
                $iden .=$data;   
            }     
        }

        //Add both as element, $refno is the key, $iden is the value.
        if ($iden !=''){
            $idMap[$refno]=$iden;
        }
     }
     $xmlstr = <<<XML
     <?xml version='1.0' standalone='yes'?>
     <root>
     </root>
     XML;
 
     $json2xml = new SimpleXMLElement($xmlstr);
     foreach($idMap as $key => $value){
         $json2xml->addChild($value, $key);
     }
 
     //The idfile is used to assign th new refNo to the original Id. This is used in dateiRef
     //in order to assign the correct reference in the "information" attribute.
     $json2xml->saveXML("$idfilexml");
}

// Load the XSLT source
// The XSLT contain the rules, how the xml will be transformed e.g. into a 
// file following the pattern of xIsadg.
$xsl = new DOMDocument;
if ($xschema == 'xIsadg') {
    $xsl->load('eCH2xIsadg.xsl');
    // echo 'gix';
}
elseif ($xschema == 'xI2sadg') {
    $xsl->load('eCH2xI2sadg.xsl');
    // echo 'alles geladen';
}
elseif ($xschema == 'EAD') {
    $xsl->load('eCH2EAD.xsl');
    // echo 'gix';
}
else {
    $xsl->load('eCH2RIC.xsl');
    // echo 'gix';
}

// Configure the transformer
// https://www.php.net/manual/en/class.xsltprocessor.php
$proc = new XSLTProcessor;
$proc->registerPHPFunctions();
$proc->importStyleSheet($xsl); // attach the xsl rules
// Set parameter
$proc->setParameter('', 'fondtitle', $colltitle);
$proc->setParameter('', 'archsig', $collsig);
$proc->setParameter('', 'archstyle', $collstyle);
$proc->setParameter('', 'reffilename', "$reffile");
$proc->setParameter('', 'idfilename', "$idfilexml");
// Set ric-o parameter
$proc->setParameter('', 'baseuri', "$baseuri");
$proc->setParameter('', 'language', "$language");
$proc->setParameter('', 'creator', "$creator");
$proc->setParameter('', 'submissionbody', "$submissionbody");
$proc->setParameter('', 'packagename', "$packagename");
// Transform according to the xsl rules
$xisadg = $proc->transformToXML($xml);

file_put_contents("outlist.xml", $xisadg); // TEST




// alle Dateien im Arbeitsverzeichnis "$wdir" l�schen
// Userverzeichnis im Arbeitsverzeichnis l�schen

if ($handle = opendir($wdir)) {
    while (false !== ($file = readdir($handle))) {
        if ($file != "." && $file != ".." && $file != ".svn") {
            @unlink("$wdir/$file");
        }
    }
closedir($handle);
@rmdir($wdir);
}


// We'll be outputting a XML
// HTML Header ausgeben und damit ein Redirect ausl�sen
header('Content-type: application/xml');

// // *********** After that the file will be rendered ****************
echo $xisadg;

// // RDF Datei kopieren f�r Abfrage mit SPARQL
if ($xschema == 'RIC') {
    file_put_contents("./$wdir.rdf", $xisadg);
}




// ?>
