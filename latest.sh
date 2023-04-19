#! /bin/sh

set +x

wget $(curl -s https://ziglang.org/download/index.json | jq -r '.master."x86_64-linux".tarball') -O zig.tar.xz && \
tar -xvf zig.tar.xz && mv zig-* zig

# we do a little manual backup management here in case folks want to rollback to the previous version 
if test -d '/usr/local/share/zig'; then
    HASH=$(date | sha256sum)
    TEMPPATH="/usr/local/share/$HASH"
    BACKUPPATH='/usr/local/share/zig~'

    sudo mv '/usr/local/share/zig' $TEMPPATH

    if test -d $BACKUPPATH; then
        rm -r $BACKUPPATH
    fi

    sudo mv $TEMPPATH $BACKUPPATH
fi
sudo mv zig/ /usr/local/share

if test -f  /usr/local/bin/zig; then
    sudo rm /usr/local/bin/zig
fi

sudo ln -s /usr/local/share/zig/zig /usr/local/bin/zig && \
rm zig.tar.xz
