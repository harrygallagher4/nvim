(module dotfiles.module.snippets
  {require {a aniseed.core
            str aniseed.string
            util dotfiles.util
            ls luasnip}
   require-macros [dotfiles.snippets.macros]})

(def s (. ls :s))
(def t (. ls :t))
(def i (. ls :i))
(def F (. ls :f))
(def c (. ls :c))
(def d (. ls :d))
(def sn (. ls :sn))
(def vsc (a.get-in ls [:parser :parse_snippet]))

(defn- current-module-name []
  (let [file (vim.fn.expand "%:p:~:r")
        basename (vim.fn.expand "%:t:r")
        (start end) (string.find file "/fnl/")]
    (if (and start end) (-> file
                            (string.sub end)
                            (string.sub 2)
                            (str.split "/")
                            (table.concat "."))
        basename)))

(defn- module-name-snip []
  (sn nil
      [(i 1 [(current-module-name)])]))

(def- snips
  {:all
   []

   :nix
   [(s {:name "Attribute" :dscr "Nix attribute name"
        :trig "=([%w%.]+)" :regTrig true :wordTrig true}
       [(f [args] []
          [(.. (a.get-in args [1 :captures 1]) " = ")])
        (i 0)
        (t [";"])])]

   ;; not using fennel snippets right now because parinfer
   ;; tries to format the buffer while the snippet is expanding
   ;; which messes with extmarks
   :fennel
   [(s {:trig "module" :wordTrig true
        :name "Module (dynamic)" :dscr "Aniseed module definition"}
       [(t ["(module "])
        (d 1 module-name-snip [])
        (t ["" "  {require {"])
        (i 2 ["a aniseed.core"])
        (t ["}"])
        (t ["" "   require-macros ["])
        (i 3 ["dotfiles.macros"])
        (t ["]})" ""])
        (i 0)])

    (s {:trig "*mod*" :wordTrig true :name "Module name"
        :dscr "Inserts would-be aniseed module name for the current file in x.y.z format"}
       [(f [] []
           [(current-module-name)])
        (i 0)])

    (s {:trig "let" :wordTrig true :name "Let" :dscr "Fennel let"}
       [(t ["(let "])
        (t ["["]) (i 1) (t ["]"])
        (t ["" "  ("]) (i 0) (t ["))"])])

    (s {:trig "fn" :wordTrig true :name "Function" :dscr "Fennel function"}
       [(t ["(fn "])
        (i 1) (t " ")
        (t ["["]) (i 2) (t ["]"])
        (t ["" "  ("]) (i 0) (t ["))"])])

    (s {:trig "defn" :wordTrig true :name "Aniseed function" :dscr "Aniseed function"}
       [(t ["(defn "])
        (i 1) (t " ")
        (t ["["]) (i 2) (t ["]"])
        (t ["" "  ("]) (i 0) (t ["))"])])]})

(a.assoc ls :snippets snips)

