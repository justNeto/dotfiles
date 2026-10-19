mako &
swww-daemon &
rwp &
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE DISPLAY DBUS_SESSION_BUS_ADDRESS
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE DISPLAY DBUS_SESSION_BUS_ADDRESS
systemctl --user start xdg-desktop-portal-wlr xdg-desktop-portal
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
clipse -listen &
