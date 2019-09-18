##/etc/rc.local.d/local.sh
#!/bin/sh
/bin/echo "30   3    *   *   *   sh /vmfs/volumes/datastore11/crontabs/snapshot_creat.sh" >>/var/spool/cron/crontabs/root
/bin/echo "30   4    *   *   *   sh /vmfs/volumes/datastore11/crontabs/snapshot_del.sh" >>/var/spool/cron/crontabs/root
kill $(cat /var/run/crond.pid)
crond
rm -f /etc/localtime && cp /vmfs/volumes/datastore11/localtime/Shanghai /etc/localtime
exit 0