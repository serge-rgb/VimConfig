if has("gui_running")
    set lines=60 columns=120
    set guioptions-=T "No toolbar
    " Remove scrobars:
    set guioptions-=r
    set guioptions-=L
    " No menu
    set guioptions-=m
    " No bells
    "
    set noerrorbells
    set novisualbell
    set t_vb=
    autocmd! GUIEnter * set vb t_vb=


    " Tagbar signature highlighting sucks
    hi link TagbarSignature Statement

    " colorscheme zenburn
    " colorscheme solarized
    let g:molokai_original=1
    " colorscheme molokai
    " colorscheme pencil
    colorscheme base16-google

    " some themes set column highlight to ugly colors

    " set background=dark
    " set background=light

    map <M-o> :CommandT<CR>
    if has("win32")
        set guifont=Consolas:h10
        set enc=utf-8
    else
        if has("unix")
            if has("macunix")
                set guifont=Monaco:h11
            else
                set guifont=Ubuntu\ Mono\ 12
                " set guifont=DejaVu\ Sans\ Mono\ 10
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
