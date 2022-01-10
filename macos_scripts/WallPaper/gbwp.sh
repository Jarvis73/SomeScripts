projDir=$(cd $(dirname "$0"); pwd -P)
saveDir="${projDir}/BingWallpaper"

echo "Updating wallpaper..."

# Request for Bing wallpaper XML file
response=$(curl "https://cn.bing.com/HPImageArchive.aspx?idx=0&n=1" 2>/dev/null)
# echo $response

regex="\<urlBase\>([0-9a-zA-Z\/\?\=\.\_\-]*)\<\/urlBase\>"
[[ $response =~ $regex ]] && urlBase=${BASH_REMATCH[1]};
# echo $urlBase
# /th?id=OHR.SkiTouring_ZH-CN0237169285

regex_date="\<startdate\>([0-9]*)\<\/startdate\>"
[[ $response =~ $regex_date  ]] && urlDate=${BASH_REMATCH[1]}

bingImageURL="https://cn.bing.com${urlBase}_1920x1080.jpg"
bingImageName=${urlBase#*.}
bingImageName=${urlDate}_${bingImageName%_*}.jpg
bingImageSavePath=${saveDir}/${bingImageName}

curl $bingImageURL 2>/dev/null >${bingImageSavePath}

sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '${bingImageSavePath}'"; killall Dock;

echo "Save image to ${bingImageSavePath}" 
