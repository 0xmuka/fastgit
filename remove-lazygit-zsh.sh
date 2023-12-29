#!/bin/zsh

# Check if the .zshrc file exists
if [ -e "$HOME/.zshrc" ]; then
    # Remove the added functions from the .zshrc file
    sed -i '/# lazygit function/,/# lazygit_reload function/d' "$HOME/.zshrc"
    echo "lazygit functions removed from $HOME/.zshrc."
    
    # Reload the Zsh shell
    exec zsh

    echo "Zsh shell reloaded. Please note that this will close the current shell session."
else
    echo "$HOME/.zshrc not found. No changes made."
fi

