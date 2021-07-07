set -e

# Creating temp file
tdir=$(mktemp -d -t dart.XXX)
tzip="$tdir/dartsdk-linux-arm64-release.zip"
tsha="$tdir/dartsdk-linux-arm64-release.zip.sha256sum"

# Downloading latest stable dist
wget -qO "$tzip" "https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-$TARGETARCH-release.zip"
wget -qO "$tsha" "https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-$TARGETARCH-release.zip.sha256sum"

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

# Adding dart to path
export PATH="$PATH:/usr/lib/dart-sdk/bin"

# Removing tmp files
rm -r "$tdir"