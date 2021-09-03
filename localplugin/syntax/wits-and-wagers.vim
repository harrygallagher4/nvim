if exists("b:current_syntax") | finish| endif

syntax match WWBretlyn "\m\<\(\S\)\+\s\?B"
syntax match WWHarry "\m\<\(\S\)\+\s\?H"
syntax match WWMary "\m\<\(\S\)\+\s\?M"
syntax match WWJerry "\m\<\(\S\)\+\s\?J"

"highlight! link WWBretlyn DraculaPurple
"highlight! link WWHarry DraculaPink
"highlight! link WWMary DraculaGreen
"highlight! link WWJerry DraculaOrange
highlight WWBretlyn guifg=SlateBlue
highlight WWHarry guifg=LightGreen
highlight WWMary guifg=Yellow
highlight WWJerry guifg=Red

function! WWRandomColors()
  let s:colors = ["SlateBlue", "LightGreen", "Cyan", "Red", "Magenta", "Yellow", "Orange"]
python3 << EOF
import vim 
import random
colors = vim.eval('s:colors')
random_colors = random.sample(colors, 4)
vim.command("let s:py_random = [\"%s\", \"%s\", \"%s\", \"%s\"]"% (random_colors[0], random_colors[1], random_colors[2], random_colors[3]))
EOF
  exe "highlight WWBretlyn guifg=" . s:py_random[0]
  exe "highlight WWHarry guifg=" . s:py_random[1]
  exe "highlight WWMary guifg=" . s:py_random[2]
  exe "highlight WWJerry guifg=" . s:py_random[3]
endfunction

call WWRandomColors()

let b:current_syntax = 'wits-and-wagers'
