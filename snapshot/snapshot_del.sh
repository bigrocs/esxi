#!/bin/sh
DAY=10 #保留数量
for i in `vim-cmd vmsvc/getallvms | awk '{print $1}' | grep -e "[0-9]"`
do
    SNAPSHOT_COUNT=`vim-cmd vmsvc/snapshot.get $i | egrep -- '--\|-CHILD|^\|-ROOT' | wc -l`
    if [ $SNAPSHOT_COUNT -gt $DAY ]; then
		DELETE_COUNT=$(($SNAPSHOT_COUNT-$DAY))
		OLD_SNAPSHOT_ID=`vim-cmd vmsvc/snapshot.get $i | grep Id | head -$DELETE_COUNT | awk -F: '{print $2}'`
		for n in $OLD_SNAPSHOT_ID
		do
			vim-cmd vmsvc/snapshot.remove $i $n > /dev/null
			sleep 30s
		done
    fi
done