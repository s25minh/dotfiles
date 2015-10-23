#(d) is default on

# ------------------------------
# # General Settings
# # ------------------------------

export PATH=/usr/local/mysql/bin:$PATH:
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす
export PATH=$PATH:~/Library/Python/2.7/bin

bindkey -v              # キーバインドをviモードに設定
setopt NO_beep
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
#setopt correct           # コマンドのスペルを訂正する
#setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
#setopt notify            # バックグラウンドジョブの状態変化を即時報告する
##setopt equals            # =commandを`which command`と同じ処理にする

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }
autoload -U colors; colors

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
		;;
kterm)
	export TERM=kterm-color
	# set BackSpace control character
	stty erase
  ;;
cons25)
	unset LANG
	export LSCOLORS=ExFxCxdxBxegedabagacad
    export
LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors \
		'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
	;;
esac
## #Prompt ###
## プロンプトに色を付ける
# 一般ユーザ時
autoload colors
colors
local cur_dir="%B%F{red}[Current Path: %~ ]%f%b"$'\n'
local main="%B%F{green}%n%f%b@%F{blue}%m%f"
PROMPT=" $cur_dir$main %F{yellow}>>%f "

# ------------------------------
# Other Settings
# ------------------------------
#zsh-syntax-highlighting コマンドをハイライトする
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi 

#eval $(gdircolors ~/dircolors/dircolors-solarized/dircolors.ansi-universal)
#if [ -f ~/.dircolors ]; then
#    if type dircolors > /dev/null 2>&1; then
#        eval $(dircolors ~/.dircolors)
#    elif type gdircolors > /dev/null 2>&1; then
#        eval $(gdircolors ~/.dircolors)
#    fi
#fi 
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-color ${(s.:.)LS_COLORS}
fi
##########
#alias
##########
alias history='history -E'
alias ls='ls -G'
alias ll='ls -Gl'
alias la='ls -Gal'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# cdコマンド実行後、lsを実行する
function cd() {
  builtin cd $@ && ls;
}
