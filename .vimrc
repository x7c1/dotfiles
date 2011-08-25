
"vundle {{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"repos on vim-scripts
Bundle 'Align'

"repos on github
Bundle 'gmarik/vundle'
Bundle 'kana/vim-surround'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/vimfiler'
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

"アンダーバー区切りの補完を有効に
let g:neocomplcache_enable_underbar_completion = 1
"}}}

"unite {{{

"from current directory
nnoremap <C-g><C-f><C-f> :UniteWithBufferDir file -buffer-name=file<CR>
nnoremap <C-g><C-f><C-r> :UniteWithBufferDir file_rec -buffer-name=file_rec<CR>
nnoremap <C-g><C-f><C-m> :Unite file_mru<CR>

nnoremap <C-g><C-b> :Unite buffer<CR>
nnoremap <C-g><C-s> :Unite source<CR>
nnoremap <C-g><C-t> :Unite tab<CR>
nnoremap <C-g><C-l> :Unite line<CR>
nnoremap <C-g><C-m><C-p> :Unite ref/phpmanual<CR>

au filetype unite nnoremap <silent> <buffer> <esc><esc> :q<cr>
au filetype unite inoremap <silent> <buffer> <esc><esc><esc>:q<cr>
au filetype unite nnoremap <silent> <buffer> <expr><c-l> unite#do_action('tabopen')
au filetype unite inoremap <silent> <buffer> <expr><c-l> unite#do_action('tabopen')
au filetype unite nnoremap <silent> <buffer> <expr><c-j> unite#do_action('split')
au filetype unite inoremap <silent> <buffer> <expr><c-j> unite#do_action('split')
au filetype unite nnoremap <silent> <buffer> <expr><c-k> unite#do_action('vsplit')
au filetype unite inoremap <silent> <buffer> <expr><c-k> unite#do_action('vsplit')

"start with insert-mode
let g:unite_enable_start_insert=1

"}}}

"vimfiler
let g:vimfiler_safe_mode_by_default = 0

"vim-ref
"esc esc で閉じる
au filetype ref-phpmanual nnoremap <silent> <buffer> <esc><esc> :q<cr>

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

