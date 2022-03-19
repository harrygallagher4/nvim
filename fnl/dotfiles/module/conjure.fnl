(module dotfiles.module.conjure
  {require {o dotfiles.options
            cmd dotfiles.commands}})

; (o.gset :conjure#extract#tree_sitter#enabled true)
(o.gset :conjure#log#jump_to_latest#enabled true)
(o.gset :conjure#log#jump_to_latest#cursor_scroll_position "top")
(o.gset :conjure#client#fennel#stdio#command
        "fennel --globals '*' --no-compiler-sandbox --repl")

(def- conjure-fennel-opts
  (vim.tbl_add_reverse_lookup
    {:conjure.client.fennel.aniseed :conjure.client.fennel.stdio}))

(defn toggle-client []
  (o.gset :conjure#filetype#fennel
    (. conjure-fennel-opts
      (. vim.g :conjure#filetype#fennel))))

(cmd.mod-cmd! :FnlToggleClient *module-name* :toggle-client)

