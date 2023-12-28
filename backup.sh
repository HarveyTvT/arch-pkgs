pacman -Qqen > pkglist-repo.txt
pacman -Qqem | grep -v -E "yay|clash-for-windows" > pkglist-aur.txt
flatpak list --columns=application --app > pkglist-flatpak.txt
