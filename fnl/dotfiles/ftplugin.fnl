(module dotfiles.ftplugin
  {require
   {a aniseed.core
    maps dotfiles.maps
    trouble trouble}
   autoload
   {packer-maps dotfiles.maps.ft_packer}})

(local func (setmetatable {} {:__tostring "setupfn"}))

(fn set-opt [k v]
  (if (= k func) (v)
      (tset vim.opt_local k v)))

(fn setl [o v]
  (if (and (a.table? o) (a.nil? v))
      (each [k v (pairs o)]
        (set-opt k v))
      (set-opt o v)))

(local local-opts
  {:man :help
   :help
   {:cursorlineopt "line"
    :list false
    :number false
    :signcolumn "yes:1"
    :virtualedit "all"
    :winfixheight true
    :winfixwidth true}

   :qf :qflist
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
    :winfixwidth true}

   :Trouble
   {:cursorlineopt "line"}})

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

(fn ft-options [ft]
  (if (a.table? ft) (setl ft)
      (a.string? ft)
      (ft-options (. local-opts ft))))

(fn wrap [f fname]
 #(let [opts (get-opts)]
    (f opts)))

(fn ft-trouble [opts]
  (maps.map-multi :n
    [[:j #(trouble.next {:skip_groups true :jump false}) {:buffer opts.buf}]
     [:k #(trouble.previous {:skip_groups true :jump false}) {:buffer opts.buf}]]))

(fn handle-filetype [opts]
  (ft-options opts.match)
  (if (= opts.match "Trouble") (ft-trouble opts)
      (= opts.match "packer") (packer-maps.init)))

(fn handle-bufnew [opts]
  (if (opts.file:match "^conjure%-log%-%d+.*$") (ft-options :conjure)))

(fn handle-termopen [opts]
  (ft-options :terminal))


(vim.api.nvim_create_augroup :dfftplugins {:clear true})
(vim.api.nvim_create_autocmd :FileType {:group "dfftplugins" :callback (wrap handle-filetype :FileType)})
(vim.api.nvim_create_autocmd :BufWinEnter {:group "dfftplugins" :callback (wrap handle-bufnew :BufWinEnter)})
(vim.api.nvim_create_autocmd :TermOpen {:group "dfftplugins" :callback (wrap handle-termopen :TermOpen)})

