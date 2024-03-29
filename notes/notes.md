# trouble.nvim stuff
this could also be used for 'list-like' buffers to show CursorLine
there's probably a better way to do the j/k mappings, maybe include
the search in the mapping
```vim
setlocal laststatus=0 " idk why this works
let &winhighlight=&winhighlight .. ",Search:Normal,CursorLine:TelescopeSelection"
/[[0-9, ]\+]$
nnoremap <buffer> <silent> j <cmd>silent normal 2n0<cr>
nnoremap <buffer> <silent> k <cmd>silent normal N0<cr>
```

# Autocommand list buffer stuff
```vim
redir @a | verbose autocmd
redir END
normal \"ap
onoremap <silent> <buffer> } /^\w<cr>
set foldmethod=manual
set foldopen=all
set foldclose=all
g/^\w/normal zf} " then delete top fold with zd
nnoremap <buffer> j zjzo[z
nnoremap <buffer> k zkzo[z
```

```fennel
;(assoc-in!
;  nvim.g [:lf#layout]
;  {:window
;   {:width 1.0
;    :height 0.6666
;    :highlight "Function"
;    :border "horizontal"})
```

```vim
" nnoremap <silent><esc>  <esc>:nohlsearch<CR><esc>
echo luaeval("require'dotfiles.util.completion'.map_k()")
" expand
" escape
" feedkeys
```

```lua
require'nvim-web-devicons'.setup {
	override = {
		fnl = {
			icon = '',
			-- color = '#8dc149', -- clj
			-- color = '#519E3E', -- fennel green top left
			-- color = '#427F33', -- fennel green bottom left
			-- color = '#3C742E', -- fennel green bottom right
			-- color = '#FFC83F', -- fennel logo main 43/75/100
			-- color = '#BE952F', -- fennel logo main 43/75/75
			color = '#E6B439',  -- fennel logo main 43/75/90
			name = 'Fennel'
		}
	},
	default = true
}
```

```fennel
(fn testfunc []
  (set nvim.g.harryg_test_var (rand)))

(set vim.dotfiles {:test testfunc})

(defn nnoremap [from to]
  (nvim.set_keymap
    :n
    (.. "<leader>" from)
    (.. ":" to "<cr>")
    {:noremap true}))
```

```vim
call v:lua.vim.dotfiles.test()
echo g:harryg_test_var
```
