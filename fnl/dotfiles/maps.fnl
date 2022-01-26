(module dotfiles.maps
  {require {a aniseed.core
            str dotfiles.core.string
            : luadev}})
; `mapping` refers to a table of `vim.keymap.set` arguments

(def- vf vim.fn)
(def- f string.format)

(defn- split-mode [mapping]
  [(-> mapping (a.first) (str.chars))
   (-> mapping (a.rest) (unpack))])
(defn map [mapping]
  (-> mapping (split-mode) (unpack) (vim.keymap.set)))

(defn map-multi [x y]
  (let [mappings
        (if (a.nil? y) x
          (a.map #(a.concat [x] $) y))]
    (a.run! map mappings)))


(defn- pumvisible? [] (= 1 (vf.pumvisible)))
(defn ctrl-j []       (if (pumvisible?) "<c-n>" "<c-j>"))
(defn ctrl-k []       (if (pumvisible?) "<c-p>" "<c-k>"))

(defn- luadev-runfile []
  (-> (vim.api.nvim_buf_get_lines 0 0 -1 false)
      (table.concat "\n")
      (luadev.exec)))

(def- mappings
  [[:n :<leader>w     "<cmd>update<cr>" {:silent true}]
   [:n :<leader><tab> "<cmd>buffer # <cr>" {:silent true}]
   [:n "<leader>,"    "<cmd>e ~/.config/nvim/lua/plugins/spec.lua<cr>" {:silent true}]
   [:n "<leader>cd"   "<cmd>cd %:h<cr>:pwd<cr>"]

   [:nvo :H  :^]
   [:nvo :L  :$]
   [:nvo ";" ":"]

   [:n "<left>"  "<cmd>wincmd <<cr><cmd>echo winwidth(0)<cr>"]
   [:n "<right>" "<cmd>wincmd ><cr><cmd>echo winwidth(0)<cr>"]
   [:n "<up>"    "<cmd>wincmd +<cr><cmd>echo winheight(0)<cr>"]
   [:n "<down>"  "<cmd>wincmd -<cr><cmd>echo winheight(0)<cr>"]

   [:ic :<c-j> ctrl-j {:silent true :expr true}]
   [:ic :<c-k> ctrl-k {:silent true :expr true}]

   [:n "-" #(vf.lf#pick (vf.expand "%:p:h"))]
   [:n "_" #(vf.lf#pick (vf.getcwd))]

   [:n "<plug>(Luadev-RunFile)" luadev-runfile]
   [:n :<leader>lr        "<plug>(Luadev-RunLine)"]
   [:n :<leader>la        "<plug>(Luadev-RunFile)"]
   [:n :<leader><leader>l "<plug>(Luadev-RunWord)"]
   [:v :<leader>lr        "<plug>(Luadev-Run)"]

   [:n  :<leader>/         "<plug>CommentaryLine"]
   [:n  :<leader><leader>/ "<plug>Commentary<plug>Commentary"]
   [:n  :<leader>?         "<plug>Commentary"]
   [:xo :<leader>/         "<plug>Commentary"]

   ; add <c-w>X and <c-w><c-X> maps in terminal mode
   (unpack
     (a.mapcat
       #[[:t (f "<c-w>%s" $)     (f "<cmd>wincmd %s<cr>" $) {:remap false}]
         [:t (f "<c-w><c-%s>" $) (f "<cmd>wincmd %s<cr>" $) {:remap false}]]
       (str.chars "hjklsvcq")))])

(map-multi mappings)

; (let [ks (vim.tbl_keys (vim.api.nvim_get_all_options_info))]
;   (table.sort ks #(< (string.byte $1) (string.byte $2)))
;   ks)

