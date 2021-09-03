setlocal signcolumn=yes:1

augroup harryg_help
    autocmd! 
    au BufEnter */share/nvim/runtime/doc/*.txt setlocal virtualedit=all
    au BufLeave */share/nvim/runtime/doc/*.txt setlocal virtualedit=block,insert
augroup END

