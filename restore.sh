#sudo pacman -S --needed - < pkglist-repo.txt
for x in $(< pkglist-aur.txt); do echo y | yay --answerdiff None --answerclean All --mflags --needed --mflags "--noconfirm"  -Syu $x; done
for x in $(< pkglist-repo.txt); do echo y | yay --answerdiff None --answerclean All --mflags --needed --mflags "--noconfirm"  -Syu $x; done
xargs flatpak install -y < pkglist-flatpak.txt
