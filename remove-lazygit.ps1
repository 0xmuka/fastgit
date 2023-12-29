# Remove the lazygit function from the PowerShell profile
(Get-Content $PROFILE) -notmatch "function lazygit" | Out-File $PROFILE

Write-Host "lazygit function removed from $PROFILE. Please reload your PowerShell session."

