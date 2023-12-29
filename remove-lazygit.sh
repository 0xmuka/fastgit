#!/bin/bash

remove_lazygit_config() {
    # Check the shell type and determine the configuration file
    if [ -n "$BASH_VERSION" ]; then
        CONFIG_FILE=~/.bashrc
        SHELL_TYPE="Bash"
    elif [ -n "$ZSH_VERSION" ]; then
        CONFIG_FILE=~/.zshrc
        SHELL_TYPE="Zsh"
    else
        echo "Unsupported shell. Please use Bash or Zsh."
        exit 1
    fi

    # Remove the added functions from the configuration file
    sed -i '/# lazygit function/,/# lazygit_reload function/d' "$CONFIG_FILE"

    echo "lazygit functions removed from $CONFIG_FILE."

    # Reload the shell
    if [ "$SHELL_TYPE" == "Bash" ]; then
        source "$CONFIG_FILE"
    elif [ "$SHELL_TYPE" == "Zsh" ]; then
        exec zsh
    fi

    echo "$SHELL_TYPE shell reloaded. Please note that this will close the current shell session."
}

# Call the function to remove and reload
remove_lazygit_config

