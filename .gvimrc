if has("gui_running")
    set lines=80 columns=120
    set guioptions-=T
    let g:molokai_original=1

    " Tagbar signature highliting sucks
    hi link TagbarSignature Statement

    colorscheme solarized
    " colorscheme Gloom
    " colorscheme Earthsong
    " colorscheme Goldfish
    " colorscheme zenburn
    " colorscheme molokai

    map <M-o> :CommandT<CR>
    if has("win32")
        set guifont=Consolas:h10:cANSI
    else
        if has("unix")
            if has("macunix")
                set guifont=Monaco:h11
            else
                " set guifont=Ubuntu\ Mono\ 11
                set guifont=DejaVu\ Sans\ Mono\ 10
            endif
        endif
    endif
endif

if has("gui_macvim")
    macm File.Open\.\.\. key=<nop>
    macmenu &File.New\ Tab key=<nop>
    map <D-o> :CommandT<CR>
endif

