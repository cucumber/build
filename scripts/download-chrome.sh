set -e

TARGETARCH=$1
if [ -z $TARGETARCH ]
then
    echo "Need target arch"
    exit 1
fi
CHROMIUM_ARCH=$([ $TARGETARCH = 'arm64' ] && echo 'Linux_ARM_Cross-Compile' || echo 'Linux_x64')

CHROMIUM_DOWNLOAD_HOST=https://storage.googleapis.com
   
# Get this from `curl https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media`
CHROMIUM_REVISION=$(curl https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/$CHROMIUM_ARCH%2FLAST_CHANGE?alt=media)
# TODO: support ARM architecture
CHROMIUM_DOWNLOAD_URL=$CHROMIUM_DOWNLOAD_HOST/chromium-browser-snapshots/$CHROMIUM_ARCH/$CHROMIUM_REVISION/chrome-linux.zip
echo $CHROMIUM_DOWNLOAD_URL
wget --no-check-certificate -q -O chrome.zip $CHROMIUM_DOWNLOAD_URL