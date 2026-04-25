if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch
    starship init fish | source
    fnm env --use-on-cd | source
    zoxide init fish | source
    set -gx PNPM_HOME $HOME/.local/share/pnpm
    set -gx PATH $PNPM_HOME $PATH
end
