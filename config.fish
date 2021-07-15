set -x MACINJOKE (ghq root)/github.com/macinjoke
set -x VARIOUS $MACINJOKE/various
set -x PATH ./node_modules/.bin $PATH

# fzf
# https://github.com/jethrokuan/fzf
set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_DEFAULT_OPTS "--reverse --height=100%"
set -x FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"
set -x HOMEBREW_NO_AUTO_UPDATE 1

# fisherのインストール
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# tmux の設定 https://qiita.com/mkeeda/items/c5fa878436f1cc957892 より
function attach_tmux_session_if_needed
    set ID (tmux list-sessions)
    if test -z "$ID"
        tmux new-session
        return
    end

    set new_session "Create New Session"
    set ID (echo $ID\n$new_session | peco --on-cancel=error | cut -d: -f1)
    if test "$ID" = "$new_session"
        tmux new-session
    else if test -n "$ID"
        tmux attach-session -t "$ID"
    end
end
if test -z $TMUX && status --is-login
    attach_tmux_session_if_needed
end

# pecoでCtrl+Rの設定 (top-down にしたかったのでpluginのコードコピペして修正)
# https://github.com/oh-my-fish/plugin-peco/blob/master/functions/peco_select_history.fish
# fzf を使うようにしたのでひとまず用済み
# function peco_select_history
#     if test (count $argv) = 0
#         set peco_flags --layout=top-down
#     else
#         set peco_flags --layout=top-down --query "$argv"
#     end
#     history | peco $peco_flags | read foo
#     if [ $foo ]
#         commandline $foo
#     else
#         commandline ''
#     end
# end
# function fish_user_key_bindings
#     bind \cr 'peco_select_history (commandline -b)'
# end

# nvm
nvm use || nvm use default
echo

# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
test -f /Users/macinjoke/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /Users/macinjoke/.ghcup/bin $PATH

