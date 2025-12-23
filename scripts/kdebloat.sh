#!/bin/bash

set -e

echo "Starting KDE Plasma debloat..."

# Detect kwriteconfig
if command -v kwriteconfig6 >/dev/null 2>&1; then
    KWRITE=kwriteconfig6
elif command -v kwriteconfig5 >/dev/null 2>&1; then
    KWRITE=kwriteconfig5
elif command -v kwriteconfig >/dev/null 2>&1; then
    KWRITE=kwriteconfig
else
    echo "kwriteconfig not found. Install kde-cli-tools."
    exit 1
fi

# Detect qdbus
if command -v qdbus6 >/dev/null 2>&1; then
    QDBUS=qdbus6
elif command -v qdbus >/dev/null 2>&1; then
    QDBUS=qdbus
else
    QDBUS=""
fi

# -----------------------------
# Disable Baloo (file indexing)
# -----------------------------
echo "Disabling Baloo..."
$KWRITE --file baloofilerc --group Basic Settings --key Indexing-Enabled false
balooctl disable 2>/dev/null || true
balooctl purge 2>/dev/null || true

# -----------------------------
# Disable Akonadi (mail/PIM backend)
# -----------------------------
echo "Disabling Akonadi..."
$KWRITE --file akonadiserverrc --group General --key StartServer false
systemctl --user mask akonadi.service akonadi.socket 2>/dev/null || true

# -----------------------------
# Disable crash handler popups
# -----------------------------
echo "Disabling crash handler..."
$KWRITE --file drkonqirc --group General --key Enabled false

# -----------------------------
# Disable KWallet auto-start
# -----------------------------
echo "Disabling KWallet auto-start..."
$KWRITE --file kwalletrc --group Wallet --key Enabled false

# -----------------------------
# Disable unused KDED modules
# -----------------------------
echo "Disabling unused background services..."
$KWRITE --file kded5rc --group Module-device_automounter --key autoload false
$KWRITE --file kded5rc --group Module-device_notifier --key autoload false
$KWRITE --file kded5rc --group Module-remotedirnotify --key autoload false

# -----------------------------
# Reload KWin
# -----------------------------
if [ -n "$QDBUS" ]; then
    $QDBUS org.kde.KWin /KWin reconfigure
else
    echo "Log out and back in to apply changes."
fi

echo "KDE Plasma debloat complete."

