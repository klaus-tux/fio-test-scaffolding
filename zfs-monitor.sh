watch -c -n 1 'zpool iostat test -y -v 1 1 ; echo ; ls -l /dev/disk/by-id | grep WD120 | grep -v part | awk "{print \$11}" | sed "s#../../#/dev/#" | S_COLORS=always xargs iostat --human -xy 1 1'
