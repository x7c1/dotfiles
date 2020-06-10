if &compatible
  set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  if !has('nvim')
    throw 'use nvim!'
  endif

  let g:rc_dir = expand('~/.config/nvim')
  call dein#load_toml(g:rc_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
set noswapfile
set shiftwidth=2
set tabstop=2
set expandtab
set number

" stop searches when the end of the file is reached
set nowrapscan

" status line format
set laststatus=2
set statusline=
    \%<[%n]%f\ %m%r%h%w%{
        \'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'
    \}%=%l,%c%V%6P

" show spaces
set listchars=tab:>.,trail:_
set list

" always display tab labels
set showtabline=2

" show japanese damn confusing space
highlight ZenkakuSpace ctermbg=black guibg=black
match ZenkakuSpace /　/

" test 　 zenkaku-space
    " test tail space         
        " test mixed space    

" turn highlight off by pressing esc twice
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" highlight style
highlight Search cterm=NONE ctermfg=white ctermbg=110

"case-insensitive while all strings are lowercase
set smartcase
set ignorecase

" keys to wrap around the start and end of individual lines
set whichwrap=b,s,h,l,<,>,~,[,]

" tab-page key bindings
noremap <C-g><C-n> :tabn<CR>
noremap <C-g><C-p> :tabp<CR>
inoremap <C-g><C-n> <ESC>:tabn<CR>
inoremap <C-g><C-p> <ESC>:tabp<CR>

" make selected words to be searched
vnoremap * y/<C-r>0<CR>

" Denite key bindings
nnoremap [Denite] <nop>
nmap  gu [Denite]
nnoremap [Denite]b :Denite buffer<cr>
nnoremap [Denite]d :Denite directory_rec<cr>
nnoremap [Denite]f :Denite file/rec<cr>
nnoremap [Denite]l :Denite line -auto-action=preview<cr>
nnoremap [Denite]m :Denite file/old -auto-action=preview<cr>

" Denite mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'

  nnoremap <silent><buffer><expr> l
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> v
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> s
  \ denite#do_map('do_action', 'split')
endfunction

