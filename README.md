# How i configured my first arch i3 setup

## Table of contents
* [First installs](#first-installs)
* [Essential things to do after installing arch linux](#essential-things-to-do-after-installing-arch-linux)
* [Customizing i3 setup](#customizing-i3-setup)

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

#### To enable UFW
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

## Customizing i3 setup

### Install jetbrains-mono fonts to use in terminal and visual studio code terminal
```
sudo pacman -S ttf-jetbrains-mono ttf-jetbrains-mono-nerd
```

### Set wallpaper woth nitrogen

#### Install nitrogen
```
sudo pacman -S nitrogen
```

#### Add auto execute to i3 config file
```
exec always nitrogen --restore
```

## Add blur, transparency and visual effects using picom

### Install picom
```
sudo pacman -S picom
```

### Add auto exection to i3 config file
```
exec picom
```

## Change gtk and qt5 themes

### Install lxappearance to manage gtk themes
```
sudo pacman -S install lxappearance
```

### Install qt5ct to manage qt themes
```
sudo pacman -S qt5t
```
- If there is a configure error like "The QT_QPA_PLATFORMTHEME environment variable is not set (required value: qt5ct)"
  - create a .profile in home directory and add "export QT_QPA_PLATFORMTHEME="qt5ct"

### Install themes to change everything to a dark background

#### Install Adwaita and Adwaita-dark themes for gtk applications
```
sudo pacman -S gnome-themes-extra
```

#### Install kvantum theme for qt applications
```
sudo pacman -S kvantum
```

## Installing applications 

### Installing necessey applications

#### Brightnessctl
This is a program to adjust brightness in my laptop(Thinkpad t480s) using hot keys

##### Installing Brightnesstcl
```
sudo pacman -S brightnesstcl
```

##### Add these commands to i3 config to use Brightnesstcl
```
# Brightness up
bindsym XF86MonBrightnessUp exec --no-startup-id brightnessctl set +5%
# Brightness down
bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl set 5%-

```

#### Dolphin file manager
This is file manager in kde to hande files in a GUI

##### Installing dolphin file manager
```
sudo pacman dolphin dolphin-plugins # extra plugins to use in the file manager
```

