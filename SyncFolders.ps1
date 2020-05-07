While  ($True) {      
        #Timer statisch gesetzt
        Start-Sleep -Seconds 5
        $Folder1Path = $args[0] 
        $Folder2Path = $args[1]
        

        #Holt Folders 
        $Folder1Files = Get-ChildItem -Path $Folder1Path
        $Folder2Files = Get-ChildItem -Path $Folder2Path


        #Vergleicht Ordner1 mit Ordner2
        $FilesDiffs = Compare-Object -ReferenceObject $Folder1Files -DifferenceObject $Folder2Files

        $FilesDiffs | foreach {
                        
                $copyParams = @{
                        'Path' = $_.InputObject.Fullname
                }
                #Kopiert Ordner1 zu Ordner 2<
                if ($_.SideIndicator -eq '<=') {
                        $copyParams.Destination = $Folder2Path
                }
                #Kopiert Ordner1 zu Ordner 1
                else {
                        $copyParams.Destination = $Folder1Path
                }
                #Kopierungsprozess
                Copy-Item @copyParams
        }
}
Get-PSDrive -PSProvider FileSystem