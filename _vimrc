set nocompatible
filetype on  " Yep..
filetype off
if has("win32")
    set rtp+=~/vimfiles/bundle/vundle
    set backspace=2
else
    if has("unix")
        set rtp+=~/.vim/bundle/vundle/
    endif
endif

call vundle#rc()

Bundle "gmarik/vundle"

" My bundles
Bundle "a.vim"
Bundle "Auto-Pairs"
Bundle "surround.vim"
Bundle "YankRing.vim"

Bundle "majutsushi/tagbar"
Bundle "kien/ctrlp.vim"
Bundle "scrooloose/nerdcommenter"
"Bundle "scrooloose/syntastic"
"Bundle "Valloric/YouCompleteMe"
Bundle "vim-scripts/OmniCppComplete"
Bundle "vim-scripts/AutoComplPop"
Bundle "altercation/vim-colors-solarized"
Bundle "kelan/gyp.vim"
Bundle "godlygeek/tabular"
Bundle "jnurmine/Zenburn.git"
Bundle "sunnogo/vim-taghighlight"
Bundle "SirVer/ultisnips"
Bundle "tpope/vim-repeat"
Bundle "Lokaltog/vim-powerline"
Bundle "beyondmarc/glsl.vim"

set history=1024  " Lines of history
filetype plugin on
filetype indent on

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
set wrap
set number
" Very magic search
nnoremap / /\v

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

noremap <C-t> :CtrlPBuffer<cr>
inoremap <C-t> <esc>:CtrlPBuffer<cr>
noremap <C-3> :CtrlPMRU<cr>
noremap <C-3> <esc>:CtrlPMRU<cr>

let g:ctrlp_working_path_mode = 0

" Remapping for YankRing
let g:yankring_replace_n_pkey = ",p"
let g:yankring_replace_n_nkey = ",n"

" Better than esc.
inoremap jj <esc>
" Go to the end while in insert mode
inoremap ,, <esc>A
" Saving
map <leader>s :w<cr>
nmap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>
noremap <C-Tab> :A<cr>
inoremap <C-Tab> <esc>:A<cr>

" Move between functions
noremap <leader>e ]}

" Change directory to current file.
nmap <leader>d :cd %:p:h<cr>

let g:Powerline_symbols="fancy"

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

map <f3> :TagbarToggle<CR>
map <C-l> :TagbarOpen fj<CR>
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

" List installed pathogen bundles
function! ListBundles()
python << EOF
import glob
for d in glob.glob("/Users/sglez/.vim/bundle/*"):
    print d.split("/")[5]
EOF
endfunction
