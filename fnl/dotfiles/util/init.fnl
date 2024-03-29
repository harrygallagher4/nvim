(module dotfiles.util
  {require
   {a aniseed.core
    nvim aniseed.nvim
    nvu aniseed.nvim.util
    str dotfiles.util.string
    preload plenary.reload
    it plenary.iterators}})

;; TODO this file needs a lot of work

(def config-path (vim.fn.stdpath "config"))

(local extra-paths
  {"~" "~"
   :home "~"
   :scripts "~/scripts/"
   :plugins (.. (vim.fn.stdpath "data") "/site/pack/packer/start")
   :opt-plugins (.. (vim.fn.stdpath "data") "/site/pack/packer/opt")})

(defn stdpath [name]
  (let [custom-path (. extra-paths name)]
    (if (= nil custom-path) (vim.fn.stdpath name)
        (-> (vim.fn.fnamemodify custom-path ":p")
            (: :sub 1 -2)))))

(defn up-dir [path]
  (->> path
       (str.split "/")
       (a.butlast)
       (str.join "/")))

(defn stdfile [dir ...]
  (let [up? (= ".." (select 1 ...))
        path (stdpath dir)
        p-tbl (if up?
                  [(up-dir path) (select 2 ...)]
                  [path ...])]
    (str.join "/" p-tbl)))

;
; general utils
; ----------------------------------------

(def unpack (or (rawget _G :unpack) table.unpack))

(defn slice [t s e]
  [(unpack t s e)])

(defn zipmap [...]
  (: (it.zip ...) :tomap))

(defn min-of [xs]
  (math.min (unpack xs)))

(defn max-of [xs]
  (math.min (unpack xs)))

(defn even-key [[x y]]
  (if (= 0 (% x 2)) y))
(defn odd-key [[x y]]
  (if (not (= 0 (% x 2))) y))

(defn split-seq [t]
  (let [odd (a.map-indexed odd-key t)
        even (a.map-indexed even-key t)]
    (unpack (if (= (# odd) (# even))
                [odd even]
                [(a.butlast odd) even]))))

;
; vim utils
; ----------------------------------------

(defn cmd [s ...]
  (if ...
    (vim.cmd (string.format s ...))
    (vim.cmd s)))

(defn expand [path]
  (vim.fn.expand path))

(defn glob [path]
  (vim.fn.glob path true true true))

(defn exists? [path]
  (= (vim.fn.filereadable path) 1))

(defn lua-file [path]
  (nvim.ex.luafile path))

(defn memoize [f]
  (let [results {}]
    (fn memoize-internal [...]
      (let [key (a.pr-str [...])
            result (a.get results key)]
        (if (not result)
            (let [value (f ...)]
              (tset results key value)
              value)
            result)))))

(defn print-inspect [o]
  (print (vim.inspect o)) o)
(tset _G :pr print-inspect)

(when (not (a.nil? preload.reload_module))
      (tset _G :reload (fn [m]
                         (preload.reload_module m)
                         (require m))))

(defn lspstatus [bufnr]
  (a.get (a.first (vim.lsp.buf_get_clients (or bufnr 0))) :name :None))

; Uhh... I think vim.lsp.buf_get_clients should work fine
; not sure why i wrote this
(defn lsp-buf-get-active-clients [bufnr]
  (icollect [_ client (ipairs (vim.lsp.get_active_clients))]
    (let [buffers (vim.lsp.get_buffers_by_client_id client.id)]
      (when (vim.tbl_contains buffers (or bufnr (vim.api.nvim_get_current_buf)))
            client))))

(defn lsp-buf-get-active-client [bufnr]
  (a.first (lsp-buf-get-active-clients bufnr)))
(def lsp_buf_get_active_client lsp-buf-get-active-client)

(defn stop_lsp []
  (each [_ client (ipairs (vim.lsp.get_active_clients))]
    (let [buffers (vim.lsp.get_buffers_by_client_id client.id)]
      (when (vim.tbl_contains buffers (vim.api.nvim_get_current_buf))
            (each [_ buf (ipairs buffers)]
              (vim.lsp.diagnostic.clear buf client.id))
            (vim.lsp.stop_client client.id)))))

(defn sync-plugins []
  (preload.reload_module :plugins.spec)
  ((. (require :plugins.spec) :sync)))
(def sync_plugins sync-plugins)

(nvu.fn-bridge :LspStatus :dotfiles.util :lspstatus)
(nvu.fn-bridge :StopLsp :dotfiles.util :stop_lsp)
(nvu.fn-bridge :SyncPlugins :dotfiles.util :sync_plugins)

(if (a.nil? (a.get (vim.api.nvim_get_commands {:builtin false}) :StopLsp))
  (nvim.ex.command_ "StopLsp call StopLsp()"))
(if (a.nil? (a.get (vim.api.nvim_get_commands {:builtin false}) :PluginSync))
  (nvim.ex.command_ "SyncPlugins call SyncPlugins()"))

