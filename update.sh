#!/bin/zsh
# When run, fetch album, run wal against it and call wal-cava
wget $(./get-album-art-url) -O cover -o wget-out.txt &&
wal -c &&
wal -s -t -e -q --backend wal -i ./cover &&
./wal-cava.sh &&
pkill cava -USR2 ||
return 1
