#!/bin/sh
xset r rate 270 30
xrandr --dpi 200
xrandr --output HDMI-0 --rotate left

if [ -f /home/ndjuric/.Xresources ]; then
    xrdb -merge /home/ndjuric/.Xresources
fi

# turn off the cpu default bell
if [ -f /usr/bin/xset ]; then
    xset -b
fi

# enable window compositing
if [ -f /usr/bin/compton ]; then
    allow_rgb10_configs=false compton --fading --daemon --config "$HOME/.config/compton.conf"
fi

# start Gnome keyring
if [ -f /usr/bin/gnome-keyring-daemon ]; then
  dbus-update-activation-environment --systemd DISPLAY
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
  export SSH_AUTH_SOCK
fi

# start i3 and keep it running
if [ -f /usr/bin/i3 ]; then
    exec i3
fi
