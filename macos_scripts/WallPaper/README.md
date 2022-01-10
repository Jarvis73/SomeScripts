# GetBingWallpaper for MacOS

## Run once

```bash
# gbwp: Get Bing WallPaper
bash gbwp.sh
```

## Scheduled job

1. update paths and time in `com.zjw.BingWallpaper.plist` file
2. move `com.zjw.BingWallpaper.plist` to `~/Library/LaunchAgents`
3. start job: 

```bash
launchctl load path/to/com.zjw.BingWallpaper.plist
```

