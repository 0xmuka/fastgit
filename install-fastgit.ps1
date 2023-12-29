# Define the tool name
$toolName = "fastgit"

# Get the current user's profile path
$profilePath = $PROFILE.CurrentUserCurrentHost

# Define the function
$fastGitFunction = @"
# ${toolName} function
function ${toolName} {
    param(
        [string]\$CommitMessage
    )

    if (-not (Test-Path .git)) {
        Write-Host "Not a Git repository. Skipping Git operations."
        return
    }

    git add .
    git commit -a -m "\$CommitMessage"
    git push
}

# ${toolName}_reload function
function ${toolName}_reload {
    . \$profilePath
    Write-Host "Shell configuration reloaded."
}
"@

# Add the function definition to the profile script
Add-Content -Path $profilePath -Value $fastGitFunction

Write-Host "${toolName} function added to \$profilePath. Please reload your shell."

