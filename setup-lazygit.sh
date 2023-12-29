#!/bin/bash

# Define the lazygit function
function lazygit() {
    if [ -z "$1" ]; then
        echo "Please provide a commit message."
        return 1
    fi

    if [ -d .git ]; then
        git add .
        git commit -a -m "$1"
        git push
    else
        echo "Not a Git repository. Skipping Git operations."
    fi
}

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

# Append the function definition to the configuration file
echo '
# lazygit function
lazygit() {
    if [ -z "$1" ]; then
        echo "Please provide a commit message."
        return 1
    fi

    if [ -d .git ]; then
        git add .
        git commit -a -m "$1"
        git push
    else
        echo "Not a Git repository. Skipping Git operations."
    fi
}

# lazygit_reload function
lazygit_reload() {
    source '"$CONFIG_FILE"'
    echo "Shell configuration reloaded."
}
' >> "$CONFIG_FILE"

# Inform the user about the changes
echo "lazygit function added to $CONFIG_FILE. Please reload your shell."

# Remove the lazygit_reload function from the configuration file
remove_lazygit_reload() {
    # Remove the lazygit_reload function from the configuration file
    sed -i '/lazygit_reload() {/,/}/d' "$CONFIG_FILE"

    echo "lazygit_reload function removed from $CONFIG_FILE."

    # Reload the shell
    if [ "$SHELL_TYPE" == "Bash" ]; then
        source "$CONFIG_FILE"
    elif [ "$SHELL_TYPE" == "Zsh" ]; then
        exec zsh
    fi

    echo "$SHELL_TYPE shell reloaded. Please note that this will close the current shell session."
}

# Call the function to remove and reload
remove_lazygit_reload


