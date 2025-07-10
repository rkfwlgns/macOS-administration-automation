#this script is used for taking an existing logo and printing out the correct size formats for xcode-app icons

logo="<your logo>"

# Resize to specific dimensions
sips -z 512 512 $logo --out icon_512x512.png

# Resize to multiple sizes at once
sips -z 16 16 $logo --out sling_icon_16x16.png
sips -z 32 32 $logo --out sling_icon_32x32.png
sips -z 64 64 $logo --out sling_icon_64x64.png
sips -z 128 128 $logo --out sling_icon_128x128.png
sips -z 256 256 $logo --out sling_icon_256x256.png
sips -z 512 512 $logo --out sling_icon_512x512.png
sips -z 1024 1024 $logo --out sling_icon_1024x1024.png
