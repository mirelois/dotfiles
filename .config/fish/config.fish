source /usr/share/cachyos-fish-config/cachyos-config.fish

fish_add_path ~/bin

#overwrite greeting
#potentially disabling fastfetch
function fish_greeting
   pokemon-colorscripts -r
end

function take
    mkdir -p "$argv[1]"; and cd "$argv[1]"
end

funcsave --quiet take

alias n="nvim ."
alias a="tmux-sessionizer ~"

fish_vi_key_bindings

bind -M insert ctrl-p up-or-search
bind -M insert ctrl-n down-or-search
bind -M insert ctrl-k accept-autosuggestion

zoxide init --cmd cd fish | source
