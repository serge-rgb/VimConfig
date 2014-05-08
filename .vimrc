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
Bundle 'TagHighlight'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'YankRing.vim'

"==== Completion / IDE stuff
Bundle "scrooloose/syntastic"
Bundle "Valloric/YouCompleteMe"
" Bundle "Shougo/neocomplete"
Bundle 'a.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'SirVer/ultisnips'
"... Random lang support
" Bundle 'Blackrush/vim-gocode'
Bundle 'beyondmarc/glsl.vim'
Bundle 'kelan/gyp.vim'
Bundle 'tpope/vim-markdown'
Bundle 'wting/rust.vim'
Bundle 'vim-scripts/slimv.vim'
Bundle 'bitc/vim-hdevtools'
Bundle 'lukerandall/haskellmode-vim'
"... Latex crap"
Bundle 'git://git.code.sf.net/p/vim-latex/vim-latex'

"==== Rainbows
Bundle 'altercation/vim-colors-solarized'
Bundle 'daylerees/colour-schemes', { 'rtp': 'vim-themes/' }
Bundle 'tomasr/molokai'
Bundle 'jnurmine/Zenburn.git'


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

" Personal log helpers...
func! OpenLog()
    e ~/Dropbox/log.txt
endf
au BufRead *.txt noremap <leader>t o --- 0pom<esc>^hi
au BufRead *.txt noremap <leader>a :Tabularize /---<cr>

func! LoadRC()
    so ~/.vimrc
    so ~/.gvimrc
endf

func! IDEify()
    set columns=260
    set lines=100
    vsplit
    cope
    TagbarToggle
    execute "normal! \<C-w>="
endf

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

noremap <C-b> :CtrlPBuffer<cr>
inoremap <C-b> <esc>:CtrlPBuffer<cr>
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
noremap <F4> :YcmCompleter GoToDefinition<cr>
inoremap <F4> <esc>:YcmCompleter GoToDefinition<cr>

let g:Powerline_symbols="fancy"

" better tag jump
noremap ,g g<C-]>
inoremap ,g g<C-]>

"Make
noremap <F5> :make<cr>
inoremap <F5> <esc>:make<cr>
noremap <F6> :cn<cr>
inoremap <F6> <esc>:cn<cr>
noremap <F7> :grep <C-r><C-w><cr>
inoremap <F7> :grep <C-r><C-w><cr>
set makeprg=make\ -j8

func! UseGitGrep()
    set grepprg=git\ grep\ -n\ $*
endf
func! UseGrep()
    set grepprg=grep\ -n\ $*\ /dev/null
endf
" call UseGitGrep()
set grepprg=ack\ --type=cpp

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
" ----- Python
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
let g:syntastic_python_checkers = []
" ----- Haskell
au FileType haskell nnoremap <buffer> <F7> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F8> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F9> :HdevtoolsInfo<CR>

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

