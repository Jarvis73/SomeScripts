Write-Host "Updating wallpaper...`n"

# Request for Bing wallpaper XML file
[xml]$reponse = Invoke-WebRequest -Uri "https://cn.bing.com/HPImageArchive.aspx?idx=0&n=1" -UseBasicParsing

# Extract date and image url
$image = $reponse.images.image
$startdate = $image.startdate
$bingImageURL = "https://cn.bing.com" + $image.url
$bingImageName = $image.urlBase.split("/")[-1].split("_")[0] + "." + $image.url.split(".")[-1]

# Check folders
$wallPaperPath = [System.Environment]::GetFolderPath("MyPictures") + "\EverydayBingWallPapers"

$monthWallPaperPath = ($wallPaperPath, $startdate.Substring(0, 4), $startdate.Substring(4, 2)) -join "\"
if (!(Test-Path $wallPaperPath))
{
    $null = New-Item $wallPaperPath -ItemType "directory"
}

$wallPaperFile = ($monthWallPaperPath, $bingImageName) -join "\"

# Download and save image
if (!(Test-Path $wallPaperFile))
{
    Invoke-WebRequest $bingImageURL -OutFile $wallPaperFile
}

# Set wallpaper
. "$PSScriptRoot\SetWallPaper.ps1"
Set-Wallpaper -Path $wallPaperFile

Write-Host "Finished!"

exit