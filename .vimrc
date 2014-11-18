filetype on  " Yep..
filetype off
if has("win32")
    set rtp+=~/vimfiles/bundle/Vundle.vim
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
Bundle 'justinmk/vim-gtfo'

"==== Completion / IDE stuff
" Bundle "scrooloose/syntastic"
" Bundle "Valloric/YouCompleteMe"
" Bundle "Rip-Rip/clang_complete"
Bundle "Shougo/neocomplete"
Bundle 'a.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'SirVer/ultisnips'
"... Random lang support
" Bundle 'Blackrush/vim-gocode'
Bundle 'beyondmarc/glsl.vim'
Bundle 'petRUShka/vim-opencl'
" Bundle 'kelan/gyp.vim'
Bundle 'tpope/vim-markdown'
" Bundle 'wting/rust.vim'
" Bundle 'vim-scripts/slimv.vim'
" Bundle 'bitc/vim-hdevtools'
" Bundle 'lukerandall/haskellmode-vim'
"... Latex crap
" Bundle 'git://git.code.sf.net/p/vim-latex/vim-latex'

"==== Rainbows
Bundle 'chriskempson/base16-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'lsdr/monokai'
Bundle 'jnurmine/Zenburn.git'
Bundle 'reedes/vim-colors-pencil'

"==== Other
" Bundle 'mhinz/vim-startify'

set backspace=2
set history=1024  " Lines of history
filetype plugin on
filetype indent on

let $TMP="C:/tmp"

" No bells
"
set noerrorbells
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=

set autoread  " Reload when I modify the file elsewhere.

syntax on

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

au BufNewFile,BufRead *.glsl set filetype=glsl430
au BufNewFile,BufRead *.cl set filetype=opencl

au BufNewFile * set ff=unix

" Hide buffers, don't close them
set hidden

set shellslash

set nobackup
set nowritebackup

set wildmenu
set number  "Show lines
set nonumber  " actually, don't show lines

" Very magic search
nnoremap / /\v

function! LongLines()
    set wrap
    set linebreak
    set nolist
    set textwidth=0
    set wrapmargin=0
    set colorcolumn=0
endfunction

function! Index()
    !ctags -R .
    UpdateTypesFile
    ClearAllCtrlPCaches
endfunction

" Personal log helpers...
func! OpenLog()
    e ~/Dropbox/log.txt
endf

func! LoadRC()
    so ~/.vimrc
    so ~/.gvimrc
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

set nocompatible
set laststatus=2 "Always display status line
set encoding=utf-8
set cmdheight=2 " avoid hit-enter promts

"Remap j and k to be visual
noremap j gj
noremap k gk

"Auto-Pairs config
let g:AutoPairsFlyMode=0

noremap <C-b> :CtrlPBuffer<cr>
inoremap <C-b> <esc>:CtrlPBuffer<cr>
noremap <F2> :NERDTreeToggle<cr>

let g:ctrlp_working_path_mode = 0

function! SetDayColor()
python << EOF
import vim, time
hour = time.localtime().tm_hour
if hour >= 18 or hour < 8:
    vim.command("set background=dark\n")
else:
    vim.command("set background=light\n")
EOF
endfunction
"call SetDayColor()

" Remapping for YankRing
let g:yankring_replace_n_pkey = ",p"
let g:yankring_replace_n_nkey = ",n"

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

" Change directory to current file.
nmap <leader>d :cd %:p:h<cr>

let g:Powerline_symbols="fancy"

" better tag jump
noremap ,g g<C-]>
inoremap ,g g<C-]>

"Make
noremap <F5> :w<esc>:make<cr><cr>:botright cw<cr>
inoremap <F5> <esc>:w<cr>:make<cr><cr>:botright cw<cr>
noremap <F6> :cn<cr>
inoremap <F6> <esc>:cn<cr>
" Grep instances of word at point:
noremap <F7> :grep <C-r><C-w><cr>
inoremap <F7> :grep <C-r><C-w><cr>
" Go through errors in cwind
noremap <F8> :cnext<cr>
noremap <F9> :crewind<cr>
inoremap <F8> :cnext<cr>
inoremap <F9> :crewind<cr>
noremap <F10> :botright cope<cr>
inoremap <F10> :botright cope<cr>
noremap <S-F10> :cclose<cr>
inoremap <S-F10> :cclose<cr>

set makeprg=build

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
au FileType qf call AdjustWindowHeight(3, 20)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
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
map <C-l> :TagbarOpenAutoClose<CR>/
let g:tagbar_sort = 0

"  ======= neocomplete
"
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
" let g:neocomplete#force_overwrite_completefunc = 1
" let g:neocomplete#force_omni_input_patterns.c =
" \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
" let g:neocomplete#force_omni_input_patterns.cpp =
" \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
" let g:neocomplete#force_omni_input_patterns.objc =
" \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)'
" let g:neocomplete#force_omni_input_patterns.objcpp =
" \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)\|\h\w*::\w*'

