" vim: foldmethod=marker foldlevel=2

" vim-plug (ensure installed) {{{3
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

set termguicolors
set background=dark
let g:base16_shell_path = "~/Projects/base16/build/templates/shell"
let g:gruvbox_italic = 1
let g:gruvbox_improved_strings = 0
let g:gruvbox_improved_warnings = 1
let g:gruvbox_contrast_dark = 'soft'

" let g:conjure#client#fennel#aniseed#aniseed_module_prefix = "aniseed."

" vim-plug {{{1
call plug#begin('~/.config/nvim/plugins')

Plug '~/.config/nvim/localplugin'
Plug '~/Projects/base16/build/templates/vim'
"Plug '~/Projects/vim/gruvbox.vim'
"Plug 'christianchiarulli/nvcode-color-schemes.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
" Plug 'norcalli/snippets.nvim'
Plug 'nvim-lua/completion-nvim'

Plug 'nvim-treesitter/nvim-treesitter',
   \ {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

Plug 'Olical/conjure'
Plug 'Olical/aniseed'
Plug 'bakpakin/fennel.vim'

Plug 'datwaft/bubbly.nvim'

Plug 'eraserhd/parinfer-rust',
   \ {'do': 'cargo build --release'}

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Functionality
Plug 'editorconfig/editorconfig-vim'
Plug 'Raimondi/delimitMate'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-slash'
Plug 'khadegd/vim-lf'
Plug 'sbdchd/neoformat'
Plug 'fiatjaf/neuron.vim'

call plug#end()
" }}}

" fix vim-slash and snippets conflicting
function! FixSlash()
    vunmap n
    vunmap N
endfunction

augroup colorfix
    autocmd!
    autocmd ColorScheme * call harryg#colors#customize(expand("<amatch>"))
augroup END

augroup harryg
    autocmd!
    autocmd BufEnter * lua require'completion'.on_attach()
    autocmd VimEnter * call FixSlash()
augroup END

if filereadable(expand("~/.vimrc_background"))
    source ~/.vimrc_background
endif

let mapleader = "\<Space>"



set backupdir=~/.config/nvim/.backup
set directory=~/.config/nvim/.backup
set undodir=~/.config/nvim/.undofiles
set undofile
set nobackup
set writebackup

set autoread
set backspace=indent,eol,start
set cursorline
set hidden
set hlsearch
set ignorecase
set incsearch
set linebreak
set mouse=a
set noequalalways
set nowrap
set number
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

"---------------------------------------
" lua init
lua require('aniseed.env').init()

set completeopt=menuone,noinsert,noselect
set shortmess+=c
"
"---------------------------------------

let $FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS . ' --reverse --margin=0,0'

"let g:lf#replace_netrw = 1
"let g:lf#layout = { 'window': { 'width': 1.0, 'height': 0.5, 'highlight': 'Function', 'border': 'horizontal' } }

" browse directory of current file with '-'
nnoremap <silent> - :silent call lf#pick(expand('%:p:h'))<cr>
nnoremap <silent> _ :silent call lf#pick(getcwd())<cr>
"nnoremap <silent> <a--> :silent call lf#pick(getcwd())<cr>

" FZF 
nnoremap <silent> <leader>p :Files<cr>
nnoremap <silent> <leader>P :History<cr>
nnoremap <silent> <leader>o :Buffers<cr>
nnoremap <silent> <leader>t :Rg<cr>
nnoremap <silent> <leader>: :Commands<cr>
nnoremap <silent> <leader>; :History:<cr>
"nnoremap <silent> <leader>/ :Lines<cr>
"nnoremap <silent> <leader>? :BLines<cr>



" use ctrl-j/k to navigate completion/etc
noremap! <expr> <c-j> pumvisible() ? "\<c-n>" : "\<c-j>"
noremap! <expr> <c-k> pumvisible() ? "\<c-p>" : "\<c-k>"
imap <expr> <c-u> pumvisible() ? "\<Plug>(completion_prev_source)" : "\<c-u>"
imap <expr> <c-d> pumvisible() ? "\<Plug>(completion_next_source)" : "\<c-d>"

" inoremap <expr> <c-k> v:lua.harryg.map_k()

nnoremap <leader>w      :update<cr>
nnoremap <leader><tab>  :buffer #<cr>

" use H and L for start/end of line because ^/$
" are backwards and annoying to reach
noremap H ^
noremap L $
noremap ; :
" meta-nvim binds
nnoremap <leader>, :e ~/.config/nvim/init.vim<cr>

" imap <expr> <tab> v:lua.harryg.map_tab()
" imap <expr> <tab> vsnip#jumpable(1) ? "\<Plug>(vsnip-jump-next)" : "\<tab>"
" smap <expr> <tab> vsnip#jumpable(1) ? "\<Plug>(vsnip-jump-next)" : "\<tab>"
"imap <tab>      <Plug>(completion_smart_tab)
"imap <s-tab>    <Plug>(completion_smart_s_tab)

nmap <leader>/          <Plug>CommentaryLine
nmap <leader><leader>/  <Plug>Commentary<Plug>Commentary
nmap <leader>?          <Plug>Commentary
xmap <leader>/          <Plug>Commentary
omap <leader>/          <Plug>Commentary

command! -nargs=* LuaTestCommand lua print(vim.inspect({line1=<q-line1>,line2=<q-line2>,range=<q-range>,count=<q-count>,bang=<q-bang>,mods=<q-mods>,reg=<q-reg>,args={<f-args>}}))

