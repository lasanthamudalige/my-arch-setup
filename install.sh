# Install nvm before asking for root permission
echo "Installing nvm"
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash  
echo

# Move "i3" config file to "~/.config"
echo "Copying i3 folder..."
echo
sudo cp -r i3/ ~.config/
echo

# Move "i3status.conf" to "/etc" folder
echo "Moving i3status.conf..."
echo
sudo mv i3status.conf /etc/
echo

# Move kitty.conf to "~/.config/kitty" folder or create a folder and move that file
echo "Moving kitty.conf..."
echo
DIR=~/.config/kitty

if [ ! -d "$DIR" ];
then
	sudo mkdir ~/.config/kitty
 	sudo mv kitty.conf ~/.config/kitty/
else
 	sudo mv kitty.conf ~/.config/kitty/
fi
echo

# Move picom.conf to "~/.config/picom" folder or create a folder and move that file
echo "Moving picom.conf..."
echo
DIR=~/.config/picom

if [ ! -d "$DIR" ];
then
	sudo mkdir ~/.config/picom
 	sudo mv picom.conf ~/.config/kitty/
else
 	sudo mv kitty.conf ~/.config/kitty/
fi
echo

# Install essential apps
echo "Installing essential apps"
echo
sudo pacman -S pacman-contrib xdg-user-dirs ufw 
echo

# Install yay aur helper
echo "Installing aur helper"
echo
sudo pacman -S --needed base-devel git 
mkdir Programs
cd Programs
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
echo

# Activate the paccache timer to clean package cache 
echo
sudo systemctl enable paccache.timer
echo

# Run xdg-user-dirs to create user direcotries
echo "Creating user directories"
echo
xdg-user-dirs-update
echo

# Setup firewall
# Enable UFW
echo "Setting up firewall"
echo
sudo ufw enable
# Check status
sudo ufw status verbose
# auto start with the system
sudo systemctl enable ufw.service
echo

# Install customizing programs
echo
sudo pacman -S ttf-jetbrains-mono-nerd ttf-fira-code nitrogen picom lxappearance qt5ct gnome-themes-extra kvantum papirus-icon-theme
# This to fix qt5ct not working
echo 'export QT_QPA_PLATFORMTHEME="qt5ct"' > ~/.profile
echo

echo "Laptop or a desktop (Enter 1 or 2):"
read TYPE
if [ $TYPE == "1" ]
then
    # Install other programs
    echo "Installing other programs"
    echo
    sudo pacman -S light rofi neofetch ntfs-3g xss-lock bluez bluez-utils bluez-libs imagemagick scrot redshift flameshot vlc pcmanfm transmission-gtk viewnior okular mousepad  unzip arandr tlp tlp-rdw libreoffice-fresh 
    echo

    # This is to backlight program to work
    echo "Setting up backlight adjustment program"
    echo "Enter your username:"
    read USERNAME

    sudo usermod -aG video $USERNAME
    echo

    # Enable bluetooth
    echo "Enabling bluetooth"
    sudo systemctl enable bluetooth
    echo

    # Enable TLP and setting up
    echo "Setting up TLP"
    sudo systemctl enable tlp.service

    sudo systemctl enable NetworkManager-dispatcher.service

    sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket  
    echo

    # Add touchpad tap and and right click with three fingers"
    echo "Setting up touchpad"
    sudo cp 90-touchpad.conf /etc/X11/xorg.conf.d/
    echo

elif [ $TYPE == "2" ]
then
    # Installing other programs
    sudo pacman -S rofi neofetch ntfs-3g xss-lock imagemagick scrot redshift flameshot vlc pcmanfm transmission-gtk viewnior okular mousepad  unzip arandr libreoffice-freshn 

    # Install bluetooth if the user want
    echo "Install bluetooth (y/n):"
    read INSTALL

    if [$INSTALL == "y"]
    then
        # Install bluetooth
        sudo pacman -S bluez bluez-utils bluez-libs
        # Enable bluetooth
        sudo systemctl enable bluetooth
    fi  
fi
echo
echo "Setup complete."