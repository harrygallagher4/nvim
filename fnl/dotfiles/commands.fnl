(module dotfiles.commands
  {require
   {a aniseed.core
    nvim aniseed.nvim
    nvu aniseed.nvim.util
    fennel aniseed.deps.fennel}})

(local add-cmd! vim.api.nvim_create_user_command)

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

(fn toggle-paren-hl []
  (let [hl (vim.api.nvim__get_hl_defs 0)
        fnlP (?. hl :fennelTSPunctBracket :link)]
    (when (= fnlP "TSPunctBracket")
      (vim.cmd "highlight! link fennelTSPunctBracket Whitespace"))
    (when (= fnlP "Whitespace")
      (vim.cmd "highlight! link fennelTSPunctBracket TSPunctBracket"))))

(defn enter-cmds! []
  (add-cmd! :Phl toggle-paren-hl {})
  (mod-cmd! :FnlClean :dotfiles.compile :clean!)
  (mod-cmd! :FnlCompileAll :dotfiles.compile :compile-all!)
  (add-cmd! :FnlVersion #(vim.notify (.. "Fennel version: " fennel.version)
                                     vim.log.levels.INFO) {}))

