" base16 syntax:
" g:Base16hi(group, guifg, guibg, ctermfg, ctermbg, gui, guisp)
"
" colors are 'g:base16_gui00' etc.
"

" defaults
"              group            guifg    guibg    ctermfg    ctermbg    guiattr  guisp
" call <sid>hi("StatusLine",    s:gui04, s:gui02, s:cterm04, s:cterm02, "none",  ""   )
" call <sid>hi("StatusLineNC",  s:gui03, s:gui01, s:cterm03, s:cterm01, "none",  ""   )
" call <sid>hi("VertSplit",     s:gui02, s:gui02, s:cterm02, s:cterm02, "none",  ""   )
" 

function harryg#colors#base16()
    call g:Base16hi("VertSplit", g:base16_gui01, "none", "", "", "bold", "")
    call g:Base16hi("StatusLine", "", "none", "", "", "", "")
    call g:Base16hi("StatusLineNC", "", "none", "", "", "", "")
    call g:Base16hi("MatchParen", "", g:base16_gui02, "", "", "bold", "")
    call g:Base16hi("EndOfBuffer", g:base16_gui00, g:base16_gui00, "", "", "", "")
    call g:Base16hi("Cursor", g:base16_gui00, g:base16_gui04, "", "", "", "")
    call g:Base16hi("CursorLineNr", g:base16_gui05, "", "", "", "italic", "")

    highlight clear CursorLine
    highlight CursorLineNr guibg=NONE
    highlight LineNr guibg=NONE gui=italic
    highlight SignColumn guibg=NONE
endfunction

function harryg#colors#gruvbox()
    if exists("g:fzf_colors")
        unlet g:fzf_colors['bg']
    endif
    highlight LineNr guibg=NONE
    highlight SignColumn guibg=NONE
    highlight CursorLine guibg=NONE
    highlight CursorLineNr guibg=NONE
endfunction



function harryg#colors#customize(match)

    if stridx(a:match, "base16") >= 0
        let l:match = "base16"
    else
        let l:match = a:match
    endif

    let l:handlers = {
        \ 'gruvbox': function("harryg#colors#gruvbox"),
        \ 'base16': function("harryg#colors#base16")
    \ }


    if has_key(l:handlers, l:match)
        let Handler = l:handlers[l:match]
        call Handler()
    else
        for key in keys(l:handlers)
            if l:match =~ key
                let Handler = l:handlers[key]
                call Handler()
            endif
        endfor
    endif

endfunction

