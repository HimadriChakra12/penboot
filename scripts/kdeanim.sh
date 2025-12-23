#!/bin/bash

# Detect kwriteconfig
if command -v kwriteconfig6 >/dev/null 2>&1; then
    KWRITE=kwriteconfig6
elif command -v kwriteconfig5 >/dev/null 2>&1; then
    KWRITE=kwriteconfig5
elif command -v kwriteconfig >/dev/null 2>&1; then
    KWRITE=kwriteconfig
else
    echo "kwriteconfig not found. Install KDE Plasma tools."
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

# Disable animations globally
$KWRITE --file kdeglobals --group KDE --key AnimationDurationFactor 0

# Disable KWin effects
$KWRITE --file kwinrc --group Plugins --key slideEnabled false
$KWRITE --file kwinrc --group Plugins --key fadeEnabled false
$KWRITE --file kwinrc --group Plugins --key glideEnabled false
$KWRITE --file kwinrc --group Plugins --key magiclampEnabled false
$KWRITE --file kwinrc --group Plugins --key squashEnabled false

# Disable window animations
$KWRITE --file kwinrc --group Windows --key AnimationDuration 0

# Reload KWin if possible
if [ -n "$QDBUS" ]; then
    $QDBUS org.kde.KWin /KWin reconfigure
else
    echo "qdbus not found — log out and back in to apply changes."
fi

echo "KDE animations disabled successfully."

