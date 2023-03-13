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

# Move kitty folder to "~/.config/" folder or create a folder and move that file
echo "Copying kitty folder..."
echo
sudo cp -r kitty/ ~/.config
echo

# Move picom folder to "~/.config/" folder or create a folder and move that file
echo "Coving picom folder..."
echo
sudo cp -r picom/ ~/.config
echo

# Move ranger to "~/.config/" folder or create a folder and move that file
echo "Coving Ranger folder..."
echo
sudo cp -r ranger/ ~/.config
echo

# Move rofi folder to "~/.config/" folder or create a folder and move that file
echo "Coving Rofi folder..."
echo
sudo cp -r rofi/ ~/.config
echo

# Install essential apps
echo "Installing essential apps"
echo
sudo pacman -S pacman-contrib xdg-user-dirs ufw -y
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
sudo pacman -S ttf-jetbrains-mono-nerd ttf-fira-code nitrogen picom lxappearance qt5ct gnome-themes-extra kvantum papirus-icon-theme -y
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
    sudo pacman -S light rofi neofetch ntfs-3g xss-lock blueman bluez bluez-utils bluez-libs pcmanfm gvfs xarchiver ranger atool ffmpegthumbnailer highlight libcaca mediainfo poppler transmission-cli w3m odt2txt redshift xfce4-clipman-plugin flameshot vlc transmission-gtk ristretto epdfview mousepad tlp tlp-rdw libreoffice-fresh -y # or libreoffice-still for stable version
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
    sudo pacman -S rofi neofetch ntfs-3g xss-lock pcmanfm gvfs xarchiver ranger atool ffmpegthumbnailer highlight libcaca mediainfo poppler transmission-cli w3m odt2txt redshift xfce4-clipman-plugin flameshot vlc transmission-gtk ristretto epdfview mousepad ibreoffice-fresh -y # or libreoffice-still for stable version

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
# Install autotiling for i3
echo "Install autotiling..."
yay -S autotiling -y
echo
echo "Install programming stuff? (y/n):"
read RESPONSE
if  [ $RESPONSE == "y" ]  
then 
    # Install fish shell
    echo "Installing fish shell"
    echo
    sudo pacman -S fish
    echo 

    # Install google chrome and vs code
    echo "Installing chrome and vs code"
    echo
    yay -S google-chrome visual-studio-code-bin -y
    echo

    Install needed python packages 
    echo "Installing Python-tk and pip package manager"
    echo
    sudo pacman -S python tk python-pip # python-tk python-pip packages
    echo 

    # Install mogodb and enable autostart on boot
    echo "Installing MongoDB"
    echo
    yay -S mongodb-bin -y
    sudo systemctl start mongodb
    sudo systemctl status mongodb
    sudo systemctl enable mongodbi
    mongod --version
    ./new_github_ssh_and_nvm_install.sh

    echo "Generating github ssh and installing nvm"
    echo
    ./new_github_ssh_and_nvm_install.sh
    echo
fi

echo "Setup complete."
