##/etc/rc.local.d/local.sh
#!/bin/sh
/bin/echo "30   1   *   *   *   sh /vmfs/volumes/datastore1/crontabs/snapshot_creat.sh" >>/var/spool/cron/crontabs/root 
/bin/echo "30   2   *   *   *   sh /vmfs/volumes/datastore1/crontabs/snapshot_del.sh" >>/var/spool/cron/crontabs/root
kill $(cat /var/run/crond.pid)
crond
exit 0