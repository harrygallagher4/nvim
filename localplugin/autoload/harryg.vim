
function harryg#cheat_float()
  let cheatfile = expand("~/.config/cheat/cheatsheets/personal/vim")
  let buf = bufadd(cheatfile)
  let winconfig = { 'relative': 'cursor',
                  \ 'width':80,
                  \ 'height':24,
                  \ 'style':'minimal',
                  \ 'row':0,
                  \ 'col':0}
  let win = nvim_open_win(buf, v:true, winconfig)
  call nvim_win_set_option(win, 'signcolumn', 'yes:1')
endfunction

function harryg#fzf_sink(what)
  let p1 = stridx(a:what, '<')
  if p1 >= 0
    let name = strpart(a:what, 0, p1)
    let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
    if name != ''
      exec "AsyncTask ". fnameescape(name)
    endif
  endif
endfunction

function harryg#fzf_task()
  let width = min([&columns - 4, max([80, &columns - 20])])
  let rows = asynctasks#source(width - 8)
  let source = []
  for row in rows
    let name = row[0]
    let source += [name . '  ' . row[1] . '  : ' . row[2]]
  endfor
  let opts = { 'source': source,
        \ 'sink': function('harryg#fzf_sink') }
  if exists('g:fzf_layout')
    for key in keys(g:fzf_layout)
      let opts[key] = deepcopy(g:fzf_layout[key])
    endfor
  endif
  call fzf#run(opts)
endfunction

function harryg#is_fzf()
  return &filetype == "fzf"
endfunction

function harryg#netrw_map()
  nnoremap <buffer> <c-l> <c-w>l
endfunction

function harryg#set_explorer_window()
  let t:explorer_window = win_getid()
endfunction

function harryg#open_or_go_to_explorer()
  if exists('t:explorer_window')
    if win_getid() == t:explorer_window
      execute "normal \<c-w>\<c-p>"
    else
      call win_gotoid(t:explorer_window)
    endif
  else
    execute 'Lexplore'
  endif
endfunction

function harryg#maybe_start_terminal_insert()
  if !exists('g:dont_start_insert_in_terminal')
    startinsert
  endif
endfunction

function harryg#find_active_terminal()
  let g:dont_start_insert_in_terminal=1
  let g:last_window=bufwinid("%")
  let g:active_terminal=0
  windo call SetActiveTerminal()
  call win_gotoid(g:last_window)
  unlet g:dont_start_insert_in_terminal
endfunction

function harryg#set_active_terminal()
  if exists('b:terminal_job_id')
    let g:active_terminal = b:terminal_job_id
  endif
  return 0
endfunction

