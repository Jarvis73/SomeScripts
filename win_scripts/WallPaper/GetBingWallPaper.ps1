function print($info)
{
    Get-Date -UFormat "%H:%M:%S " |Write-Host -NoNewline
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
        Start-Sleep -Seconds 5
    }
}

# Extract date and image url
$image = $reponse.images.image
print($image.startdate)
print($image.fullstartdate)
print($image.enddate)
print($image.url)
print($image.urlBase)
$enddate = $image.enddate
$bingImageURL = "https://cn.bing.com" + $image.urlBase + "_1920x1080.jpg"
$bingImageName = $enddate.Substring(6, 2) + "_" + $image.urlBase.split("/")[-1].split("_")[0].split(".")[-1] +`
                 "." + $image.url.split("&")[0].split(".")[-1]
$bingImageName = $bingImageName -replace "[/\\:\*\?""<>\|]"

# Check folders
# $wallPaperPath = [System.Environment]::GetFolderPath("MyPictures") + "\EverydayBingWallPapers"
$wallPaperPath = "D:\OneDrive - zju.edu.cn\Photos\BingEveryday"
$monthWallPaperPath = ($wallPaperPath, $enddate.Substring(0, 4), $enddate.Substring(4, 2)) -join "\"
if (!(Test-Path $monthWallPaperPath))
{
    $null = New-Item $monthWallPaperPath -ItemType "directory"
}

$wallPaperFile = ($monthWallPaperPath, $bingImageName) -join "\"

# Download and save image
if (!(Test-Path $wallPaperFile) -or ($args[0] -eq "-renew") )
{
    print("Trying download image...")
    while (1)
    {
        $imageResponse = Invoke-WebRequest $bingImageURL -UseBasicParsing
        $StatusCode = $imageResponse.StatusCode

        if (!($StatusCode -eq 200)) {
            print("Retry...")
        }
        else {
            break
        }
    }

    [io.file]::WriteAllBytes($wallPaperFile, $imageResponse.Content)
}

print($wallPaperFile)

# ============================================================================
# Set wallpaper

# Method 1: This method only set for the current virtual desktop
# . "$PSScriptRoot\SetWallPaper.ps1"
# Set-Wallpaper -Image $wallPaperFile -Style Stretch

# Method 2: Set for all virtual desktops (Need install VirtualDesktop module)
Set-AllDesktopWallpapers $wallPaperFile

print("Finished!")

exit