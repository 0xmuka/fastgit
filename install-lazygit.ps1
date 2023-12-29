# Add the lazygit function to the PowerShell profile
Add-Content $PROFILE -Value @"
function lazygit {
    param (
        [string]$CommitMessage
    )

    if (-not $CommitMessage) {
        Write-Host "Please provide a commit message."
        return
    }

    if (Test-Path .git) {
        git add .
        git commit -a -m "$CommitMessage"
        git push
    }
    else {
        Write-Host "Not a Git repository. Skipping Git operations."
    }
}
"@

Write-Host "lazygit function added to $PROFILE. Please reload your PowerShell session."

