# How i configured my first arch i3 setup

## Table of contents
* [Arch install summery](#arch-install-summery)
* [First installs](#first-installs)
* [Essential things to do after installing arch linux](#essential-things-to-do-after-installing-arch-linux)
* [Customizing i3 setup](#customizing-i3-setup)
* [ Installing necessey applications ](#installing-necessey-applications)
* [Using dotfiles  (***Ignore above instructions***)](#using-dotfiles)
* [Other stuff](#other-stuff)


## Arch install summery

***I installed it using archinstall***
  - Disk partition - ext4 with 2 partition with encryption
  - profile - desktop with i3-gaps
  - Sound - pulseaudio
  - kernel - LTS kernel
  - Additional packages - 'firefox' 'kitty'
  - Network configuration - NetworkManager
  - Other settings are stock setting
  
  

## First installs

1. Install firefox, kitty terminal and git
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
### Install Microcode( No need for desktops as it will ask you to select this in the install)

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
    
### Enable SSD TRIM
  ```
  sudo systemctl enable fstrim.timer
  ```

## Customizing i3 setup

### Install fonts to use in terminal and visual studio code terminal
```
sudo pacman -S ttf-jetbrains-mono-nerd ttf-fira-code
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

### Add blur, transparency and visual effects using picom

1. Install picom:
    ```
    sudo pacman -S picom
    ```

2. Add auto exection to i3 config file:
    ```
    exec --no-startup-id picom
    ```

### Change gtk and qt5 themes

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
    sudo pacman -S kvantum adwaita-qt5  # Breeze icons pack to show icons
    ```

## Installing necessey applications

- Light - Brightess adjustment program to adjust brightss in laptops using hot keys

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
      sudo usermod -aG video lasantha # Replace "lasantha" with your username
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

- Neofetch - System information program

  Install neofetch
  ```
  sudo pacman -S neofetch
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

- Powertop - A tool to diagnose issues with power consumption and power management
  
  Install Powertop
    ```
    sudo pacman -S powertop
    ```

- acpi - Client for battery, power, and thermal readings
  
  Install acpi
    ```
    sudo pacman -S acpi
    ```

- libinput - Touchpad driver for laptops
  
  1. Install libinput
      ```
      sudo pacman -S libinput
      ```
   
  2. Move  "90-toucpad.conf" file to "xorg.conf.d" folder
      ```
      sudo cp 90-touchpad.conf /etc/X11/xorg.conf.d/
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

- ClipIt - A clipboard manager
  
  1. Install ClipIt
      ```
      yay -S clipit
      ```

  2. Add this command to i3 config file to start CopyQ on boot
      ```
      exec --no-startup-id clipit
      ```

- Viewnior - Image viewer

  Install Viewnior
  ```
  sudo pacman -S viewnior
  ```
  
- Mousepad - A text editor

  Install Mousepad
  ```
  sudo pacman -S mousepad
  ```
  
- Unzip - File unzip program

  Install Unzip
  ```
  sudo pacman -S unzip
  ```
  
- DeadBeef - Audio player 

  Install DeadBeef  
    ```
    yay -S deadbeef
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

- Nemo - Cinnamon file manager

  Install Nemo
  ```
  sudo pacman nemo
  ```

- Okular - KDE default document viewer

  Install Okular
  ```
  sudo pacman -S okular
  ```
  
  ***More apps to install***
  ![AzmCYZ3](https://user-images.githubusercontent.com/91461938/221640326-aed2b07f-d110-487c-a549-9b13ddda80ed.jpg)
  
## Using dotfiles

***Install firefox, kitty terminal and git if not installed***
  
1. Clone the repo
  ```
  git clone https://github.com/lasanthamudalige/my-arch-setup.git
  ```
2. Move config files

    - Move i3 folder to "~/.config" folder
      ```
      sudo mv i3/ ~/.config/
      ```
      
    - Move i3status.conf to "/etc" folder
      ```
      sudo mv i3status.conf /etc/
      ```
        
     - Move kitty.conf to "~/.config/kitty" folder
       ```
       sudo mv kitty.conf ~/.config/kitty/
       ```
        
       ***If there is no kitty folder make one inside ".config" folder***
        
          - cd into ".config" folder
            ```
            cd ~/.config/
            ```
              
          - Make a kitty folder
            ```
            mkdir kitty 
            ```
        
     - Move picom.conf to "~/.config/picom" folder
       ```
       sudo mv picom.conf ~/.config/picom/
       ```
        
       ***If there is no picom folder make one inside ".config" folder***
          
          - cd into .config folder
            ```
            cd ~/.config/
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
        
    - Enable SSD TRIM
        ```
        sudo systemctl enable fstrim.timer
        ``` 

4. Customizing i3 setup
    
    - Install cutomizing programs
      ```
      sudo pacman -S ttf-jetbrains-mono-nerd ttf-fira-code nitrogen picom lxappearance qt5ct gnome-themes-extra adwaita-qt5 kvantum breeze
      ```
    - ***If there is a configure error like "The QT_QPA_PLATFORMTHEME environment variable is not set (required value: qt5ct)"***
      - create a ".profile" file in home directory and add "export QT_QPA_PLATFORMTHEME="qt5ct" line to it using
          ```
          echo 'export QT_QPA_PLATFORMTHEME="qt5ct"' > ~/.profile
          ```

5. Install necessary applications 
     
   - For Laptops

     - Install necessery programs using
       ```
       sudo pacman -S light rofi neofetch feh tlp libinput ntfs-3g xss-lock imagemagick scrot redshift flameshot copyq clementine vlc transmission-gtk gpicview dolphin dolphin-plugins okular kate
       ```
     - Run this command for backlight adjusment to work
       ```
       sudo usermod -aG video lasantha # Replace "lasantha" with your username
       ```
       
     - To enable TLP
       ```
       sudo systemctl enable tlp.service
       ```

     - tlp-rdw(Radio Device Wizard) need one more service enable it using
       ```
        sudo systemctl enable NetworkManager-dispatcher.service
       ```

     - Mask the following services to avoid conflicts and assure proper operation of tlp-rdw(Radio Device Wizard)
       ```
       sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
       ``` 
       
     - Move  "90-toucpad.conf" file to "xorg.conf.d" folder to eneble touchpad tap functions
       ```
       sudo cp 90-touchpad.conf /etc/X11/xorg.conf.d/
       ```
     
   - For Desktops

     - Install necessery programs using
       ```
       sudo pacman -S rofi neofetch feh ntfs-3g xss-lock imagemagick scrot redshift flameshot copyq clementine vlc transmission-gtk okular bluez bluez2-utils blue2-libs
       ```
   
   - ***For both***
    
      - Install Clipit and DeadBeef
          ```
          yay -S clipit deadbeef
          ```
      
      - Enable bluetooth
          ```
          sudo systemctl enable bluetooth
          ```
       
## Other stuff

### Change shell to fish

  - Install fish shell
      ```
      sudo pacman -S fish
      ```
      
  - Change shell to fish
      ```
      chsh -s /usr/bin/fish
      ```
      
### Install google chrome, visual studio code with yay
```
yay -S google-chrome visual-studio-code-bin
```

  - ***To fix visual code code not saving login info install***
    ```
    sudo pacman -S gnome-keyring libsecret libgnome-keyring
    ```
    
    - add a new password for the keyring

### Install programming stuff
  
  - Generate ssh key for github
    ```
    # Generate a new ssh key
    ssh-keygen -t ed25519 -C "lasantha1130@gmail.com" # Add your email here by replacing "lasantha1130@gmail.com"

    # Add ssh key to ssh-agent
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519

    # Print ssh public key to clipboard
    cat ~/.ssh/id_ed25519.pub
    ```

  - Install python
    ```
    sudo pacman -S python tk python-pip # python-tk python-pip packages
    ```
  
  - Install nvm(Node version manager)
    ```
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash  
    ```
    
    ***Install nvm before doing below steps***
    
    - Install nvm in fish shell
      
      - Install fisher plugin
        ```
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
        ```
      - Install fish nvm
        ```
        fisher install FabioAntunes/fish-nvm edc/bass
        ```
 - Install nodemon for nodejs
   ```
   npm install -g nodemon # or using yarn: yarn global add nodemon
   ```

## Screenshots

![image](https://user-images.githubusercontent.com/91461938/222118296-dd23517d-9333-46c3-9366-39965e5c8617.png)
![image](https://user-images.githubusercontent.com/91461938/222118376-d9aad6c4-ff64-47b3-8b2a-8fec83cc7517.png)
![image](https://user-images.githubusercontent.com/91461938/222118886-78ddf1bb-3cd3-42bd-8bcb-8f08b9ac6c0d.png)


