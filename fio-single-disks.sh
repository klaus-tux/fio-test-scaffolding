#!/bin/sh

# full tests in order for pool of 2,1 single-disk vdevs
ls /dev/disk/by-id | grep WD12 | grep -v part | head -n 2 | xargs zpool create -oashift=12 test
./fio-8x-only.pl
zpool destroy test

ls /dev/disk/by-id | grep WD12 | grep -v part | head -n 1 | xargs zpool create -oashift=12 test
./fio-8x-only.pl
zpool destroy test

