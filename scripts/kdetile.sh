#!/bin/bash
set -e

echo "Applying KDE tiling-WM preset..."

# -------------------------
# Detect tools
# -------------------------
if command -v kwriteconfig6 >/dev/null 2>&1; then
    KWRITE=kwriteconfig6
    QDBUS=qdbus6
elif command -v kwriteconfig5 >/dev/null 2>&1; then
    KWRITE=kwriteconfig5
    QDBUS=qdbus
else
    echo "Install kde-cli-tools first."
    exit 1
fi

CONF="$HOME/.config/kglobalshortcutsrc"

# -------------------------
# Workspaces
# -------------------------
for i in 1 2 3 4; do
    $KWRITE --file "$CONF" --group kwin \
      --key "Switch to Desktop $i" "Alt+$i,none,Switch to Desktop $i"
    $KWRITE --file "$CONF" --group kwin \
      --key "Window to Desktop $i" "Alt+Shift+$i,none,Move window to Desktop $i"
done

# -------------------------
# Focus (hjkl)
# -------------------------
$KWRITE --file "$CONF" --group kwin --key "Switch Window Left"  "Alt+H,none,Focus left"
$KWRITE --file "$CONF" --group kwin --key "Switch Window Down"  "Alt+J,none,Focus down"
$KWRITE --file "$CONF" --group kwin --key "Switch Window Up"    "Alt+K,none,Focus up"
$KWRITE --file "$CONF" --group kwin --key "Switch Window Right" "Alt+L,none,Focus right"

# -------------------------
# Move windows (hjkl)
# -------------------------
$KWRITE --file "$CONF" --group kwin --key "Move Window Left"  "Alt+Shift+H,none,Move left"
$KWRITE --file "$CONF" --group kwin --key "Move Window Down"  "Alt+Shift+J,none,Move down"
$KWRITE --file "$CONF" --group kwin --key "Move Window Up"    "Alt+Shift+K,none,Move up"
$KWRITE --file "$CONF" --group kwin --key "Move Window Right" "Alt+Shift+L,none,Move right"

# -------------------------
# Fullscreen
# -------------------------
$KWRITE --file "$CONF" --group kwin --key "Toggle Fullscreen" \
"Alt+F,none,Toggle fullscreen"

# -------------------------
# Screenshot (Win+Shift+S)
# -------------------------
$KWRITE --file "$CONF" --group spectacle --key RectangularRegionScreenShot \
"Meta+Shift+S,none,Area screenshot to clipboard"

# -------------------------
# Mouse bindings (Alt + mouse)
# -------------------------
$KWRITE --file kwinrc --group MouseBindings --key CommandAll1 "Move"
$KWRITE --file kwinrc --group MouseBindings --key CommandAll2 "Toggle Raise and Lower"
$KWRITE --file kwinrc --group MouseBindings --key CommandAll3 "Resize"

# -------------------------
# Disable animations
# -------------------------
$KWRITE --file kdeglobals --group KDE --key AnimationDurationFactor 0
$KWRITE --file kwinrc --group Windows --key AnimationDuration 0

# -------------------------
# Disable heavy effects
# -------------------------
for effect in fade slide glide magiclamp squash; do
    $KWRITE --file kwinrc --group Plugins --key "${effect}Enabled" false
done

# -------------------------
# Reload KWin + shortcuts
# -------------------------
$QDBUS org.kde.KWin /KWin reconfigure || true

if command -v kglobalaccel6 >/dev/null 2>&1; then
    kglobalaccel6 --replace >/dev/null 2>&1 &
elif command -v kglobalaccel5 >/dev/null 2>&1; then
    kglobalaccel5 --replace >/dev/null 2>&1 &
fi

echo "Done. Log out/in if any shortcut doesn’t work immediately."

