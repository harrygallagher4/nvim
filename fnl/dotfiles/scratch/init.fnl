(module dotfiles.scratch
  {require {a aniseed.core
            fs aniseed.fs
            nvim aniseed.nvim
            str aniseed.string}
   require-macros [dotfiles.macros]})

; aniseed.compile stuff
; ------------------------------------------

(defn macros-strs [mods]
  (->> (if (a.string? mods) [mods] mods)
       (a.concat [:aniseed.macros])
       (a.map #(string.format "(require-macros %s)" $))
       (str.join "\n")))

(defn macros-prefix [code opts]
  (let [macros-modules (macros-strs (a.get opts :macros))
        filename (-?> (a.get opts :filename)
                      (string.gsub (.. (nvim.fn.getcwd) fs.path-sep) "")
                      (string.gsub "\\" "\\\\"))]
    (string.format
      "(local *file* %s)\n%s\n(wrap-module-body\n%s\n)"
      (or filename "nil") macros-modules (or code ""))))

(macros-prefix "(print 1)" {:filename *file* :macros [:dotfiles.macros]})
(macros-prefix "(print 2)" {:filename *file* :macros :dotfiles.macros})
(macros-prefix "(print 2)" {:filename *file*})

;; TODO seems like this could be interesting
(let [mod-mt {:__call (fn [] (_G.pr "testing module metatable!"))}]
  (setmetatable *module* mod-mt))

; // aniseed.compile

; (let [scratch
;       (macro scratch []
;         (pr (get-scope)))]
;   (a.pr (scratch)))

