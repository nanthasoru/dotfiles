if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

# Function from
# https://fernandocejas.com/blog/engineering/2022-03-30-arch-linux-system-maintance/
# https://www.youtube.com/watch?v=o03_cfOnl84
function system-maintance
    echo "Updating system"
    sudo pacman -Syu

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
end
