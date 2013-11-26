set nocompatible
filetype on  " Yep..
filetype off
if has("win32")
    set rtp+=~/vimfiles/bundle/vundle
else
    if has("unix")
        set rtp+=~/.vim/bundle/vundle/
    endif
endif

call vundle#rc()

Bundle 'gmarik/vundle'

"==== Vim editing steroids
Bundle 'Auto-Pairs'
Bundle 'tpope/vim-commentary'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-speeddating'
Bundle 'surround.vim'
Bundle 'godlygeek/tabular'
Bundle 'sunnogo/vim-taghighlight'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'YankRing.vim'
" Bundle 'Shougo/vimproc'
" Bundle 'Shougo/unite.vim'

"==== Completion / IDE stuff
Bundle "scrooloose/syntastic"
" Bundle "Valloric/YouCompleteMe"
Bundle 'a.vim'
" Bundle 'vim-scripts/AutoComplPop'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/OmniCppComplete'
Bundle 'majutsushi/tagbar'
Bundle 'SirVer/ultisnips'

"==== Rainbows
Bundle 'altercation/vim-colors-solarized'
Bundle 'daylerees/colour-schemes', { 'rtp': 'vim-themes/' }
Bundle 'tomasr/molokai'
Bundle 'jnurmine/Zenburn.git'

"==== Random lang support
Bundle 'Blackrush/vim-gocode'
Bundle 'beyondmarc/glsl.vim'
Bundle 'kelan/gyp.vim'
Bundle 'tpope/vim-markdown'
Bundle 'wting/rust.vim'
Bundle 'vim-scripts/slimv.vim'
Bundle 'jpalardy/vim-slime'
Bundle 'bitc/vim-hdevtools'
Bundle 'lukerandall/haskellmode-vim'

set backspace=2
set history=1024  " Lines of history
filetype plugin on
filetype indent on

" No bells
"
set noerrorbells
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=

syntax on

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

au BufNewFile,BufRead *.glsl set filetype=glsl330

" Hide buffers, don't close them
set hidden

"set shellslash

set nobackup
set nowritebackup

set wildmenu
set number
" Very magic search
nnoremap / /\v

function! LongLines()
    set wrap
    set linebreak
    set nolist
    set textwidth=0
    set wrapmargin=0
endfunction

" Highlight current line.
set cursorline

set hlsearch
" clear highlight with C-k
nnoremap <C-k> :noh<cr><cr>
set incsearch
set ignorecase
set smartcase

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

set noerrorbells

set nobackup
set noswapfile

set laststatus=2 "Always display status line
"set cmdheight=2

"Remap j and k to be visual
noremap j gj
noremap k gk

"Auto-Pairs config
let g:AutoPairsFlyMode=0

noremap <C-t> :CtrlPBuffer<cr>
inoremap <C-t> <esc>:CtrlPBuffer<cr>
noremap <C-3> :CtrlPMRU<cr>
noremap <C-3> <esc>:CtrlPMRU<cr>
noremap <F2> :NERDTreeToggle<cr>

let g:ctrlp_working_path_mode = 0

" Remapping for YankRing
let g:yankring_replace_n_pkey = ",p"
let g:yankring_replace_n_nkey = ",n"

" Ultisnips with YouCompleteMe
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Better than esc.
inoremap jj <esc>
" Go to the end while in insert mode
inoremap ,, <esc>A
" Saving
nmap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>

" Swap Header/Impl
noremap <C-Tab> :A<cr>
inoremap <C-Tab> <esc>:A<cr>

" Move between functions
noremap <leader>e ]}

" Change directory to current file.
nmap <leader>d :cd %:p:h<cr>

let g:Powerline_symbols="fancy"


" auto-complete
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_omni_patterns.go = '[^.[:digit:] *\t]\%(\.\)\|\a'

"Make
map <leader>n :cn<cr>
noremap <F5> :make<cr>
inoremap <F5> <esc>:make<cr>
noremap <F6> @e<cr>
inoremap <F6> <esc>@e<cr>
"set makeprg=make\ -j8
set makeprg=ninja\ -C\ out/Debug\ -k\ 1
func! UseGitGrep()
    set grepprg=git\ grep\ -n\ $*
endf
func! UseGrep()
    set grepprg=grep\ -n\ $*\ /dev/null
endf
call UseGitGrep()

" Add my tags
set tags+=~/work/tags

" C++ style
set colorcolumn=81,101
" No namespace indent, no indent for case, unindent label block, no indent for
" public, private in classes
set cino=N-s,:0,l1,g0

au BufNewFile,BufRead cpp set filetype=cpp

" Quickfix window variable Height
au FileType qf call AdjustWindowHeight(3, 40)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" ----- Haskell
au FileType haskell nnoremap <buffer> <F7> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F8> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F9> :HdevtoolsInfo<CR>
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()

"tagbar rust support:
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds'     : [
    \ 'f:function',
    \ 'T:types',
    \ 'm:modules',
    \ 'c:consts',
    \ 't:traits',
    \ 'I:impls',
    \ 'M:macros'
    \ ]
\ }

" go support
autocmd FileType go setlocal omnifunc=gocomplete#Complete

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


map <f3> :TagbarToggle<CR>
map <C-l> :TagbarOpen fj<CR>/
"let g:tagbar_left=1  " Right works better...
"map <f3> :TlistOpen<cr>
"noremap <C-l> :TlistToggle<cr> "/
"inoremap <C-l> <esc>:TlistToggle<cr> "/

"" Configure Tlist to pop up
"let Tlist_Show_One_File=1
"let Tlist_Use_Right_Window = 0
"let Tlist_GainFocus_On_ToggleOpen=1
"let Tlist_Close_On_Select=1

"let Tlist_WinWidth = 60
"let Tlist_WinHeight = 80

" Change background color depending on time
function! SetDayColor()
python << EOF
import vim, time
hour = time.localtime().tm_hour
if hour >= 19 or hour < 8:
    vim.command("set background=dark\n")
else:
    vim.command("set background=light\n")
EOF
endfunction
call SetDayColor()

