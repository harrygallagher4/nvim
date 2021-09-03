(module dotfiles.util.lualsp
  {require {a aniseed.core
            nvim aniseed.nvim
            luadev lua-dev}})

(def sumneko-root (.. (nvim.fn.stdpath "cache") "/lsp/lua/"))
(defn- p [...] (.. sumneko-root ...))
(def bin (p "bin/macOS/lua-language-server"))
(def cmd [bin "-E" (p "main.lua")])

(def- ldconfig
  {:cmd cmd})

(defn setup [...]
  (luadev.setup
    {:library
     {:vimruntime true
      :types true
      :plugins true}
     :lspconfig (a.merge ldconfig ...)}))

; (def- luapath (nvim.fn.split package.path ";"))

; (defn- rt [...]
;   (.. (nvim.fn.expand "$VIMRUNTIME/") ...))

; (defn- isdirectory? [d]
;   (= 1 (vim.fn.isdirectory d)))

; (defn- start [pl pa]
;   (.. :/Users/harry/.local/share/nvim/site/pack/packer/start/ pl :/lua/ pa :/))
; (defn- opt [pl pa]
;   (.. :/Users/harry/.local/share/nvim/site/pack/packer/opt pl :/lua/ pa :/))
; (defn- test-plugin [pa pl]
;   (or (string.match pa (.. ".*/pack/packer/start/" pl "/lua/.*"))
;       (string.match pa (.. ".*/pack/packer/opt/" pl "/lua/.*"))))

; (defn- lua-runtime []
;   (collect [x y (pairs (vim.api.nvim_list_runtime_paths))]
;     (let [lua-path (.. y "/lua/")]
;       (when (and (isdirectory? lua-path))
;         (values lua-path true)))))

; (and true)

; (def- cfg
;   {:cmd cmd
;    :settings
;    {:Lua
;     {:runtime {:version "LuaJIT"
;                :path (a.concat luapath ["?.lua"
;                                         "?/?.lua"
;                                         "?/?/?.lua"
;                                         "?/?/?/?.lua"])}
;      :diagnostics {:globals [:vim]}
;      :workspace {:preloadFileSize 2000
;                  :maxPreload 2000
;                  :library
;                  (vim.tbl_extend
;                    "force"
;                    (lua-runtime)
;                    ; Manual overrides
;                    {:/Users/harry/.cache/nvim/lua_extra true
;                     (start :nvim-compe :compe_emoji) false})}}}})

; (defn config [...]
;   (a.merge cfg ...))

