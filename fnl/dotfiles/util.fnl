(module dotfiles.util
  {require {a aniseed.core
            nvim aniseed.nvim
            nvu aniseed.nvim.util
            env aniseed.env
            preload plenary.reload
            it plenary.iterators}
   require-macros [dotfiles.macros]})

(def config-path (nvim.fn.stdpath "config"))

(def unpack (or (rawget _G :unpack) table.unpack))

(defn slice [t s e]
  [(unpack t s e)])

(defn zipmap [...]
  (: (it.zip ...) :tomap))

(defn even-key [[x y]]
  (when (= 0 (% x 2)) y))

(defn odd-key [[x y]]
  (when (not (= 0 (% x 2))) y))

(defn split-seq [t]
  (let [odd (map-indexed odd-key t)
        even (map-indexed even-key t)]
    (unpack
      (if (= (# odd) (# even))
        [odd even]
        [(butlast odd) even]))))

;
; (defn zipmap_luafun [...]
;   (fun.tomap (fun.zip ...)))
;
; (def- test-seq [:a :b :c :d :e :f :g :h :i :j :k])
; (zipmap (split-seq (slice [:lhs :rhs :buffer true :expr true] 3)))
; (# test-seq)
; (fun.each print (fun.zip (fun.partition (fn [i x] (print i x) true) (fun.iter "abcdefg"))))
; (a.filter (fn [x y] (print x y) (not (nil? x))) [:a :b :c :d :e :f :g :h :i :j])
; (a.map-indexed (fn [[x y]] (when (= 0 (% x 2)) y)) [:a :b :c :d :e :f :g :h :i :j])
; (a.map-indexed even-key test-seq)
; (a.map-indexed odd-key test-seq)
; (a.map-indexed (fn [x y] (pr x y) (if (= 0 (% x 2)) y)) [:a :b :c :d :e :f :g :h :i :j])

; (zipmap [:a :b :c :d] [:e :f :g :h])
; (fun.tomap (fun.zip [:a :b :c] [:d :e :f]))
; (slice [:a :b :c :d :e] 2)

; (defn recompile []
;   (env.init {:module :dummy})
;   (nvim.ex.echomsg "'compiled'"))

(defn expand [path]
  (nvim.fn.expand path))

(defn glob [path]
  (nvim.fn.glob path true true true))

(defn exists? [path]
  (= (nvim.fn.filereadable path) 1))

(defn lua-file [path]
  (nvim.ex.luafile path))

(defn- oset-arg [x y z]
  (if z (.. x y z)
      y (.. x := y)
      x))

(defn oset! [x y z]
  (nvim.ex.set (oset-arg x y z)))

(defn memoize [f]
  (let [results {}]
    (fn memoize-internal [...]
      (let [key (pr-str [...])
            result (get results key)]
        (if (not result)
          (let [value (f ...)]
            (tset results key value)
            value)
          result)))))

(defn print_inspect [o]
  (print (vim.inspect o)) o)
(tset _G :pr print_inspect)

(when (not (a.nil? preload.reload_module))
  (tset _G :reload (fn [m]
                     (preload.reload_module m)
                     (require m))))

(defn lspstatus [bufnr]
  (get (first (vim.lsp.buf_get_clients (or bufnr 0))) :name :None))

; Uhh... I think vim.lsp.buf_get_clients should work fine
; not sure why i wrote this
(defn lsp-buf-get-active-clients [bufnr]
  (icollect [_ client (ipairs (vim.lsp.get_active_clients))]
    (let [buffers (vim.lsp.get_buffers_by_client_id client.id)]
      (when (vim.tbl_contains buffers (or bufnr (nvim.get_current_buf)))
        client))))

(defn lsp-buf-get-active-client [bufnr]
  (first (lsp-buf-get-active-clients bufnr)))
(def lsp_buf_get_active_client lsp-buf-get-active-client)

(defn stop_lsp []
  (each [_ client (ipairs (vim.lsp.get_active_clients))]
    (let [buffers (vim.lsp.get_buffers_by_client_id client.id)]
      (when (vim.tbl_contains buffers (nvim.get_current_buf))
        (each [_ buf (ipairs buffers)]
          (vim.lsp.diagnostic.clear buf client.id))
        (vim.lsp.stop_client client.id)))))
;  (let [client (vim.lsp.get_active_clients)]
;    (vim.lsp.get_buffers_by_client_id client.id)
;    (vim.lsp.stop_client client))

; lua vim.lsp.stop_client(vim.lsp.get_active_clients())

; (defn stop_lsp [bufnr]
;   (let [clients (vim.lsp.buf_get_clients bufnr)]
;     (when (not (empty? clients))
;       (vim.lsp.stop_client clients))))

; ((. first (vim.lsp.buf_get_clients 1)) :is_stopped))

(nvu.fn-bridge :LspStatus :dotfiles.util :lspstatus)
(nvu.fn-bridge :StopLsp :dotfiles.util :stop_lsp)
; (nvu.fn-bridge :AniseedCompile :dotfiles.util :recompile)

; (if (nil? (get (vim.api.nvim_get_commands {:builtin false}) :AniseedCompile))
;   (nvim.ex.command_ "AniseedCompile call AniseedCompile()"))
(if (nil? (get (vim.api.nvim_get_commands {:builtin false}) :StopLsp))
  (nvim.ex.command_ "StopLsp call StopLsp()"))

