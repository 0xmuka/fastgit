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

    if [ -d .git ]; then
        git add .
        git commit -a -m \"\$1\"
        git push
    else
        echo \"Not a Git repository. Skipping Git operations.\"
    fi
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

