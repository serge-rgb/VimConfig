filetype on
set nocompatible

" Setup notes:
"   (git should be installed)
"   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"   or (windows): (needs curl script. see vundle site.)
"   git clone https://github.com/gmarik/Vundle.vim.git ~/vimfiles/bundle/Vundle.vim

if has("win32")
    set rtp+=~/vimfiles/bundle/Vundle.vim
else
    if has("unix")
        set rtp+=~/.vim/bundle/Vundle.vim/
    endif
endif


if has('win32')
    " Win64:
    " veegee vim.
    " LuaBinaries.sf.net, download x64 dll into vim74 dir.
    let path='~/vimfiles/bundle'
    call vundle#begin(path)
else
    call vundle#begin()
endif

Plugin 'gmarik/Vundle.vim'

"==== Vim editing steroids
Plugin 'Auto-Pairs'
Plugin 'bling/vim-airline'
Plugin 'godlygeek/tabular'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'justinmk/vim-gtfo'
Plugin 'surround.vim'
Plugin 'tpope/vim-capslock'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'  " :help unimpaired
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sleuth'   " Auto-set indentation settings
Plugin 'tpope/vim-speeddating'
Plugin 'YankRing.vim'

"==== IDE stuff
Plugin 'a.vim'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'abudden/taghighlight-automirror'
"... Random lang support
Plugin 'beyondmarc/glsl.vim'
Plugin 'tpope/vim-markdown'
" Plugin 'petRUShka/vim-opencl'
" Plugin 'raichoo/haskell-vim'

"==== Rainbows
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn.git'
Plugin 'chriskempson/base16-vim'
" Plugin 'reedes/vim-colors-pencil'
" Plugin 'tomasr/molokai'
" Plugin 'zefei/vim-colortuner'


call vundle#end()


set backspace=2
set history=1024  " Lines of history
filetype plugin on
filetype indent on

set shellslash   " Always forward slashes.

set autoread  " Reload when I modify the file elsewhere.

syntax on

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

au BufNewFile,BufRead *.glsl set filetype=glsl430
au BufNewFile,BufRead *.cl set filetype=opencl

" au BufNewFile * set ff=unix

" Hide buffers, don't close them
set hidden

set nobackup
set nowritebackup

set wildmenu " command line completion
set nonumber  " don't show line numbers
"set relativenumber  " show line numbers realtive to cursor.

" For writing prose
function! LongLines()
    set wrap
    set linebreak
    set nolist
    set textwidth=0
    set wrapmargin=0
    set colorcolumn=0
    "Remap j and k to be visual
    noremap j gj
    noremap k gk
endfunction
" Formats where LongLines gets called automatically.
" au BufNewFile,BufRead *.txt call LongLines()
" au BufNewFile,BufRead *.md call LongLines()
" au BufNewFile,BufRead *.lex call LongLines()
" au BufNewFile,BufRead *.tex cal LongLines()

" Pretty syntax.
function! Index()
    silent ! ctags -R .
    ClearCtrlPCache
    CtrlPClearCache
    :UpdateTypesFile
endfunction

" Personal log
func! OpenLog()
    e ~/Dropbox/log.txt
    cd ~/Dropbox/txt
    if has("gui_running")
      set columns=53
    endif
    cal LongLines()
endf

" Called at vim startup
function! SetDayColor()
python << EOF
import vim, time
hour = time.localtime().tm_hour
if hour < 8 or hour >= 17:
    vim.command("set background=dark\n")
else:
    vim.command("set background=light\n")
EOF
endfunction

cal SetDayColor()  " Call it at startup.

function! Maximize()
    if has("gui_running") && has('win32')
        simalt ~x
    endif
    " TODO: linux & max
endfunction

" Highlight current line.
set cursorline

set hlsearch
" clear highlight with C-k or enter
nnoremap <C-k> :noh<cr><cr>
nnoremap <CR> :noh<cr><cr>
set incsearch
set ignorecase
set smartcase

set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4

set nobackup
set noswapfile

set laststatus=2 "Always display status line
set encoding=utf-8
set cmdheight=2 " avoid hit-enter promts

"Auto-Pairs config
let g:AutoPairsFlyMode=0

noremap <F2> :NERDTreeToggle<cr>
let g:ctrlp_working_path_mode = 0

" Set vim-colortuner config to persist in Dropbox folder.
let g:colortuner_filepath = '~/_vim-colortuner'

let mapleader=','

" Remapping for YankRing
let g:yankring_replace_n_pkey = "<leader>p"
let g:yankring_replace_n_nkey = "<leader>n"

" CtrlP config.
noremap <leader>b :CtrlPBuffer<cr>
inoremap <leader>b <esc>:CtrlPBuffer<cr>

" Better than esc. (go to normal mode and save)
inoremap jj <esc>:w<cr>
" Go to the end while in insert mode
inoremap ,, <esc>A
" Saving
noremap <leader>s :w<cr>

" Swap Header/Impl
noremap <C-Tab> :A<cr>
inoremap <C-Tab> <esc>:A<cr>

" Ctrl-w is cumbersome
noremap <leader>w <C-w>

" Vim has Alt mapping bugs. Change autopair
noremap <C-space> <esc>:call AutoPairsJump()<cr>
inoremap <C-space> <esc>:call AutoPairsJump()<cr>

" ==== Insert mode mappings.
" Emacs style
inoremap <C-e> <esc>A
inoremap <C-a> <esc>I
inoremap <C-k> <esc>d$I

" Sane stuf
inoremap <C-BS> <C-W>

" ==== Text edit improvements

" make word Capitalized
noremap <leader>u ebgUl
" make word UPPERCASE
noremap <leader>U gUiw
" I can never find $ and ^
noremap <leader>e $
noremap <leader>a ^

" better tag jump
noremap <leader>g g<C-]>
inoremap <leader>g g<C-]>

"Make
imap <F1> <esc>
nmap <F1> <esc>
noremap <F5> :wa<esc>:make<cr><cr>:botright cw<cr>
inoremap <F5> <esc>:wa<cr>:make<cr><cr>:botright cw<cr>
noremap <F6> :cn<cr>
inoremap <F6> <esc>:cn<cr>
" Silver Searcher
" -U ignores .gitignore et al. Should have .agignore to filter crap
let g:ackprg = 'ag --nocolor --column -U'
noremap <F7> :Ack <C-r><C-w><cr>
inoremap <F7> :Ack <C-r><C-w><cr>
" Go through errors in cwind
noremap <F8> :cnext<cr>
noremap <F9> :crewind<cr>
inoremap <F8> :cnext<cr>
inoremap <F9> :crewind<cr>
" Open/close quickfix window
noremap <F10> :botright cope<cr>
inoremap <F10> :botright cope<cr>
noremap <S-F10> :cclose<cr>
inoremap <S-F10> :cclose<cr>
" Show definition in another window
imap <F12> <leader>w<C-]>
nmap <F12> <leader>w<C-]>

" Don't mess with my window. Use buffer in already open tab. Otherwise, split
set switchbuf+=usetab

func! UseGitGrep()
    set grepprg=git\ grep\ -n\ $*
endf
func! UseGrep()
    set grepprg=grep\ -n\ $*\ /dev/null
endf

set tags=./tags;

" C++ style
"set colorcolumn=81,101
set colorcolumn=101
" No namespace indent, no indent for case, unindent label block, no indent for
" public, private in classes, no indent inside if/func parameters, extra
" indent for expression newlines
set cino=N-s,:0,l1,g0,(0,+8

"Crazy C stuff

au BufNewFile,BufRead *.cpp,*.cc    set filetype=cpp
au BufNewFile,BufRead *.cpp,*.cc    set makeprg=build
au BufNewFile,BufRead *.c,*.h       set makeprg=build

" Haskell stuff
au BufNewFile,BufRead *.hs set makeprg=cabal\ build

syntax keyword Type uint8
" Quickfix window variable Height
au FileType qf call AdjustWindowHeight(3, 20)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction


" Supertab. Go from top to bottom
let g:SuperTabDefaultCompletionType = "<c-n>"

map <f3> :TagbarToggle<CR>
map <C-l> :TagbarOpenAutoClose<CR>/
let g:tagbar_sort = 0

" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

