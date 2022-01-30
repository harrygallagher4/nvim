(module dotfiles.module.toggleterm
  {require {a aniseed.core
            : toggleterm
            ui toggleterm.ui
            terms toggleterm.terminal
            maps dotfiles.maps}})

(defn- new-terminal [opts]
  (terms.Terminal:new opts))
(defn- toggle [term]
  #(term:toggle))

(toggleterm.setup
  {:size 8
   :open_mapping "<a-\\>"
   :hide_numbers true
   :shade_terminals true
   :start_in_insert true
   :direction "horizontal"
   :float_opts
   {:border "curved"
    :width (math.floor (* vim.o.columns 0.8))
    :height (math.floor (* vim.o.lines 0.8))
    :highlights {:border "TelescopeBorder" :background "Normal"}}})

(def- lazygit
  (new-terminal
    {:cmd "lazygit"
     :direction "float"
     :hidden true
     :insert_mappings false
     :on_open
     #(maps.map [:t :q (toggle $) {:buffer $.bufnr}])}))

(defn smarter-toggle []
  (let [(has-open-term? windows) (ui.find_open_windows)
        is-in-term? (= vim.bo.buftype "terminal")]
    (if is-in-term?
        (vim.cmd "wincmd p")
        has-open-term?
        (vim.api.nvim_set_current_win (a.first windows))
        (toggleterm.toggle_command "" 0))))

(maps.map-multi :nt
  [["<a-`>" smarter-toggle]
   ["<a-G>" (toggle lazygit)]])

