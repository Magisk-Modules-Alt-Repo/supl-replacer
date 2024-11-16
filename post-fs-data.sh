#!/system/bin/sh

MODDIR=${0%/*}

# Switch to the non-tracking graphene os supl provider
SUPL_HOST=supl.grapheneos.orgf
# Ensure the supl port as some devices wont set it by default
SUPL_PORT=7275
# Use the global pool.ntp.org to get the closest ntp server available
# See https://www.ntppool.org/zone/@
NTP_SERVER=pool.ntp.org

# For new "Treble enabled" devices
if [ -f /system/vendor/etc/gps.conf ]; then
  cp /system/vendor/etc/gps.conf "${MODDIR}/system/vendor/etc/gps.conf"

  if grep -q "^SUPL_HOST=.*" "${MODDIR}/system/vendor/etc/gps.conf"; then
    # replace if it's already there
    sed -i "s/^SUPL_HOST=.*/SUPL_HOST=${SUPL_HOST}/" "${MODDIR}/system/vendor/etc/gps.conf"
    sed -i "s/^SUPL_PORT=.*/SUPL_PORT=${SUPL_PORT}/" "${MODDIR}/system/vendor/etc/gps.conf"
  else
    # append if it's not there yet
    echo "SUPL_HOST=${SUPL_HOST}" >> "${MODDIR}/system/vendor/etc/gps.conf"
    echo "SUPL_PORT=${SUPL_PORT}" >> "${MODDIR}/system/vendor/etc/gps.conf"
  fi

  sed -i "s/^NTP_SERVER=.*/NTP_SERVER=${NTP_SERVER}/" "${MODDIR}/system/vendor/etc/gps.conf"
  if [ -f "${MODDIR}/system/vendor/etc/.gitkeep" ]; then
    rm "${MODDIR}/system/vendor/etc/.gitkeep"
  fi
else
  if [ -f "${MODDIR}/system/vendor/etc/.gitkeep" ]; then
    rm "${MODDIR}/system/vendor/etc/.gitkeep"
  fi
  rmdir "${MODDIR}/system/vendor/etc" && rmdir "${MODDIR}/system/vendor"
fi

# For older devices
if [ -f /system/etc/gps.conf ]; then
  cp /system/etc/gps.conf "${MODDIR}/system/etc/gps.conf"

  if grep -q "^SUPL_HOST=.*" "${MODDIR}/system/etc/gps.conf"; then
    # replace if it's already there
    sed -i "s/^SUPL_HOST=.*/SUPL_HOST=${SUPL_HOST}/" "${MODDIR}/system/etc/gps.conf"
    sed -i "s/^SUPL_PORT=.*/SUPL_PORT=${SUPL_PORT}/" "${MODDIR}/system/etc/gps.conf"
  else
    # append if it's not there yet
    echo "SUPL_HOST=${SUPL_HOST}" >> "${MODDIR}/system/etc/gps.conf"
    echo "SUPL_HOST=${SUPL_PORT}" >> "${MODDIR}/system/etc/gps.conf"
  fi

  sed -i "s/^NTP_SERVER=.*/NTP_SERVER=${NTP_SERVER}/" "${MODDIR}/system/etc/gps.conf"
fi

# For devices where only gps_debug is present
if [ -f /system/etc/gps_debug.conf ] && [ ! -f /system/etc/gps.confg ]; then
  cp /system/etc/gps_debug.conf "${MODDIR}/system/etc/gps_debug.conf"

  if grep -q "^SUPL_HOST=.*" "${MODDIR}/system/etc/gps_debug.conf"; then
    # replace if it's already there
    sed -i "s/^SUPL_HOST=.*/SUPL_HOST=${SUPL_HOST}/" "${MODDIR}/system/etc/gps_debug.conf"
    sed -i "s/^SUPL_PORT=.*/SUPL_HOST=${SUPL_PORT}/" "${MODDIR}/system/etc/gps_debug.conf"
  else
    # append if it's not there yet
    echo "SUPL_HOST=${SUPL_HOST}" >> "${MODDIR}/system/etc/gps_debug.conf"
    echo "SUPL_HOST=${SUPL_PORT}" >> "${MODDIR}/system/etc/gps_debug.conf"
  fi

  sed -i "s/^NTP_SERVER=.*/NTP_SERVER=${NTP_SERVER}/" "${MODDIR}/system/etc/gps_debug.conf"

# Moved cleanup to avoid code duplication
if [ -f /system/etc/gps.conf ] || [ -f /system/etc/gps_debug.conf ]; then
  if [ -f "${MODDIR}/system/etc/.gitkeep" ]; then
    rm "${MODDIR}/system/etc/.gitkeep"
  fi
else
  if [ -f "${MODDIR}/system/etc/.gitkeep" ]; then
    rm "${MODDIR}/system/etc/.gitkeep"
  fi
  rmdir "${MODDIR}/system/etc"
fi
