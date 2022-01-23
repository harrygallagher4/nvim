(module dotfiles.module.toggleterm
  {require {a aniseed.core
            : toggleterm
            ui toggleterm.ui
            terms toggleterm.terminal}})

(toggleterm.setup
  {:size 8
   :open_mapping "<a-\\>"
   :hide_numbers true
   :shade_terminals true
   :start_in_insert true
   :direction "horizontal"})

(defn smarter-toggle []
  (let [(has-open-term? windows) (ui.find_open_windows)
        is-in-term? (= vim.bo.buftype "terminal")]
    (if is-in-term?
        (vim.cmd "wincmd p")
        has-open-term?
        (vim.api.nvim_set_current_win (a.first windows))
        (toggleterm.toggle_command "" 0))))

(vim.keymap.set [:n :t] "<a-`>" smarter-toggle)

*module*

