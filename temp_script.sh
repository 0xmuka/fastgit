
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

