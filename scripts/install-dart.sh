set -e

# arm or intel?
arch=$([ "$TARGETARCH" == "amd64" ] && echo "x64" || echo $TARGETARCH)

# Creating temp file
tdir=$(mktemp -d -t dart.XXX)
zip="dartsdk-linux-$arch-release.zip"
sha="dartsdk-linux-$arch-release.zip.sha256sum"
tzip="$tdir/$zip"
tsha="$tdir/$sha"

# Downloading latest stable dist
wget -qO "$tzip" "https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/$zip"
wget -qO "$tsha" "https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/$sha"

chmod -R +rwx $tdir
cd $tdir
cat $tsha | sha256sum -c > /dev/null

# Check if checksum matched
if ! [ $? -eq 0 ]; then
    >&2 echo "ERROR: SHA-256 checksum not matching"
    rm -r "$tdir"
    exit 1
fi

# Unzipping to lib location
unzip -d /usr/lib $tzip > /dev/null

# Enabling write and execution for the dark-sdk folder
chown -R cukebot /usr/lib/dart-sdk
chmod -R +rx /usr/lib/dart-sdk

# Removing tmp files
rm -r "$tdir"