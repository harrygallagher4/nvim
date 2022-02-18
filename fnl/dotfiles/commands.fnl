(module dotfiles.commands
  {require {a aniseed.core
            nvim aniseed.nvim
            nvu aniseed.nvim.util}})

(defn has-command? [cmd]
  (a.table? (a.get (nvim.get_commands {:builtin false}) cmd)))

(defn ex-call-mod-fn [x y]
  (let [mod (if (a.nil? y) *module-name* x)
        f (if (a.nil? y) x y)]
    (string.format "lua require'%s'['%s']()" mod f)))

(defn define! [cmd ex]
  (when (not (has-command? cmd))
    (nvim.ex.command_ (string.format "%s %s" cmd ex))))

(defn mod-cmd! [cmd x y]
  (define! cmd (ex-call-mod-fn x y)))

