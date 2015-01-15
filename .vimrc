filetype on
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
Plugin 'tpope/vim-commentary'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-speeddating'
Plugin 'surround.vim'
Plugin 'godlygeek/tabular'
Plugin 'TagHighlight'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'YankRing.vim'
Plugin 'justinmk/vim-gtfo'

"==== IDE stuff
Plugin 'a.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'Shougo/neocomplete.vim'
"... Random lang support
Plugin 'beyondmarc/glsl.vim'
Plugin 'petRUShka/vim-opencl'
Plugin 'tpope/vim-markdown'
"... Latex crap
" Plugin 'git://git.code.sf.net/p/vim-latex/vim-latex'

"==== Rainbows
Plugin 'chriskempson/base16-vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'lsdr/monokai'
Plugin 'jnurmine/Zenburn.git'
Plugin 'reedes/vim-colors-pencil'

call vundle#end()


set backspace=2
set history=1024  " Lines of history
filetype plugin on
filetype indent on

if has('win32')
    let $TMP="C:/tmp" " This should exist...
    set shellslash
endif

set autoread  " Reload when I modify the file elsewhere.

syntax on

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

au BufNewFile,BufRead *.glsl set filetype=glsl430
au BufNewFile,BufRead *.cl set filetype=opencl

au BufNewFile * set ff=unix

" Hide buffers, don't close them
set hidden

set nobackup
set nowritebackup

set wildmenu " command line completion
set nonumber  " don't show line numbers

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

" Pretty syntax.
function! Index()
    silent ! ctags -R .
    UpdateTypesFile
    ClearCtrlPCache
endfunction

" Personal log
func! OpenLog()
    e ~/Dropbox/log.txt
endf

" Highlight current line.
set cursorline

set hlsearch
" clear highlight with C-k or enter
nnoremap <C-k> :noh<cr><cr>
nnoremap <CR> :noh<cr><cr>
set incsearch
set ignorecase
set smartcase

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

set nobackup
set noswapfile

set nocompatible
set laststatus=2 "Always display status line
set encoding=utf-8
set cmdheight=2 " avoid hit-enter promts

"Auto-Pairs config
let g:AutoPairsFlyMode=0

noremap <F2> :NERDTreeToggle<cr>
let g:ctrlp_working_path_mode = 0

" Called at vim startup
function! SetDayColor()
python << EOF
import vim, time
hour = time.localtime().tm_hour
if hour >= 15 or hour < 8:
    vim.command("set background=dark\n")
else:
    vim.command("set background=light\n")
EOF
endfunction

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

" Change directory to current file.
nmap <leader>d :cd %:p:h<cr>

" Ctrl-w is cumbersome
noremap <leader>w <C-w>

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
noremap <F10> :botright cope<cr>
inoremap <F10> :botright cope<cr>
noremap <S-F10> :cclose<cr>
inoremap <S-F10> :cclose<cr>

" Don't mess with my window. Use buffer in already open tab. Otherwise, split
set switchbuf+=usetab,split

set makeprg=build

func! UseGitGrep()
    set grepprg=git\ grep\ -n\ $*
endf
func! UseGrep()
    set grepprg=grep\ -n\ $*\ /dev/null
endf

" C++ style
set colorcolumn=81,101
" No namespace indent, no indent for case, unindent label block, no indent for
" public, private in classes
set cino=N-s,:0,l1,g0

au BufNewFile,BufRead cpp set filetype=cpp

" Quickfix window variable Height
au FileType qf call AdjustWindowHeight(3, 20)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

map <f3> :TagbarToggle<CR>
map <C-l> :TagbarOpenAutoClose<CR>/
let g:tagbar_sort = 0

"  ======= neocomplete
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#force_omni_input_patterns')
let g:neocomplete#force_omni_input_patterns = {}
endif
