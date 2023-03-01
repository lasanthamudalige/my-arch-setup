# How i configured my first arch i3 setup

## Table of contents
* [Arch install summery](#arch-install-summery)
* [First installs](#first-installs)
* [Essential things to do after installing arch linux](#essential-things-to-do-after-installing-arch-linux)
* [Customizing i3 setup](#customizing-i3-setup)
* [ Installing necessey applications ](#installing-necessey-applications)
* [Using dotfiles](#using-dotfiles)


## Arch install summery

***I installed it using archinstall***
  - Disk partition - ext4 with encryption
  - kernel - LTS kernel
  - Desktop - i3-gaps
  - Sound - pulseaudio

## First installs

1. Install firefox and kitty terminal
    ```
    sudo pacman -S firefox kitty
    ```

2. Open the config file
    ```
    sudo vim .config/i3/config
    ```

3. Change default terminal to kitty terminal
    ```
    bindsym $mod+Return exec kitty
    ```

4. Change "kill focused window" command from $mode+Shift+q to $mod+q
    ```
    bindsym $mod+q kill
    ```

## Essential things to do after installing arch linux

### Change pacman configuration

1. Open the config file
```
sudo vim /etc/pacman.conf
```

- ***Uncomment "#Color" to change the black and white terminal to a colorful one.***
- ***Add "ILoveCandy" below it to change default install progress bar.*** 

2. ***Save the file.***

### Automatic cleaning the package cache

1. Install paccache package
    ```
    sudo pacman -S pacman-contrib
    ```

2. Activate the paccache timer
    ```
    sudo systemctl enable paccache.timer
    ```
  - ***This will clean package cache every week.***
  
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

1. Install xdg-user-dirs
    ```
    sudo pacman -S xdg-user-dirs
    ```

2. Run xdg-user-dirs to create direcotries
    ```
    xdg-user-dirs-update
    ```
### Install Microcode

For AMD processors
```
sudo pacman -S amd-ucode
```

For Intel processors
```
sudo pacman -S intel-ucode
```

### Set up firewall

1. Install UFW
    ```
    sudo pacman -S ufw
    ```

2. Enable UFW
    ```
    sudo ufw enable
    ```

3. To check status
    ```
    sudo ufw status verbose
    ```

4. To auto start with the system
    ```
    sudo systemctl enable ufw.service
    ```

## Customizing i3 setup

### Install jetbrains-mono fonts to use in terminal and visual studio code terminal
```
sudo pacman -S ttf-jetbrains-mono ttf-jetbrains-mono-nerd
```

### Set wallpaper with nitrogen

1. Install nitrogen:
    ```
    sudo pacman -S nitrogen
    ```

2. Add this command to i3 config file to restore the wallpaper on the screen after reboot
    ```
    exec --no-startup-id nitrogen --restore
    ```

## Add blur, transparency and visual effects using picom

1. Install picom:
    ```
    sudo pacman -S picom
    ```

2. Add auto exection to i3 config file:
    ```
    exec --no-startup-id picom
    ```

## Change gtk and qt5 themes

1. Install lxappearance to manage gtk themes
    ```
    sudo pacman -S install lxappearance
    ```

2. Install qt5ct to manage qt themes
    ```
    sudo pacman -S qt5ct
    ```
- ***If there is a configure error like "The QT_QPA_PLATFORMTHEME environment variable is not set (required value: qt5ct)"***
    - create a ".profile" file in home directory and add 'export QT_QPA_PLATFORMTHEME="qt5ct"' line to it using
      ```
      echo 'export QT_QPA_PLATFORMTHEME="qt5ct"' > ~/.profile
      ```

### Install themes to change everything to a dark background

1. Install Adwaita and Adwaita-dark themes for gtk applications:
    ```
    sudo pacman -S gnome-themes-extra
    ```

2. Install kvantum theme for qt applications:
    ```
    sudo pacman -S kvantum breeze # Breeze icons pack to show icons
    ```

## Installing necessey applications

- Brightnesstcl - Brightess adjustment program to adjust brightss in laptops using hot keys

  1. Install light
      ```
      sudo pacman -S light # Run this to install
      ```

  2. Add these commands to i3 config to use Brightnesstcl
      ```
      bindsym XF86MonBrightnessUp exec --no-startup-id light -A 5 # Increase brightness by 5%
      bindsym XF86MonBrightnessDown exec --no-startup-id light -U 5 # Decrease brightness by 5%
      ```
  
  3. Run this command to get proper usage permission and ***Restart*** to get for it to work
      ```
      sudo usermod -aG video <user>
      ```

- Rofi application launcher - Modern application launcher to replace demenu

  1. Install Rofi:
      ```
      sudo pacman -S rofi
      ```

  2. comment out this demenu command in i3 config file
      ```
      bindsym $mod+d exec --no-startup-id dmenu_run
      ```

  3. Add this command to i3 config file to launch rofi using $mode+d:
      ```
      bindsym $mod+d exec --no-startup-id "rofi -modi drun,run -show drun"
      ```

- Htop - terminal system monitor

  Install Htop
  ```
  sudo pacman -S htop
  ```

- screenfetch - System information program

  Install screenfetch
  ```
  sudo pacman -S screenfetch
  ```

- feh - Commandline image viewer

  Install feh
  ```
  sudo pacman -S feh
  ```

- TLP - Linux power manager of laptops

  1. Install TLP
      ```
      sudo pacman tlp tlp-rdw # (tlp-rdw - Radio Device Wizard) 
      ```

   ***Radio Device Wizard provides the capability to enable or disable builtin bluetooth, Wi-Fi and WWAN devices triggered by certain events.***

  2. Enable TLP
      ```
      systemctl enable tlp.service
      ```

  3. tlp-rdw(Radio Device Wizard) need one more service enable it using
      ```
      systemctl enable NetworkManager-dispatcher.service
      ```

  4. Mask the following services to avoid conflicts and assure proper operation of tlp-rdw(Radio Device Wizard)
      ```
      systemctl mask systemd-rfkill.service systemd-rfkill.socket
      ```
  
- ntfs-3g - ntfs partition support for arch
    
   Install ntfs-3g 
   ```
   sudo pacman -S ntfs-3g
   ```
  
- i3lock - Lock screen for i3wm
  
  Install i3lock
  ```
  sudo pacman -S i3lock
  ```
  
- xss-lock - To detect suspend to autolock the screen

  Install xss-lock
  ```
  sudo pacman -S xss-lock
  ```
  

- Redshift - Adjust screen color temperature accodring to the time

  1. Install redshift and geoclue2 to find location
      ```
      sudo pacman -S redshift geoclue2
      ```
  
  2. Add redshift to i3 config file to run on boot by using mozila location services
      ```
      exec redshift -l $(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | awk 'OFS=":" {print $3,$5}' | tr -d ',}')
      ```

- Flameshot - Screenshot tool

  1. Install flameshot
      ```
      sudo pacman -S flameshot
      ```
    
  2. Add this command to i3 config to exectute flameshote from printscreen button
      ```
      bindsym Print exec "flameshot gui"
      ```

- CopyQ - A clipboard manager
  
  1. Install CopyQ
      ```
      sudo pacman -S copyq
      ```

  2. Add this command to i3 config file to start CopyQ on boot
      ```
      exec --no-startup-id copyq
      ```

- Clementine - Audio player
  
  Install celementine
  ```
  sudo pacman -S clementine
  ```

- VLC - Vedio player
    
  Install vlc
  ```
  sudo pacman -S vlc
  ```

- Transmission - Torrent client
  
  Install transmission
  ```
  sudo pacman -S transmission-gtk # Transmission with gtk theme
  ```

- GPicview - Image viewer
  
  Install gpicview
  ```
  sudo pacman -S gpicview
  ```

- Dolphin file manager - KDE default file manager

  Install dolphin file manager
  ```
  sudo pacman dolphin dolphin-plugins # extra plugins to use in the file manager
  ```

- Okular - KDE default document viewer

  Install Okular
  ```
  sudo pacman -S okular
  ```

- Kate - KDE default text editor

  Install Kate
  ```
  sudo pacman -S kate
  ```
  
  ***More apps to install***
  ![AzmCYZ3](https://user-images.githubusercontent.com/91461938/221640326-aed2b07f-d110-487c-a549-9b13ddda80ed.jpg)
  
## Using dotfiles

***Install firefox and kitty terminal if not installed***
  
1. Clone the repo
  ```
  git clone https://github.com/lasanthamudalige/my-arch-setup.git
  ```
2. Move config files

    - Move i3 folder to "~/.config" folder
      ```
      sudo mv i3/ .config/
      ```
      
    - Move i3status.conf to "/etc" folder
      ```
      sudo mv i3status.conf /etc/
      ```
        
     - Move kitty.conf to "~/.config/kitty" folder
       ```
       sudo mv kitty.conf .config/kitty/
       ```
        
       ***If there is no kitty folder make one inside ".config" folder***
        
          - cd into ".config" folder
            ```
            cd .config/
            ```
              
          - Make a kitty folder
            ```
            mkdir kitty 
            ```
        
     - Move picom.conf to "~/.config/picom" folder
       ```
       sudo mv picom.conf .config/picom/
       ```
        
       ***If there is no picom folder make one inside ".config" folder***
          
          - cd into .config folder
            ```
            cd .config/
            ```
              
          - Make picom folder
            ```
            mkdir picom
            ```
        
3. Do essential things
  
    - Install all  essential programs using:
      ```
      sudo pacman -S pacman-contrib xdg-user-dirs ufw
      ```
    - Install yay aur helper
      ```
      sudo pacman -S --needed base-devel git
      mkdir Programs
      cd Programs
      git clone https://aur.archlinux.org/yay.git
      cd yay
      makepkg -si
      ```
    - Change pacman configuration
       - Open the config file
          ```
          sudo vim /etc/pacman.conf
          ```

      - ***Uncomment "#Color" to change the black and white terminal to a colorful one.***
      - ***Add "ILoveCandy" below it to change default install progress bar.*** 

      - ***Save the file.***  
     
    - Activate the paccache timer to clean package cache
      ```
      sudo systemctl enable paccache.timer
      ```
    
    - Run xdg-user-dirs to create direcotries
      ```
      xdg-user-dirs-update
      ```
    
    - Setup firewall
      - Enable UFW
         ```
        sudo ufw enable
        ```

      - To check status
        ```
        sudo ufw status verbose
        ```

      - To auto start with the system
        ```
        sudo systemctl enable ufw.service
        ```

4. Customizing i3 setup
    
    - Install cutomizing programs
      ```
      sudo pacman -S ttf-jetbrains-mono ttf-jetbrains-mono-nerd nitrogen picom lxappearance qt5ct gnome-themes-extra kvantum breeze
      ```
    - ***If there is a configure error like "The QT_QPA_PLATFORMTHEME environment variable is not set (required value: qt5ct)"***
      - create a ".profile" file in home directory and add "export QT_QPA_PLATFORMTHEME="qt5ct" line to it using
          ```
          echo 'export QT_QPA_PLATFORMTHEME="qt5ct"' > ~/.profile
          ```

5. Install necessary applications 
     
   - For Laptops
     ```
     sudo pacman -S light rofi htop screenfetch feh tlp ntfs-3g i3lock xss-lock scrot imagemagick redshift flameshot copyq clementine vlc transmission-gtk gpicview dolphin dolphin-plugins okular kate
     ```
        - Run this command for backlight adjusment to work
            ```
            sudo usermod -aG video <user>
            ```
        - To enable TLP
          ```
          systemctl enable tlp.service
          ```

      - tlp-rdw(Radio Device Wizard) need one more service enable it using
          ```
          systemctl enable NetworkManager-dispatcher.service
          ```

      - Mask the following services to avoid conflicts and assure proper operation of tlp-rdw(Radio Device Wizard)
          ```
          systemctl mask systemd-rfkill.service systemd-rfkill.socket
          ``` 
     
   - For Desktops
     ```
     sudo pacman -S rofi htop screenfetch feh ntfs-3g i3lock xss-lock scrot imagemagick redshift flameshot copyq clementine vlc transmission-gtk gpicview dolphin dolphin-plugins okular kate
     ```
