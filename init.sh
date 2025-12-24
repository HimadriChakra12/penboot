# Clone or update repo
if [ ! -d "$HOME/penboot" ]; then
    echo "Cloning Himarchy..."
    git clone "https://github.com/himadrichakra12/penboot.git" "$HOME/penboot"
else
    echo "Updating Himarchy..."
    cd "$HOME/penboot" || exit 1
    git pull --rebase --autostash
fi

cd "$HOME/penboot"

echo "
0[a]. Run the full bootstrap
1. Connect Symlinks
2. Run the kdeconfig
3. Run the Firefox Config
4. Install Packages
5. Vim-plug
"

read -p "Choose the Option: " opt

if [ "$(pwd)" == "$HOME/penboot" ]; then
    if [[ "$opt" == "0" || "$opt" == "a" ]]; then
        echo "Running The Full Bootstrap"
        bash bootstrap
    elif [[ "$opt" == "1" ]]; then
        # Run scripts
        echo "Configuring symlinks"
        bash ./scripts/symlink.sh
    elif [[ "$opt" == "2" ]]; then
        echo "Disabling KDE Animations"
        bash ./scripts/kdeanim.sh 
        echo "KDE debloat"
        bash ./scripts/kdebloat.sh 
    elif [[ "$opt" == "3" ]]; then
        echo "Firefox fixup"
        bash ./scripts/firefox.sh 
    elif [[ "$opt" == "4" ]]; then
        echo "Installing packages"
        bash ./scripts/packages.sh "$NOCONFIRM_FLAG"
    elif [[ "$opt" == "5" ]]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        vim +":PlugInstall"
    fi
else
    if [[ "$opt" == "0" || "$opt" == "a" ]]; then
        echo "Running The Full Bootstrap"
        bash $HOME/penboot/bootstrap
    elif [[ "$opt" == "1" ]]; then
        echo "Configuring symlinks"
        bash $HOME/penboot/scripts/symlink.sh
    elif [[ "$opt" == "2" ]]; then
        echo "Disabling KDE Animations"
        bash $HOME/penboot/scripts/kdeanim.sh 
        echo "KDE debloat"
        bash $HOME/penboot/scripts/kdebloat.sh 
    elif [[ "$opt" == "3" ]]; then
        echo "Firefox fixup"
        bash $HOME/penboot/scripts/firefox.sh 
    elif [[ "$opt" == "4" ]]; then
        echo "Installing packages"
        bash $HOME/penboot/scripts/packages.sh "$NOCONFIRM_FLAG"
    elif [[ "$opt" == "5" ]]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        vim +":PlugInstall"
    fi
fi

