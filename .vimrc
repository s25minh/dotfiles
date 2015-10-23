"Gvim - MacVimの設定
set guifontwide=ヒラギノ角ゴ\ Pro\ W3:h15
syntax enable
set background=dark
colorscheme wombat256mod
set t_Co=256
set laststatus=2
set list
set listchars=eol:×,tab:¦ ,trail:·
set smarttab
set number
set ruler
set autoindent
set smartindent
set showmatch
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set whichwrap=b,s,[,],<,>
set cursorline
"無名クリップボードの有効化
set clipboard+=unnamed
"vi互換をオフする
set nocompatible
"システムレベルの貼り付けを使うとき便利なトーグル
"有効・無効をf５キーで変換できる
set pastetoggle=<f5>
"No beep sounds
set noerrorbells
set vb t_vb=
"マウス使用可能
set mouse=a
"-----------------------------------------
"Search
"-----------------------------------------
"インクリメンタルサーチ
set incsearch
"大文字/小文字を区別しない
set ignorecase
"大文字を含む場合は区別する
set smartcase
"検索語のハイライト
set hlsearch

"検索結果のハイライトをESC連打で消す
noremap <Esc><Esc> :nohlsearch<CR>

inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

set noswapfile

set scrolloff=8

" 現在開いているファイルを実行 (only php)
function! ExecuteCurrentFile()
    if &filetype == 'js'
        exe '!node %'
    endif
    if &filetype == 'php'
        exe '!' . &filetype . ' %'
    endif
endfunction
nnoremap <Space> :call ExecuteCurrentFile()<CR>

" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
    
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplcache'

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
	\ 'default' : '',
	\ 'vimshell' : $HOME.'/.vimshell_hist',
	\ 'scheme' : $HOME.'/.gosh_completions'
		\ }

"Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

"SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

"Recommended key-mappings.
"<CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"<TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"<C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
"AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"NeoBundle 'scrooloose/syntastic'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

NeoBundle 'surround.vim'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'chriskempson/vim-tomorrow-theme'
"vimproc
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \ 'windows' : 'make -f make_mingw32.mak',
  \ 'cygwin' : 'make -f make_cygwin.mak',
  \ 'mac' : 'make -f make_mac.mak',
  \ 'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundle 'othree/html5.vim'
let g:html5_event_handler_attributes_complete = 0
let g:html5_event_handler_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

"easy-align
NeoBundle 'junegunn/vim-easy-align'
vnoremap <silent> <Enter> :EasyAlign<cr>

"powerline.vim
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'} 

"MarkDown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a firefox'

"vim-ctags
NeoBundle 'szw/vim-tags'
au BufNewFile,BufRead *.php let g:vim_tags_project_tags_command = "ctags --languages=php -f ~/php.tags `pwd` 2>/dev/null &"
"拡張子で読み込みタグ変更
au BufNewFile,BufRead *.php set tags+=~/php.tags
nnoremap <C-]> g<C-]>


call neobundle#end()

filetype plugin indent on

runtime macros/matchit.vim
"</で閉じタグを自動補完
autocmd FileType html inoremap <silent> <buffer> </ </<C-x><C-o>
autocmd FileType php inoremap <silent> <buffer> </ </<C-x><C-o>

"nerdtree : ctrl + eで開く
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"DB 設定
let g:sql_type_default='mysql'
let g:ref_phpmanual_path = $HOME . '/.vim/ref/php-chunked-xhtml'


"PHP開発環境設定
let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1

"function! MyTabFunc()
"    let pos = getpos('.')
"    let c = getline('.')[pos[2]-1]
"    if(c =~ "[\\)\\]\'\"]")
"        return "\<Right>\<Right>"
"    endif
"    return "\<Tab>"
"endfunction
"inoremap <expr> <Tab> MyTabFunc()

autocmd FileType php,ctp :set dictionary=~/.vim/dict/php.dict
"ファイルタイプごとのインデント
augroup fileTypeIndent
	autocmd!
		autocmd BufRead,BufNewFile *.php setlocal shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab autoindent smartindent
		autocmd BufRead,BufNewFile *.html setlocal shiftwidth=2 softtabstop=2 tabstop=2 noexpandtab
		autocmd BufRead,BufNewFile *.js setlocal shiftwidth=2 softtabstop=2 tabstop=2 noexpandtab
		autocmd BufRead,BufNewFile *.css setlocal shiftwidth=2 softtabstop=2 tabstop=2 noexpandtab
		autocmd BufRead,BufNewFile *.txt setlocal shiftwidth=2 softtabstop=2 tabstop=2 noexpandtab
		autocmd BufRead,BufNewFile *.xml setlocal shiftwidth=2 softtabstop=2 tabstop=2 noexpandtab
augroup END

"autocmd filetype php setlocal shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab
"autocmd filetype html,coffee,javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 noexpandtab
"if expand("%:t") =~ ".*\.php"
"  set noexpandtab
"  set tabstop=4
"  set shiftwidth=4
"endif
"if expand("%:t") =~ ".*\.js"
"  set noexpandtab
"  set tabstop=2
"  set shiftwidth=2
"endif
"if expand("%:t") =~ ".*\.css"
"  set noexpandtab
"  set tabstop=2
"  set shiftwidth=2
"endif
"if expand("%:t") =~ ".*\.html"
"  set noexpandtab
"  set tabstop=2
"  set shiftwidth=2
"endif
