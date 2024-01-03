#!/bin/bash

# Define the tool name
TOOL_NAME="fastgit"

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

# Define the function
FASTGIT_FUNCTION="
# ${TOOL_NAME} function
${TOOL_NAME}() {
    if [ -z \"\$1\" ]; then
        echo \"Please provide a commit message.\"
        return 1
    fi

    # Look for the .git directory in the current or parent directories
    current_dir=\$(pwd)
    while [ \"\$current_dir\" != \"/\" ]; do
        if [ -d \"\$current_dir/.git\" ]; then
            git -C \"\$current_dir\" add .
            git -C \"\$current_dir\" commit -a -m \"\$1\"
            git -C \"\$current_dir\" push
            return 0
        fi
        current_dir=\$(dirname \"\$current_dir\")
    done

    echo \"Not a Git repository. Skipping Git operations.\"
}

# ${TOOL_NAME}_reload function
${TOOL_NAME}_reload() {
    source \"\$CONFIG_FILE\"
    echo \"Shell configuration reloaded.\"
}"

# Append the function definition to the configuration file
echo "$FASTGIT_FUNCTION" >> "$CONFIG_FILE"

# Inform the user about the changes
echo "${TOOL_NAME} function added to $CONFIG_FILE. Please reload your shell."
