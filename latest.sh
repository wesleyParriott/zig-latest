#! /bin/sh

set +x

wget $(curl -s https://ziglang.org/download/index.json | jq -r '.master."x86_64-linux".tarball') -O zig.tar.xz && \
tar -xvf zig.tar.xz && mv zig-* zig && \
sudo mv --backup=numbered zig/ /usr/local/share

if test -f  /usr/local/bin/zig; then
    sudo rm /usr/local/bin/zig
fi

sudo ln -s /usr/local/share/zig/zig /usr/local/bin/zig && \
rm zig.tar.xz
