fastfetch
oh-my-posh init pwsh --config "$env:USERPROFILE\.poshthemes\pure.omp.json" | Invoke-Expression
fnm env --use-on-cd | Out-String | Invoke-Expression
SET-Alias ls eza
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Import-Module PSFzf
Set-Alias cat bat
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f'