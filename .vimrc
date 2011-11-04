
"vundle {{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"repos on vim-scripts
Bundle 'Align'
Bundle 'actionscript.vim'

"repos on github
Bundle 'gmarik/vundle'
Bundle 'kana/vim-surround'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'Shougo/unite.vim'
Bundle 'sgur/unite-qf'
Bundle 'thinca/vim-ref'

filetype plugin indent on
"}}}

"neocomplcache {{{
"rf. http://vim-users.jp/2010/10/hack177/

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_snippets_dir = $HOME . '/.vim/snippets'

"アンダーバー区切りの補完を有効に
let g:neocomplcache_enable_underbar_completion = 1

" http://vim-users.jp/2010/11/hack185/
imap <c-k>    <plug>(neocomplcache_snippets_expand)
smap <c-k>    <plug>(neocomplcache_snippets_expand)
inoremap <expr><c-g> neocomplcache#undo_completion()
inoremap <expr><c-l> neocomplcache#complete_common_string()

"}}}

"unite {{{

"rf. http://vim-users.jp/2009/08/hack-59/
nnoremap [Unite] <nop>
nmap  gu [Unite]
nnoremap [Unite]b :Unite buffer<cr>
nnoremap [Unite]f :UniteWithBufferDir file -buffer-name=files<cr>
nnoremap [Unite]l :Unite line<cr>
nnoremap [Unite]m :Unite file_mru<cr>
nnoremap [Unite]r :UniteWithBufferDir file_rec -buffer-name=files<cr>
nnoremap [Unite]s :Unite source<cr>
nnoremap [Unite]t :Unite tab<cr>

au filetype unite nnoremap <silent> <buffer> <esc><esc> :q<cr>
au filetype unite nnoremap <silent> <buffer> <expr><c-l> unite#do_action('tabopen')
au filetype unite inoremap <silent> <buffer> <expr><c-l> unite#do_action('tabopen')
au filetype unite nnoremap <silent> <buffer> <expr><c-j> unite#do_action('split')
au filetype unite inoremap <silent> <buffer> <expr><c-j> unite#do_action('split')
au filetype unite nnoremap <silent> <buffer> <expr><c-k> unite#do_action('vsplit')
au filetype unite inoremap <silent> <buffer> <expr><c-k> unite#do_action('vsplit')
au filetype unite inoremap <silent> <buffer> <expr><c-i> unite#do_action('insert')
au filetype unite nnoremap <silent> <buffer> <expr><c-p> unite#do_action('persist_open')
au filetype unite nnoremap <silent><buffer><s-j> j:call unite#mappings#do_action('persist_open')<cr>
au filetype unite nnoremap <silent><buffer><s-k> k:call unite#mappings#do_action('persist_open')<cr>

"start with insert-mode
let g:unite_enable_start_insert=1
call unite#util#set_default('g:unite_source_file_mru_limit', 1000)

"}}}

"vimshell
nnoremap [VimShell] <nop>
nmap  gv [VimShell]
nnoremap [VimShell]t :VimShellTab<cr>

"vimfiler
let g:vimfiler_safe_mode_by_default = 0

"vim-ref
"esc esc で閉じる
au filetype ref-phpmanual nnoremap <silent> <buffer> <esc><esc> :q<cr>

"actionscript.vim
au BufNewFile,BufRead *.as set filetype=actionscript

" nerdcommenter
" 未対応タイプのエラーを非表示に
let NERDShutUp = 1

syntax on
set noswapfile
set tabstop=4
set shiftwidth=4
set noexpandtab

"case-insensitive while all strings are lowercase
set smartcase
set ignorecase

" 検索結果ハイライト
set hlsearch

" incremental
set incsearch

" 検索カーソルをファイルの先頭・末尾で止める
set nowrapscan

" 折り畳み : 3 braces
set foldmethod=marker

" BS でインデントや改行を消せるように
set backspace=indent,eol,start

" ステータスラインの行数と表示情報
set laststatus=2
set statusline=
    \%<[%n]%f\ %m%r%h%w%{
        \'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'
    \}%=%l,%c%V%6P

" ( タブ文字 & 末尾の連続した空白 ) を可視化
set listchars=tab:>.,trail:_

" タブ、改行を表示
set list

" タブページのラベルを常に表示
set showtabline=2

" 全角スペースのハイライト
highlight ZenkakuSpace ctermbg=cyan guibg=cyan
match ZenkakuSpace /　/

" test 　 zenkaku-space
    " test tail space           
	" test mixed space	   		        

" 行頭行末から前後の行に移れるキー
set whichwrap=b,s,h,l,<,>,~,[,]

" タブページ移動用キーマッピング
noremap <C-g><C-n> :tabn<CR>
noremap <C-g><C-p> :tabp<CR>
inoremap <C-g><C-n> <ESC>:tabn<CR>
inoremap <C-g><C-p> <ESC>:tabp<CR>

" 補完候補の色設定
hi Pmenu ctermbg=white ctermfg=black
hi PmenuSel ctermbg=cyan ctermfg=black

" 選択中の範囲を検索ワードに
vnoremap * y/<C-r>0<CR>

" Esc 二回でハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" 対括弧のハイライトは薄色で
highlight MatchParen ctermbg=lightgrey guibg=lightgrey

if filereadable(expand('~/.vimrc.local'))
    " http://vim-users.jp/2009/12/hack108/
    source ~/.vimrc.local
endif

