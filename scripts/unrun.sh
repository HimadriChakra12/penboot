echo "Stopped Printing Service"
sudo systemctl stop cups.service
sudo systemctl disable cups.service
echo "No Mobile Broadband"
sudo systemctl stop ModemManager.service
sudo systemctl disable ModemManager.service
echo "No Baloo"
balooctl disable
balooctl purge
echo "Optionally unchecked Services"
systemctl --user stop plasma-kwallet.service
systemctl --user stop kwalletd5.service
systemctl --user stop kdeconnect.service
systemctl --user stop plasma-discover.service
