# How i configured my first arch i3 setup

## Table of contents
* [First installs](#first-installs)
* [Essential things to do after installing arch linux](#essential-things-to-do-after-installing-arch-linux)

## First installs

#### Install firefox and kitty terminal
```
sudo pacman -S firefox kitty
```

#### Open the config file
```
sudo vim .config/i3/config
```

#### Change default terminal to kitty terminal
```
bindsym $mod+Return exec kitty
```

#### Change "kill focused window" command from $mode+Shift+q to $mod+q
```
bindsym $mod+q kill
```

## Essential things to do after installing arch linux

### Change pacman configuration

#### Open the config file
```
sudo vim /etc/pacman.conf
```

* Uncomment "#Color" to change black and white.
* Add "ILoveCandy" below it to change default install progress bar 

### Automatic cleaning the package cache

#### Install paccache package
```
sudo pacman -S pacman-contrib
```

#### Activate the paccache timer
```
sudo systemctl enable paccache.timer
```
  - This will clean package cache every week
  
 ### Install Aur helper (yay)
 ```
sudo pacman -S --needed base-devel git
mkdir Programs
cd Programs
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
 ```
### Create user directory folders

#### Install xdg-user-dirs
```
sudo pacman -S xdg-user-dirs
```

#### Run xdg-user-dirs
```
xdg-user-dirs-update
```
### Install Microcode

#### For AMD
```
sudo pacman -S amd-ucode # for AMD processors
```

#### For Intel
```
sudo pacman -S intel-ucode # for Intel processors
```

### Set up firewall

#### Install UFW
```
sudo pacman -S ufw
```

#### TO enable UFW
```
sudo ufw enable
```

#### To check status
```
sudo ufw status verbose
```

#### To auto start with the system
```
sudo systemctl enable ufw.service
```
