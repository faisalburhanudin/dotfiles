export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [ -z "$TMUX" ]; then
  exec tmux new-session -A -s workspace
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# enable comment in interactive shell
setopt interactive_comments

# open command using ^b
autoload edit-command-line
zle -N edit-command-line
bindkey '^b' edit-command-line

export EDITOR=nvim

alias z=zoxide
alias lg='lazygit'
alias .=source
alias v="nvim"
alias ll='ls -ltra'
alias g='goland .'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"
# eval "$(starship init zsh)"
eval "$(navi widget zsh)"

# google cloud sdk
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# java config
export GROOVY_HOME=/opt/homebrew/opt/groovy/libexec

# load zshrc rg
source $HOME/.zshrc-rg

# load rust
source $HOME/.cargo/env

# load zsh auto autosuggestions
# should be in the end of config
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# load atuin
eval "$(atuin init zsh --disable-up-arrow)"

# on tab expand alias
zstyle ':completion:*' completer _expand_alias _complete _ignored

alias rlv='rogu list-version'
alias rdv=rogu deploy-version
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

cl() {
  cloned=$(command cl -dir "$GOPATH/src" "$1")
  cd "$cloned"
}

alias rg='rg --smart-case'
export PATH=$PATH:~/.rbenv/shims

# Added by `rbenv init` on Mon Aug 19 10:09:30 WIB 2024
eval "$(rbenv init - --no-rehash zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="/opt/homebrew/opt/icu4c@76/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c@76/sbin:$PATH"
