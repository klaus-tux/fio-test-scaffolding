#!/bin/sh

# full tests in order for pool of 1 2n mirror vdevs
ls /dev/disk/by-id | grep WD12 | grep -v part | head -n 2 | tail -n 2 | xargs zpool create -oashift=12 test mirror
./fio-full-test.pl
zpool destroy test

# full test for single disk
ls /dev/disk/by-id | grep WD12 | grep -v part | head -n 1 | xargs zpool create -oashift=12 test
./fio-full-test.pl
zpool destroy test

