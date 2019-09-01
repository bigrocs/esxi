#!/bin/sh
#auto create ESXi snapshots
for i in `vim-cmd vmsvc/getallvms |  grep -v nosnap | awk '{print $1}' | grep -e "[0-9]"`
do
	vname=$(vim-cmd vmsvc/get.summary $i | grep name | awk '{ print $3 }' | cut -d \" -f 2)
    vannotation=$(vim-cmd vmsvc/get.summary $i | grep annotation | awk '{ print $3 }' | cut -d \" -f 2)
    if [ $vannotation == 'auto_snapshot' || $vannotation == 'auto' ];then
        vim-cmd vmsvc/snapshot.create $i $(date "+%F")
        sleep 60s
        if [ $? -eq 0 ];then
            echo "$(date "+%F %T") : $vname snapshot create success.." >> ./schedule_snap.log
        else
            echo "$(date "+%F %T") : $vname snapshot create FAILED.." >> ./schedule_snap.log
        fi
    fi
done