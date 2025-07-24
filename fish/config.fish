if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

# Function from
# https://fernandocejas.com/blog/engineering/2022-03-30-arch-linux-system-maintance/
# https://www.youtube.com/watch?v=o03_cfOnl84
function system_maintance

    echo "Updating system"
    sudo paru -Syu

    echo "Clearing pacman cache"
    set pacman_cache_space_used "$(du -sh /var/cache/pacman/pkg/)"
    paccache -r
    echo "Space saved: $pacman_cache_space_used"

    echo "Removing orphan packages"
    paru -Qdtq | paru -Rns -

    echo "Clearing ~/.cache"
    set home_cache_used "$(du -sh ~/.cache)"
    rm -rf ~/.cache/
    echo "Space saved: $home_cache_used"

    echo "Clearing system logs"
    sudo journalctl --vacuum-time=7d

    return 0
end

### Configuring my monitor

# Monitors setting config file
set HYPRLAND_MONITOR_CONF ~/.config/hypr/monitors.conf

function monitor_light
    echo "monitor=HDMI-A-1, 2560x1440@100,0x0,1" >$HYPRLAND_MONITOR_CONF
    hyprctl reload
end

function monitor_heavy
    echo "monitor=eDP-1,1920x1080@60,0x0,1" >$HYPRLAND_MONITOR_CONF
    echo "monitor=HDMI-A-1, preferred, auto, 1, mirror, eDP-1" >>$HYPRLAND_MONITOR_CONF
    hyprctl reload
end

function monitor_auto
    echo "" >$HYPRLAND_MONITOR_CONF
    hyprctl reload
end

### Configuring my wallpapers
# Hyprpaper setting config file
set HYPRLAND_HYPRPAPER_CONF ~/.config/hypr/hyprpaper.conf

function wall_set

    if test $argv = null
        echo "" >$HYPRLAND_HYPRPAPER_CONF
        pkill hyprpaper
        echo "Cleared $HYPRLAND_HYPRPAPER_CONF"
        return 0
    end

    set wallpaper ~/.config/wall/$argv.png

    if test -e "$wallpaper"

        echo "preload = $wallpaper" >$HYPRLAND_HYPRPAPER_CONF
        echo "wallpaper = , $wallpaper" >>$HYPRLAND_HYPRPAPER_CONF

        pkill hyprpaper
        hyprpaper &>/dev/null &
        disown $(pgrep hyprpaper)

        echo "sucessfully loaded $wallpaper"
        return 0
    end

    echo "$wallpaper doesn't exists."
    return 1
end
