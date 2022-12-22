# -- images --
$images=Get-ChildItem * -Include *.jpg,*png -LiteralPath ".\"

foreach ($imageFile in $images){
    $imagePath = $imageFile.FullName
    Resolve-Path $imagePath

    try {
        $image = [System.Drawing.Bitmap]::new($imagePath)

        # get the "DateTaken" Property of the image
        $dateTaken = $image.GetPropertyItem(36867).Value
        $dateString = [System.Text.Encoding]::ASCII.GetString($dateTaken) 
        $originalImageDate = [datetime]::ParseExact($dateString,"yyyy:MM:dd HH:mm:ss`0", $Null)
        
        # set the last write time to the original date
        (Get-ChildItem $imagePath).LastWriteTime=$originalImageDate
        (Get-ChildItem $imagePath).LastWriteTimeUtc=$originalImageDate

        Write-Host "Successfully fixed date of image '$($imagePath)'"
    } catch {
        Write-Host "Error fixing the date of image '$($imagePath)'"
    }
}

# -- videos --
$videos=Get-ChildItem -Filter "*.mp4" -LiteralPath ".\"

foreach ($videoFile in $videos){
    $shell = New-Object -COMObject Shell.Application;
    $folder = Split-Path $videoFile;
    $file = Split-Path $videoFile -Leaf;
    $shellfolder = $shell.Namespace($folder);
    $shellfile = $shellfolder.ParseName($file);
    
    try {
        # get the date encoded property of the video
        $originalVideoDate = $ShellFile.ExtendedProperty("System.Media.DateEncoded")

        # set the last write time to the original date of the video
        (Get-ChildItem $videoFile).LastWriteTime=$originalVideoDate
        (Get-ChildItem $videoFile).LastWriteTimeUtc=$originalVideoDate

        Write-Host "Successfully fixed date of video '$($videoFile)'"
    } catch {
        Write-Host "Error fixing the date of video '$($videoFile)'"
    }
}
