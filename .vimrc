filetype on
set nocompatible

" Setup notes:
"   (git should be installed)
"   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"   or (windows): (needs curl script. see vundle site.)
"   git clone https://github.com/gmarik/Vundle.vim.git ~/vimfiles/bundle/Vundle.vim

if has("win32")
    set rtp+=~/vimfiles/bundle/Vundle.vim
elseif has("unix")
    set rtp+=~/.vim/bundle/Vundle.vim/
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
Plugin 'godlygeek/tabular'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'junegunn/goyo.vim'
Plugin 'justinmk/vim-gtfo'
"Plugin 'spolu/dwm.vim'
Plugin 'surround.vim'
Plugin 'tpope/vim-capslock'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'  " :help unimpaired
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-speeddating'
Plugin 'vim-airline/vim-airline'
Plugin 'YankRing.vim'

"==== IDE stuff
Plugin 'a.vim'
"Plugin 'abudden/taghighlight-automirror'
Plugin 'ervandew/supertab'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
"Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'

"==== Random lang support
Plugin 'beyondmarc/glsl.vim'
Plugin 'tpope/vim-markdown'
Plugin 'petRUShka/vim-opencl'
Plugin 'PProvost/vim-ps1'
" Plugin 'raichoo/haskell-vim'

"==== Rainbows
Plugin 'jaxbot/semantic-highlight.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
Plugin 'jnurmine/Zenburn.git'
Plugin 'reedes/vim-colors-pencil'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/louver.vim'
" Plugin 'zefei/vim-colortuner'


call vundle#end()



" ============================================================
" ==== Sane vim defaults  ====
" ============================================================


let mapleader=','
" Remap \ as , for an extra leader
nmap \ ,


syntax on
set backspace=2
set history=1024    " Lines of history
filetype plugin on
filetype indent on
set shellslash      " Always forward slashes.
set autoread        " Reload when I modify the file elsewhere.
set cursorline      " Highlight current line.

" search ---
set hlsearch
" clear highlight with return
nnoremap <CR> :noh<cr><cr>
set incsearch
set ignorecase
set smartcase

" Hide buffers, don't close them
set hidden
set nobackup
set nowritebackup
set noswapfile
set wildmenu        " command line completion
set laststatus=2    "Always display status line
set encoding=utf-8
set cmdheight=2     " avoid hit-enter promts
" Don't mess with my window. Use buffer in already open tab. Otherwise, split
set switchbuf+=usetab


" Statusline with fugitive info
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Mostly using the preview window for Fugitive Git status
set previewheight=20

" I don't want wrapping unless i'm writing prose
set nowrap

" Ctrl-w is cumbersome
noremap <leader>w <C-w>
" Move window to the right
noremap <leader>r <C-w><C-r>
" Switch betweeen windows
noremap <A-Left>    <C-w>h
noremap <A-Right>   <C-w>l
noremap <A-Up>      <C-w>k
noremap <A-Down>    <C-w>j
" Close
noremap <A-.>       <C-w>c
" Splits
noremap <A-s>       <C-w>s
noremap <A-v>       <C-w>v
noremap <A-i>       <C-w>v
" Only
noremap <A-o>       <C-w>o

noremap <A-h>    <C-w>h
noremap <A-l>   <C-w>l
noremap <A-k>      <C-w>k
noremap <A-j>    <C-w>j



" ============================================================
" ==== Text edit remaps ====
" ============================================================



" F4 for repeat macro
noremap <F4> @@
" Better than esc. (go to normal mode and save)
inoremap jj <esc>:w<cr>
inoremap kj <esc>:w<cr>
" Saving
noremap <leader>s :w<cr>
" Swap Header/Impl
noremap <C-Tab> :A<cr>
inoremap <C-Tab> <esc>:A<cr>
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
" Tabular plugin common case
noremap <leader>t :Tabular /=<cr>

" Insert mode ---
" ... Emacs style
inoremap <C-e> <esc>A
inoremap <C-a> <esc>I
inoremap <C-k> <esc>d$A
" Ctrl-Backspace should kill a word..
inoremap <C-BS> <C-W>

" Format paragraph
noremap <leader>q gqip



" ============================================================
" ==== Functions ====
" ============================================================



" Global function to make LongLines do nothing
let g:no_longlines=0 ""
" For writing prose
function! LongLines()
    if !g:no_longlines
        set wrap
        set linebreak
        set nolist
        set textwidth=0
        set wrapmargin=0
        set colorcolumn=0
        set columns=90
        set lines=60
        "Remap j and k to be visual
        noremap j gj
        noremap k gk
        if has('win32')
            set guifont=DejaVu_Sans_Mono:h11
        endif
        if has('unix')
            if has("macunix")
                set guifont=Monaco:h13
            else
                set guifont=DejaVu\ Sans\ Mono\ 12
            endif
        endif
    endif
endfunction

" Ctags + update tag highlighting
function! Index()
    silent ! ctags -R .
    :UpdateTypesFile
endfunction

" Text directory
func! GotoText()
    cd ~/Dropbox/txt
    cal LongLines()
endf

" Personal log
function! OpenLog()
    let g:no_longlines=1
    e ~/Dropbox/log.txt
    cd ~/Dropbox/txt
    if has("gui_running")
        set columns=53
    endif
endfunction

" Set the background based on the time.
function! SetDayColor()
python << EOF
import vim, time
hour = time.localtime().tm_hour
if hour <= 7 or hour >= 20:
    vim.command("set background=dark\n")
else:
    vim.command("set background=light\n")
EOF
endfunction


function! SergeCStyle()
    " C++ style
    " set colorcolumn=81,101
    " set colorcolumn=101
    " No namespace indent, no indent for case, unindent label block, no indent for
    " public, private in classes
    set cino=N-s,:0,l1,g0,(0,+8

    set expandtab
    set shiftwidth=4
    set tabstop=8
    set softtabstop=4
    " set colorcolumn=110
    "
    " " Common types
    " syn keyword sergeType u8 i8 u16 i16 u32 i32 u64 i64
    " syn keyword sergeType f32 f64
    " syn keyword sergeType b32
    " hi def link sergeType Type

    " Ctags Highlight plugin confuses colorschemes
    hi link Member Identifier

    " C++ remappings

    " Auto-indent when pasting
    "nnoremap p p=`]`]
endfunction

function! UseGitGrep()
    set grepprg=git\ grep\ -n\ $*
endfunction

function! UseGrep()
    set grepprg=grep\ -n\ $*\ /dev/null
endfunction



" ============================================================
" ==== Plugin Configuration ====
" ============================================================



" Auto-Pairs ---
let g:AutoPairsFlyMode=0

" NERDTree ---
noremap <F2> :NERDTreeToggle<cr>

" CtrlP  ---
let g:ctrlp_working_path_mode = 0
" CtrlP config.
noremap <leader>b :CtrlPBuffer<cr>
let g:ctrlp_cmd = 'CtrlPMRUFiles'

" YankRing --- Remapping
let g:yankring_replace_n_pkey = "<leader>p"
let g:yankring_replace_n_nkey = "<leader>n"


" Autopairs --- Jump outside of scope mapping
noremap <C-space> <esc>:call AutoPairsJump()<cr>
inoremap <C-space> <esc>:call AutoPairsJump()<cr>a

" Supertab --- Go from top to bottom
let g:SuperTabDefaultCompletionType = "<c-n>"

" Tagbar --- mappings
map <f3> :TagbarToggle<CR>
map <C-l> :TagbarOpenAutoClose<CR>/
let g:tagbar_sort = 0

" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Fugitive. Easy Git status
noremap <leader>d :Gstatus<cr>

" Easymotion mapping
map <space> <Plug>(easymotion-prefix)



" ============================================================
" ==== Quickfix window ====
" ============================================================



imap <F1> <esc>
nmap <F1> <esc>

noremap <F5> :wa<esc>:make<cr><cr>:botright cw<cr>
inoremap <F5> <esc>:wa<cr>:make<cr><cr>:botright cw<cr>

" Same for alt-b
noremap <A-b> :wa<esc>:make<cr><cr>:botright cw<cr>
inoremap <A-b> :wa<esc>:make<cr><cr>:botright cw<cr>

noremap <F6> :cn<cr>
inoremap <F6> <esc>:cn<cr>
" Silver Searcher
" Note: -U ignores .gitignore et al. Should have .agignore to filter crap
let g:ackprg = 'ag --nocolor --column'
noremap <F7> :Ack <C-r><C-w><cr>
noremap <C-F7> :Ack<space>
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
" Quickfix window variable Height
au FileType qf call AdjustWindowHeight(3, 20)
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction


set tags=./tags;



" ============================================================
" ==== File defaults (BufRead BufWrite etc) ====
" ============================================================



" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" filetypes ---
"au BufNewFile,BufRead *.glsl set filetype=glsl430
au BufNewFile,BufRead *.glsl set filetype=cpp
au BufNewFile,BufRead *.cl set filetype=opencl
au BufNewFile,BufRead *.cpp,*.cc,*.c,*.h,*.cl,*.glsl call SergeCStyle()
au BufNewFile,BufRead *.hs set makeprg=cabal\ build

" prose
let g:no_open_files=1
au BufNewFile,BufRead *.txt,*.md,*.html if g:no_open_files | cal LongLines() | endif
au BufNewFile,BufRead * let g:no_open_files=0

" Use semantic highlighting for code
"au BufNewFile,BufRead,BufEnter *.cpp,*.cc,*.c,*.h,*.cl,*.glsl,*.py,*.lua SemanticHighlight
"au BufNewFile,BufRead,BufEnter *.cpp,*.cc,*.c,*.h,*.cl,*.glsl,*.py,*.lua noremap <leader>s :w<cr>:SemanticHighlight<cr>

" au BufNewFile * set ff=unix


" ============================================================
" ==== GUI and Init ====
" ============================================================


let g:loop_function_int=0
function! LoopColorSchemes()
    if g:loop_function_int == 0
        colorscheme louver
    elseif g:loop_function_int == 1
        colorscheme zenburn
    elseif g:loop_function_int == 2
        colorscheme molokai
    " elseif g:loop_function_int == 3
    "     colorscheme solarized
    endif
    let g:loop_function_int=g:loop_function_int + 1
    let g:loop_function_int=g:loop_function_int % 3
endfunction

noremap <A-c> :call LoopColorSchemes()<cr>

function! InitVim()
    if has('win32')
        set makeprg=.\build.bat
        " set shell=powershell
        " set shellcmdflag=-c
        " set shellpipe=>
        " set shellredir=>
    elseif has('unix')
        set makeprg=make
        if has('macunix')
            set makeprg=./build_osx.sh
        endif
    endif

    if executable('ag')
        set grepprg=ag\ --nogroup\ --nocolor
    endif

    " Call this by default, but we are running vim-sleuth to work with other codebases
endfunction

function! InitVimGui()
    if has("gui_running")
        set lines=80 columns=150
        "set lines=80 columns=211
        set guioptions-=T "No toolbar
        " Remove scrobars:
        set guioptions-=r
        set guioptions-=L
        " No menu
        if has("unix")
            " Presumably on ubuntu, where the menu doesn't get in the way.
        else
            set guioptions-=m
        endif
        " No bells
        "
        set noerrorbells
        set novisualbell
        set t_vb=
        autocmd! GUIEnter * set vb t_vb=

        " Tagbar signature highlighting sucks
        hi link TagbarSignature Statement

        let g:molokai_original=1
        "colorscheme molokai
        "colorscheme zenburn
        "colorscheme solarized
        "colorscheme pencil
        "colorscheme base16-monokai
        "colorscheme default
        "set background=dark
        "colorscheme louver

        " Choose the first color scheme
        call LoopColorSchemes()

        " the default theme doesn't work right with split windows & light
        " themes
        AirlineTheme pencil

        if has("win32")
            set guifont=Consolas:h9
            "set guifont=DejaVu_Sans_Mono:h10:cANSI
            set enc=utf-8
        else
            if has("unix")
                if has("macunix")
                    set guifont=Monaco:h11
                    "set guifont=DejaVu_Sans_Mono:h11
                else
                    " set guifont=Ubuntu\ Mono\ 12
                    set guifont=DejaVu\ Sans\ Mono\ 10
                    " set guifont=Inconsolata\ Medium\ 9
                    "set guifont=Powerline\ Consolas\ 9
                    "set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 10
                endif
            endif
        endif

    endif

    if has("gui_macvim")
        macm File.Open\.\.\. key=<nop>
        macmenu &File.New\ Tab key=<nop>
        map <D-o> :CommandT<CR>
    endif
    "highlight ColorColumn guibg=Gray20
    "call SetDayColor()
endfunction

autocmd VimEnter * :call InitVim()
autocmd GuiEnter * :call InitVimGui()
