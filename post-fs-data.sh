#!/system/bin/sh

MODDIR=${0%/*}

SUPL_HOST=supl.grapheneos.org
SUPL_PORT=7275
NTP_SERVER=pool.ntp.org

update_conf() {
  FILE_PATH="$1"

  if grep -q "^SUPL_HOST=.*" "$FILE_PATH"; then
      # replace if it's already there
    sed -i "s/^SUPL_HOST=.*/SUPL_HOST=${SUPL_HOST}/" "$FILE_PATH"
  else
    # append if it's not there yet
    echo "SUPL_HOST=${SUPL_HOST}" >> "$FILE_PATH"
  fi

  if grep -q "^SUPL_PORT=.*" "$FILE_PATH"; then
    # replace if it's already there
    sed -i "s/^SUPL_PORT=.*/SUPL_PORT=${SUPL_PORT}/" "$FILE_PATH"
  else
    # append if it's not there yet
    echo "SUPL_PORT=${SUPL_PORT}" >> "$FILE_PATH"
  fi

  if grep -q "^NTP_SERVER=.*" "$FILE_PATH"; then
    # replace if it's already there
    sed -i "s/^NTP_SERVER=.*/NTP_SERVER=${NTP_SERVER}/" "$FILE_PATH"
  else
    # append if it's not there yet
    echo "NTP_SERVER=${NTP_SERVER}" >> "$FILE_PATH"
  fi
}

clean() {
  # Remove placeholder files if present
  if [ -f "${MODDIR}/system/vendor/etc/.gitkeep" ]; then
    rm "${MODDIR}/system/vendor/etc/.gitkeep"
  fi
  if [ -f "${MODDIR}/system/etc/.gitkeep" ]; then
    rm "${MODDIR}/system/etc/.gitkeep"
  fi

  # Remove empty directories (ignore errors)
  rmdir "${MODDIR}/system/vendor/etc" 2>/dev/null || true
  rmdir "${MODDIR}/system/vendor" 2>/dev/null || true
  rmdir "${MODDIR}/system/etc" 2>/dev/null || true
}

# For new "Treble enabled" devices
if [ -f /system/vendor/etc/gps.conf ]; then
  cp /system/vendor/etc/gps.conf "${MODDIR}/system/vendor/etc/gps.conf"
  update_conf "${MODDIR}/system/vendor/etc/gps.conf"
fi

# For other devices
for SRC in /system/etc/gps_debug.conf /system/etc/gps.conf; do
  if [ -f "$SRC" ]; then
    BASENAME="$(basename "$SRC")"
    cp "$SRC" "${MODDIR}/system/etc/${BASENAME}"
    update_conf "${MODDIR}/system/etc/${BASENAME}"
  fi
done

clean
