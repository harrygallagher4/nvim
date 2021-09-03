(module dotfiles.module.snippets
  {require {a aniseed.core
            str aniseed.string
            nvim aniseed.nvim
            util dotfiles.util
            ls luasnip}
   require-macros [dotfiles.macros
                   dotfiles.snippets.macros]})

(def s (. ls :s))
(def t (. ls :t))
(def i (. ls :i))
(def snipf (. ls :f))
(def c (. ls :c))
(def d (. ls :d))
(def sn (. ls :sn))
(def vsc (get-in ls [:parser :parse_snippet]))

(defn- current-module-name []
  (let [file (vim.fn.expand "%:p:~:r")
        (start end) (string.find file "/fnl/")]
    (-> file
      (string.sub end)
      (string.sub 2)
      (str.split "/")
      (table.concat "."))))

(defn- module-name-snip []
  (sn nil
      [(i 1 [(current-module-name)])]))

(def- snips
  {:all
   [(vsc {:trig "sniptest"}
      "snippet ${0:sniptest} inserted!")]

   :nix
   [(s {:name "Attribute" :dscr "Nix attribute name"
        :trig "=([%w%.]+)" :regTrig true :wordTrig true}
       [(f [args] []
          [(.. (get-in args [1 :captures 1]) " = ")])
        (i 0)
        (t [";"])])]

   :rust 
   [(vsc {:trig "fn"}
      "/// $1\nfn $2($3) ${4:-> $5 }\\{\n\t$0\n\\}")]

   ;; not using fennel snippets right now because parinfer
   ;; tries to format the buffer while the snippet is expanding
   ;; which messes up luasnip somehow
   :fennel
   [(s {:name "Module (dynamic)" :dscr "Aniseed module definition"
        :trig "module"}
       [(t ["(module "])
        (d 1 module-name-snip [])
        (t ["" "  {require {"])
        (i 2 ["a aniseed.core"])
        (t ["}"])
        (t ["" "   require-macros ["])
        (i 3 ["dotfiles.macros"])
        (t ["]})" ""])
        (i 0)])]})

(assoc ls :snippets snips)

