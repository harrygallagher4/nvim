(module dotfiles.ftplugin
  {require
   {a aniseed.core
    maps dotfiles.maps
    trouble trouble}
   autoload
   {packer-maps dotfiles.maps.ft_packer}})

(local win-get-height vim.api.nvim_win_get_height)
(local win-get-width vim.api.nvim_win_get_width)
(local win-set-width vim.api.nvim_win_set_width)
(local win-set-height vim.api.nvim_win_set_height)

(local init (setmetatable {} {:__tostring "ftplugin-init-func"}))

(fn set-opt [k v ...]
  (if (= k init) (v ...)
      (tset vim.opt_local k v)))

(fn setl [o ...]
  (if (a.table? o)
      (each [k v (pairs o)]
        (set-opt k v ...))))

(fn ft-trouble [opts]
  (maps.map-multi
    :n [[:j #(trouble.next {:skip_groups true :jump false}) {:buffer opts.buf}]
        [:k #(trouble.previous {:skip_groups true :jump false}) {:buffer opts.buf}]]))

(local local-opts
  {:man :help
   :help {:cursorlineopt "line"
          :list false
          :number false
          :signcolumn "yes:1"
          :virtualedit "all"
          :winfixheight true
          :winfixwidth true
          init #(when (= (+ -3 vim.o.lines)
                         (win-get-height $.win))
                  (win-set-width $.win 82))}

   :qf :qflist
   :qflist {:cursorlineopt "line"
            :list false
            :number false
            :signcolumn "no"
            :virtualedit "all"
            :winfixwidth true
            init #(win-set-height $.win 8)}

   :terminal {:list false
              :number false
              :signcolumn "no"
              :winfixheight true
              :winfixwidth true}

   :conjure {:list false
             :number false
             :signcolumn "no"
             :virtualedit "all"
             :winfixheight true
             :winfixwidth true}

   :Trouble {:cursorlineopt "line"
             init ft-trouble}

   :packer {init #(packer-maps.init)}

   :norg {:colorcolumn [81]
          :conceallevel 2
          :concealcursor "nc"
          :number false
          :signcolumn "no"
          init #(when (> 81 (win-get-width $.win))
                  (win-set-width $.win 81))}})

(fn str2nr? [s]
  (if (s:match "^%d+$")
      (values true (vim.fn.str2nr s))
      (values false s)))

(fn get-opts []
  (let [(bufnr? buf) (str2nr? (vim.fn.expand "<abuf>"))
        aumatch (vim.fn.expand "<amatch>")
        file (vim.fn.expand "<afile>")
        buf-opts
        (when bufnr?
          {:win (vim.fn.bufwinid buf)
           :bufname (vim.api.nvim_buf_get_name buf)
           :buftype (vim.api.nvim_buf_get_option buf :buftype)})]
    (a.merge {:match aumatch : bufnr? : buf : file} buf-opts)))

(fn ft-options [ft ...]
  (if (a.table? ft) (setl ft ...)
      (a.string? ft)
      (ft-options (. local-opts ft) ...)))

(fn wrap [f fname]
  #(let [opts (get-opts)] (f opts)))

(fn handle-filetype [opts]
  (ft-options opts.match opts))

(fn handle-bufnew [opts]
  (if (opts.file:match "^conjure%-log%-%d+.*$") (ft-options :conjure)))

(fn handle-termopen [opts]
  (ft-options :terminal))

(vim.api.nvim_create_augroup :dfftplugins
                             {:clear true})
(vim.api.nvim_create_autocmd :FileType
                             {:group "dfftplugins"
                              :callback (wrap handle-filetype :FileType)})
(vim.api.nvim_create_autocmd :BufWinEnter
                             {:group "dfftplugins"
                              :callback (wrap handle-bufnew :BufWinEnter)})
(vim.api.nvim_create_autocmd :TermOpen
                             {:group "dfftplugins"
                              :callback (wrap handle-termopen :TermOpen)})

