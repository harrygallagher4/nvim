" browse directory of current file with '-'
" nnoremap <silent> - :silent call lf#pick(expand('%:p:h'))<cr>
" nnoremap <silent> _ :silent call lf#pick(getcwd())<cr>

" use ctrl-j/k to navigate completion/etc
" noremap! <expr> <c-j> pumvisible() ? "\<c-n>" : "\<c-j>"
" noremap! <expr> <c-k> pumvisible() ? "\<c-p>" : "\<c-k>"

" nnoremap <leader>w      :update<cr>
" nnoremap <leader><tab>  :buffer #<cr>

" use H and L for start/end of line because ^/$
" are backwards and annoying to reach
" noremap H ^
" noremap L $
" noremap ; :
" nnoremap <leader>, :e ~/.config/nvim/lua/plugins/spec.lua<cr>
" nnoremap <leader>cd :cd %:h<cr>:pwd<cr>

" noremap <Plug>(Luadev-RunFile) <cmd>lua require'luadev'.exec(table.concat(vim.api.nvim_buf_get_lines(0,0,-1,false),"\n"))<cr>
" nmap <leader>lr         <Plug>(Luadev-RunLine)
" nmap <leader>la         <Plug>(Luadev-RunFile)
" nmap <leader><leader>l  <Plug>(Luadev-RunWord)
" vmap <leader>lr         <Plug>(Luadev-Run)
" <leader>lm is telescope module reloader

" nmap <leader>/          <Plug>CommentaryLine
" nmap <leader><leader>/  <Plug>Commentary<Plug>Commentary
" nmap <leader>?          <Plug>Commentary
" xmap <leader>/          <Plug>Commentary
" omap <leader>/          <Plug>Commentary

" tnoremap <a-\>      <c-\><c-n>
" tnoremap <c-w>h     <cmd>wincmd h<cr>
" tnoremap <c-w><c-h> <cmd>wincmd h<cr>
" tnoremap <c-w>j     <cmd>wincmd j<cr>
" tnoremap <c-w><c-j> <cmd>wincmd j<cr>
" tnoremap <c-w>k     <cmd>wincmd k<cr>
" tnoremap <c-w><c-k> <cmd>wincmd k<cr>
" tnoremap <c-w>l     <cmd>wincmd l<cr>
" tnoremap <c-w><c-l> <cmd>wincmd l<cr>
" tnoremap <c-w>s     <cmd>wincmd s<cr>
" tnoremap <c-w><c-s> <cmd>wincmd s<cr>
" tnoremap <c-w>v     <cmd>wincmd v<cr>
" tnoremap <c-w><c-v> <cmd>wincmd v<cr>
" tnoremap <c-w>c     <cmd>wincmd c<cr>
" tnoremap <c-w><c-c> <cmd>wincmd c<cr>

" command! PackerSync lua require('plugins.spec').sync()

command! -nargs=* LuaTestCommand
      \ lua print(vim.inspect({
          \ line1=<q-line1>,
          \ line2=<q-line2>,
          \ range=<q-range>,
          \ count=<q-count>,
          \ bang=<q-bang>,
          \ mods=<q-mods>,
          \ reg=<q-reg>,
          \ args={<f-args>}}))

