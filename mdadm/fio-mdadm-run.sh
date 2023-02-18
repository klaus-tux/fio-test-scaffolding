#!/bin/sh

mkdir -p /test

echo "single disk, ext4"
	umount /test
	mdadm --stop /dev/md1
	DISK=`ls /dev/disk/by-id | grep WD120 | grep part1 | head -n 1 | sed 's#^#/dev/disk/by-id/#'`
	wipefs -a $DISK
	mkfs.ext4 -E lazy_table_init=0, lazy_journal_init=0 $DISK
	mount $DISK /test
	echo "Device /test is single-disk ext4 $DISK"
	echo 
	./fio-mdadm-full-test.pl

echo "mdraid10, internal bitmap, ext4"

	# mdraid"10" 2 disks is just mdraid1 2 disks
	./mdraidbuild.sh 1 2 internal
	mkfs.ext4 -E lazy_table_init=0,lazy_journal_init=0 /dev/md1
	mount /dev/md1 /test
	./fio-mdadm-full-test.pl

echo "mdraid10, no bitmap, ext4"

	# mdraid"10" 2 disks is just mdraid1 2 disks
	./mdraidbuild.sh 1 2 none
	mkfs.ext4 -E lazy_table_init=0,lazy_journal_init=0 /dev/md1
	mount /dev/md1 /test
	./fio-mdadm-full-test.pl

echo "single disk, xfs"
	umount /test
	mdadm --stop /dev/md1
	DISK=`ls /dev/disk/by-id | grep WD120 | grep part1 | head -n 1 | sed 's#^#/dev/disk/by-id/#'`
	wipefs -a $DISK
	mkfs.xfs $DISK
	mount $DISK /test
	echo "Device /test is single-disk xfs $DISK"
	echo 
	./fio-mdadm-full-test.pl


echo "mdraid10, no bitmap, xfs"
	# mdraid"10" 2 disks is just mdraid1 2 disks
	./mdraidbuild.sh 1 2 none
	wipefs -a /dev/md1
	mkfs.xfs /dev/md1
	mount /dev/md1 /test
	./fio-mdadm-full-test.pl

rm -rf /test
