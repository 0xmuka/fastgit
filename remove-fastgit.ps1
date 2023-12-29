# Define the tool name
$toolName = "fastgit"

# Get the current user's profile path
$profilePath = $PROFILE.CurrentUserCurrentHost

# Remove the added functions from the profile script
(Get-Content -Path $profilePath) -notmatch "# ${toolName} function|# ${toolName}_reload function" | Set-Content -Path $profilePath

Write-Host "${toolName} functions removed from \$profilePath."

