(module dotfiles.maps.ft_packer
  {require {a aniseed.core}
   require-macros [dotfiles.macros
                   dotfiles.maps.macros]})

(def config {:cmd "open"})
(def- updated-pattern "^%W+Updated ([%w%-%.]+)/([%w%-%.]+): (%w+)%.%.(%w+)$")
(def- updated-pattern-branch "^%W+Updated ([%w%-%.]+)/([%w%-%.]+)/[%w%-%.]+: (%w+)%.%.(%w+)$")

(def- repo-pattern "^%W'(%w+)/(%w+)'.*$")

(defn- match-str [s]
  (let [m [(string.match s updated-pattern)]]
    (if (not (a.empty? m))
        (unpack m)
        (string.match s updated-pattern-branch))))

(defn- match-line [] (match-str (vim.api.nvim_get_current_line)))

(defn- url [...]
  (if (= 4 (a.count [...]))
    (string.format "https://github.com/%s/%s/compare/%s...%s" ...)))

(defn- open-url! [url]
  (when (not (a.nil? url))
        (vim.cmd (string.format "silent !%s '%s'" config.cmd url))))

(defn- do-line [] (open-url! (url (match-line))))

(defn init []
  ; (vim.keymap.nnoremap {1 "o" 2 do-line :buffer true})
  ; (nnoremap "o" do-line :buffer true)
  (vim.keymap.set "n" "o" do-line {:buffer true}))

(dbg!
  (url (match-str " ✓ Updated L3MON4D3/LuaSnip/test: 51a4a92..d076884"))
  (url (match-str " ✓ Updated L3MON4D3/LuaSnip: 51a4a92..d076884"))
  (url (match-str " ✓ xxxxxxx L3MON4D3/LuaSnip: 51a4a92..d076884"))
  (open-url! (url (match-str " ✓ invalid")))
  (let [m [(match-str " ✓ oopsie woopsie")]] (if (a.empty? m) nil m))
  (let [m [(match-str " ✓ Updated glepnir/lspsaga.nvim: 2bc15f3..2752af4")]] (if (a.empty? m) nil m))
  (a.count [(match-str " ✓ Updated nvim-treesitter/nvim-treesitter: 2abad14..1d5f928")]))

;
; astronauta.keymap works with inline functions
; ---------------------------------------------------------------------------------
;   (vim.keymap.nnoremap {1 "o" 2 #(open-url! (url (match-line))) :buffer true}))
; ---------------------------------------------------------------------------------
;
; (defn- match-line-test []
;   (match-str " ✓ Updated glepnir/lspsaga.nvim: 2bc15f3..2752af4"))
;
; (defn- do-line-test [] (open-url (url (match-line-test))))
; (defn- open-compare []
;   (let [m (match-line)]
;     (if (string? m) (open-url m) (print "Could not detect url"))))
;
; (defn- match-line []
;   (let [(user repo from to)
;         (string.match (nvim.get_current_line) updated-pattern)]
;     (if (nil? user) nil (url user repo from to))))
;   (let [m [(string.match (nvim.get_current_line) updated-pattern)]])
; (defn- do-line []
;   (let [m (match-line)]
;     (when (not (empty? m))
;       (open-url (url (unpack m))))))
;
; (defn- do-line []
;   (let [m (match-line)]
;     (when
;       (= 4 (count m))
;       (open-url (url (unpack m))))))
