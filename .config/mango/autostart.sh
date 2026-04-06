waybar -c ~/.config/mango/config.jsonc -s ~/.config/mango/style.css >/dev/null 2>&1 &
mako &
swww-daemon &
rwp &
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
clipse -listen &
