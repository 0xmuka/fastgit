#!/bin/bash

# Add the function to the shell configuration for bash
echo '
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

# Save the file and then reload the bash shell configuration
source ~/.bashrc   # or source ~/.bash_profile for Mac
' > temp_script.sh

# Execute the temporary script for bash
source temp_script.sh

# Check if the shell is Zsh before attempting Zsh-specific operations
if [ -n "$ZSH_VERSION" ]; then
    # Add the function to the shell configuration for zsh
    echo '
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

    # Save the file and then reload the zsh shell configuration
    source ~/.zshrc
    ' > temp_script_zsh.sh

    # Execute the temporary script for zsh
    source temp_script_zsh.sh
fi

# Now you can use the lazygit function with a commit message
lazygit "My commit msg"

# Cleanup: Remove the temporary scripts
rm -f temp_script.sh temp_script_zsh.sh

