(module dotfiles.scratch
  {require {a aniseed.core
            fs aniseed.fs
            nvim aniseed.nvim
            str aniseed.string}
   require-macros [dotfiles.macros]})

;; get all options (don't remember why i needed this)
;; --------------------------------------------------
(fn all-options []
  (let [ks (vim.tbl_keys (vim.api.nvim_get_all_options_info))]
    (table.sort ks #(< (string.byte $1) (string.byte $2)))
    ks))

;; aniseed.compile stuff
;; ------------------------------------------

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

;; // aniseed.compile

;; TODO seems like this could be interesting
(let [mod-mt {:__call (fn [] (_G.pr "testing module metatable!"))}]
  (setmetatable *module* mod-mt))

