# justNeto's dotfiles!

These are my personal dotfiles for my existing archlinux installation. In order to run them, you can clone them on your personal machine and modify the .zprofile accordingly.

In particular, the .zprofile will source the corresponding environment variables from the ~/.config/shell/.zshenv file. If using Hyprland you could also manage environment variables from there, but I like to keep them separate whenever I distro/setup hop.

## Requirements
Install GNU stow for applying the setup. For arch users:

```bash
$ pacman -Syu stow
```

Then, install the required packages from the required.txt file:
```bash
# Package list can be created using pacman -Qqe > required.txt
pacman -S --needed - < required.txt
```

Finally, proceeed to create the symbolic links using
```
stow .
```

## Acknowledgements
Thank you for the great video tutorial of stow to Dreams of Autonomy!! Go and watch their video: https://www.youtube.com/watch?v=y6XCebnB9gs&t=2s
