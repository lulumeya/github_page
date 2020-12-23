echo "INSTALL Waveshare 3.5inch RPI LCD (B) V2 on Volumio"

sudo rm -rf LCD-show

sudo apt update

sudo apt -y install xserver-xorg-input-evdev

git clone https://github.com/waveshare/LCD-show

cd LCD-show

sudo cp waveshare35b-v2-overlay.dtb /boot/overlays/

sudo cp waveshare35b-v2-overlay.dtb /boot/overlays/waveshare35b-v2-overlay.dtbo

sudo cp -rf usr/share/X11/xorg.conf.d/99-fbturbo.conf /usr/share/X11/xorg.conf.d/99-fbturbo.conf

sudo cp -rf etc/X11/xorg.conf.d/99-calibration.conf-35b /etc/X11/xorg.conf.d/99-calibration.conf

sudo cp -rf etc/X11/xorg.conf.d/99-calibration.conf-35b /usr/share/X11/xorg.conf.d/99-calibration.conf

sudo cat <<'EOF' > /etc/X11/xorg.conf.d/99-calibration.conf
Section "InputClass"
		Identifier      "calibration"
		MatchProduct    "ADS7846 Touchscreen"
		Option  "Calibration"   "3932 300 294 3801"
		Option  "SwapAxes"      "1"
		Driver  "evdev"
EndSection
EOF

sudo cat <<'EOF' > /usr/share/X11/xorg.conf.d/99-calibration.conf
Section "InputClass"
		Identifier      "calibration"
		MatchProduct    "ADS7846 Touchscreen"
		Option  "Calibration"   "3932 300 294 3801"
		Option  "SwapAxes"      "1"
		Driver  "evdev"
EndSection
EOF

grep -q "dtparam=spi=on" /boot/userconfig.txt || \
  echo "dtparam=spi=on" >> /boot/userconfig.txt
echo "dtoverlay=waveshare35b-v2-overlay" >> /boot/userconfig.txt


echo "SUCCESS"

echo "REBOOTING"

sudo reboot