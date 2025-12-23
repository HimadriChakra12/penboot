firefox about:profiles
read -p "Whats the path O'your Firefox Profile: " path
mkdir -p "$path/chrome"
dotfiles=(
    "$HOME/penboot/dotfiles/firefox/userChrome.css:$path/chrome/userChrome.css"
    "$HOME/penboot/dotfiles/firefox/user.js:$path/user.js"
)

echo "Linking dotfiles..."
for entry in "${dotfiles[@]}"; do
    src="${entry%%:*}"
    tgt="${entry##*:}"
    echo "Linking $src → $tgt"
    rm "$tgt" -r
    ln -sf "$src" "$tgt"
done

sudo cp $HOME/penboot/dotfiles/firefox/policies.json /usr/lib/firefox/distribution
