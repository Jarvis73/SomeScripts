#########################################################################
#
# Copyright © 2018 - 2019 Jianwei ZHANG
# All rights reserved.
#
# Info: Download Bing everyday picture and set as wallpaper.
#
# Modified:
#   * Initialization
#   * Print running information
#   * Check network and restart every one minute if failed
#
##########################################################################

function print($info)
{
    Get-Date -UFormat "%H:%M:%S " |write-host -NoNewline
    Write-Host $info    
}

print("Updating wallpaper...")

# Request for Bing wallpaper XML file
while (1)
{
    try {
        [xml]$reponse = Invoke-WebRequest -Uri "https://cn.bing.com/HPImageArchive.aspx?idx=0&n=1" -UseBasicParsing
        break
    }
    catch [System.Net.WebException]{
        print("Failed! Please check the network!")
        Start-Sleep -Seconds 60
    }
}

# Extract date and image url
$image = $reponse.images.image
$enddate = $image.enddate
$bingImageURL = "https://cn.bing.com" + $image.urlBase + "_1920x1080.jpg"
$bingImageName = $enddate.Substring(6, 2) + "_" + $image.urlBase.split("/")[-1].split("_")[0] + "." + $image.url.split(".")[-1]

# Check folders
$wallPaperPath = [System.Environment]::GetFolderPath("MyPictures") + "\EverydayBingWallPapers"
$monthWallPaperPath = ($wallPaperPath, $enddate.Substring(0, 4), $enddate.Substring(4, 2)) -join "\"
if (!(Test-Path $monthWallPaperPath))
{
    $null = New-Item $monthWallPaperPath -ItemType "directory"
}

$wallPaperFile = ($monthWallPaperPath, $bingImageName) -join "\"

# Download and save image
if (!(Test-Path $wallPaperFile))
{
    print("Trying download image...")
    Invoke-WebRequest $bingImageURL -OutFile $wallPaperFile

    # If failed, retry every 60 seconds
    while (!(Test-Path $wallPaperFile))
    {
        Start-Sleep -Seconds 60
        Invoke-WebRequest $bingImageURL -OutFile $wallPaperFile
    }
}

# Set wallpaper
. "$PSScriptRoot\SetWallPaper.ps1"
Set-Wallpaper -Path $wallPaperFile

print("Finished!")

exit