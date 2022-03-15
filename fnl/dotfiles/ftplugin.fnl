(module dotfiles.ftplugin
  {require
   {a aniseed.core}})


(fn setl [o v]
  (if (and (a.table? o) (a.nil? v))
      (each [k v (pairs o)]
        (tset vim.opt_local k v))
      (tset vim.opt_local o v)))

(local local-opts
  {:help
   {:cursorlineopt "line"
    :list false
    :number false
    :signcolumn "yes:1"
    :virtualedit "all"
    :winfixheight true
    :winfixwidth true}

   :qflist
   {:cursorlineopt "line"
    :list false
    :number false
    :signcolumn "no"
    :virtualedit "all"
    :winfixheight true
    :winfixwidth true}

   :terminal
   {:list false
    :number false
    :signcolumn "no"
    :winfixheight true
    :winfixwidth true}

   :conjure
   {:list false
    :number false
    :signcolumn "no"
    :virtualedit "all"
    :winfixheight true
    :winfixwidth true}})

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
    (a.merge
      {:match aumatch : bufnr? : buf : file}
      buf-opts)))

;    (do (when fname (pr fname)) (pr opts))
(fn wrap [f fname]
 #(let [opts (get-opts)]
    (f opts)))

(fn handle-filetype [opts]
  (if (= opts.match "help") (setl local-opts.help)
      (= opts.match "man") (setl local-opts.help)
      (= opts.match "qf") (setl local-opts.qflist)))

(fn handle-bufnew [opts]
  (if (opts.file:match "^conjure%-log%-%d+.*$") (setl local-opts.conjure)))

(fn handle-termopen [opts]
  (setl local-opts.terminal))


(vim.api.nvim_create_augroup :dfftplugins {:clear true})
(vim.api.nvim_create_autocmd :FileType {:group "dfftplugins" :callback (wrap handle-filetype :FileType)})
(vim.api.nvim_create_autocmd :BufWinEnter {:group "dfftplugins" :callback (wrap handle-bufnew :BufWinEnter)})
(vim.api.nvim_create_autocmd :TermOpen {:group "dfftplugins" :callback (wrap handle-termopen :TermOpen)})

