set encoding=utf8
let mapleader = "\<Space>"

augroup harryg
    autocmd!
    autocmd ColorScheme * highlight CursorLine guibg=NONE
    " autocmd BufWritePost plugins.lua PackerCompile
augroup END


set backupdir=~/.config/nvim/.backup
set directory=~/.config/nvim/.backup
set undodir=~/.config/nvim/.undofiles
set undofile
set nobackup
set writebackup

set autoread
set backspace=indent,eol,start
set cursorline
set fillchars=eob:\ 
set hidden
set hlsearch
set ignorecase
set incsearch
set inccommand=nosplit
set linebreak
set list
set mouse=a
set noequalalways
set nowrap
set number
set pumheight=8
set scrolloff=3
set showcmd
set signcolumn=number
set smartcase
set smarttab
set splitbelow
set splitright
set wildmenu
set wildmode=longest,full
set wildoptions=pum

set foldlevelstart=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set completeopt=menuone,noinsert,noselect
set shortmess+=c

let $FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS . ' --margin=0,0'

" browse directory of current file with '-'
nnoremap <silent> - :silent call lf#pick(expand('%:p:h'))<cr>
nnoremap <silent> _ :silent call lf#pick(getcwd())<cr>


" use ctrl-j/k to navigate completion/etc
noremap! <expr> <c-j> pumvisible() ? "\<c-n>" : "\<c-j>"
noremap! <expr> <c-k> pumvisible() ? "\<c-p>" : "\<c-k>"


nnoremap <leader>w      :update<cr>
nnoremap <leader><tab>  :buffer #<cr>


" use H and L for start/end of line because ^/$
" are backwards and annoying to reach
noremap H ^
noremap L $
noremap ; :
nnoremap <leader>, :e ~/.config/nvim/lua/plugins/spec.lua<cr>
nnoremap <leader>cd :cd %:h<cr>:pwd<cr>


noremap <Plug>(Luadev-RunFile) <cmd>lua require'luadev'.exec(table.concat(vim.api.nvim_buf_get_lines(0,0,-1,false),"\n"))<cr>
nmap <leader>lr         <Plug>(Luadev-RunLine)
nmap <leader>la         <Plug>(Luadev-RunFile)
nmap <leader><leader>l  <Plug>(Luadev-RunWord)
vmap <leader>lr         <Plug>(Luadev-Run)
" <leader>lm is telescope module reloader


nmap <leader>/          <Plug>CommentaryLine
nmap <leader><leader>/  <Plug>Commentary<Plug>Commentary
nmap <leader>?          <Plug>Commentary
xmap <leader>/          <Plug>Commentary
omap <leader>/          <Plug>Commentary


inoremap <silent><expr> <C-Space>   compe#complete()
inoremap <silent><expr> <cr>        compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
inoremap <silent><expr> <esc>       pumvisible() ? compe#close('<esc>') : "<esc>"
imap     <silent><expr> <bs>        pumvisible() ? compe#close() : "\<Plug>delimitMateBS"
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

tnoremap <a-\>      <c-\><c-n>
tnoremap <c-w>h     <cmd>wincmd h<cr>
tnoremap <c-w><c-h> <cmd>wincmd h<cr>
tnoremap <c-w>j     <cmd>wincmd j<cr>
tnoremap <c-w><c-j> <cmd>wincmd j<cr>
tnoremap <c-w>k     <cmd>wincmd k<cr>
tnoremap <c-w><c-k> <cmd>wincmd k<cr>
tnoremap <c-w>l     <cmd>wincmd l<cr>
tnoremap <c-w><c-l> <cmd>wincmd l<cr>
tnoremap <c-w>s     <cmd>wincmd s<cr>
tnoremap <c-w><c-s> <cmd>wincmd s<cr>
tnoremap <c-w>v     <cmd>wincmd v<cr>
tnoremap <c-w><c-v> <cmd>wincmd v<cr>
tnoremap <c-w>c     <cmd>wincmd c<cr>
tnoremap <c-w><c-c> <cmd>wincmd c<cr>

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

