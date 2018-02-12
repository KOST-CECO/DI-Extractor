// You can find instructions for this file here:
// http://www.treeview.net

// Decide if the names are links or just the icons
USETEXTLINKS = 1  //replace 0 with 1 for hyperlinks

// Decide if the tree is to start all open or just showing the root folders
STARTALLOPEN = 0 //replace 0 with 1 to show the whole tree
USEICONS = 1
PERSERVESTATE = 1
ICONPATH = 'icons/' //change if the gif's folder is a subfolder, for example: 'images/'
foldersTree = gFld("AP Räte - Aktenplan Kantonsrat und Regierung", "aktenplan_export.xml")

foldersTreeA=insFld(foldersTree,gFld("8 - Finanzen, Regalien, Unternehmungen, Feuerschutz","aktenplan_export.xml"));
foldersTreeAA=insFld(foldersTreeA,gFld("83 - Finanzhaushalt des Staates","aktenplan_export.xml"));
foldersTreeAAA=insFld(foldersTreeAA,gFld("833 - Finanzausgleich","aktenplan_export.xml"));

foldersTreeAAAA=insFld(foldersTreeAAA,gFld("22.07.01 - Gesetz über die Umsetzung der Neugestaltung des Finanzausgleichs und der Aufgabenteilung zwischen Bund und Kantonen","../22.07.01/geschaeft_{AA830A6E-E5D0-4881-8810-E2ABF837E345}_20070507125710.xml"));
insDoc(foldersTreeAAAA,gLnk("R","Aktuelle Mitgliederliste","../22.07.01/{63669F88-901C-46F9-ACCA-916642777C8D}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Anträge der vorberatenden Kommission vom 12. März 2007","../22.07.01/{F45FA446-118A-4520-8864-B0CA80418DC4}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Botschaft und Entwurf der Regierung vom 13. Februar 2007","../22.07.01/{7DC1EF71-9DE7-421F-810C-3C4683A8122F}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Ergebnis der 1. Lesung des Kantonsrates vom 24. April 2007","../22.07.01/{F45FA446-118A-4520-8864-B0CA80418DC4}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Antrag SP-Fraktion zu Art. 36ter vom 23. April 2007","../22.07.01/{90E72247-267C-42C2-88C3-94BF5A62CCF6}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Antrag Denoth-St.Gallen vom 23. April 2007","../22.07.01/{7DAF74EC-788B-4475-BFB6-409D3BE8EBDB}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Antrag Frei-Diepoldsau zu Art. 36ter vom 23. April 2007","../22.07.01/{F1BEE9A7-DDD2-4CB0-9D75-12AB2729CB65}.pdf"));

foldersTreeA=insFld(foldersTree,gFld("2 - Erziehung, Bildung, Kultur","aktenplan_export.xml"));
foldersTreeAA=insFld(foldersTreeA,gFld("21 - Schulen","aktenplan_export.xml"));
foldersTreeAAA=insFld(foldersTreeAA,gFld("210 - Allgemein","aktenplan_export.xml"));

foldersTreeAAAA=insFld(foldersTreeAAA,gFld("22.06.12 - X. Nachtrag zum Volksschulgesetz","../22.06.12/geschaeft_{A3A28F5E-0435-4F93-AA8F-B726D42522DC}_20070503152319.xml"));
insDoc(foldersTreeAAAA,gLnk("R","Botschaft und Entwurf der Regierung vom 12. Dezember 2006","../22.06.12/{69D68D97-D16F-4F62-88C8-6E03CD945C3F}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Aktuelle Mitgliederliste","../22.06.12/{F30B1CF5-2948-4F23-98DA-BDDBE76E357B}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Anträge der vorberatenden Kommission vom 14. März 2007","../22.06.12/{3AD4D0BA-933C-48E5-A897-41A79638DFF8}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Antrag Hobi-Neu St.Johann zu Art. 20 vom 23. April 2007","../22.06.12/{46E5084F-407D-4582-8BEE-1D69FC0FC8E5}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Antrag SVP-Fraktion zu Art. 19bis vom 23. April 2007","../22.06.12/{C5B95F35-01E2-4A7E-A1EF-6D6F19301F86}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Antrag SVP-Fraktion zu Art. 20 vom 23. April 2007","../22.06.12/{BFB43607-D7F2-4E60-AA50-BB67041229B4}.pdf"));

foldersTreeAAAA=insFld(foldersTreeAAA,gFld("22.06.16 - XII. Nachtrag zum Gesetz über die Besoldung der Volksschullehrer","../22.06.16/geschaeft_{E74F7BA4-555C-4C93-A228-44927EF88CD5}_20070503105837.xml"));
insDoc(foldersTreeAAAA,gLnk("R","Botschaft und Entwurf der Regierung vom 19. Dezember 2006","../22.06.16/{4CE991F8-CA5D-489F-975B-6CCB4EA86091}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Antrag SVP-Fraktion vom 23. April 2007","../22.06.16/{CBDCFF70-DA6C-42EC-9117-AC26249EC88D}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Antrag SP-Fraktion zu Art. 4bis vom 23. April 2007","../22.06.16/{A913311A-0C41-47D0-8F3F-D3AF48879232}.pdf"));
insDoc(foldersTreeAAAA,gLnk("R","Aktuelle Mitgliederliste","../22.06.16/{2965A3BB-C42D-480F-9BA7-548331FB0A2C}.pdf"));
