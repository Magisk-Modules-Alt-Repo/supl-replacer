#!/system/bin/sh

MODDIR=${0%/*}

cp /system/vendor/etc/gps.conf "${MODDIR}/system/vendor/etc/gps.conf"
sed -i 's/^SUPL_HOST=.*/SUPL_HOST=supl.vodafone.com/' "${MODDIR}/system/vendor/etc/gps.conf"
sed -i 's/^NTP_SERVER=.*/NTP_SERVER=pool.ntp.org/' "${MODDIR}/system/vendor/etc/gps.conf"
