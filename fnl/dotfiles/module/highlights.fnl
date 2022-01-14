(module dotfiles.module.highlights
  {require {a aniseed.core
            str aniseed.string
            nvim aniseed.nvim
            lush lush
            colorizer colorizer}
   require-macros [dotfiles.highlight.macros]})

(colorizer.setup nil {:names false :mode "both"})

(global harryg_lsbufs
  (fn []
    (print
      (let
        [bufs (a.map
                #[(vim.api.nvim_buf_get_name $)
                  (vim.api.nvim_buf_get_option $ :filetype)
                  (vim.api.nvim_buf_get_option $ :buftype)]
                (vim.api.nvim_list_bufs))]
        (-> bufs
            (vim.inspect)
            (str.split "}, ")
            (#(str.join "},\n" $)))))))

(def- hsl lush.hsl)

(def
  gruvbox
  {:dark0_hard "#1d2021" :dark0 "#282828" :dark0_soft "#32302f" :dark1 "#3c3836"
   :dark2 "#504945" :dark3 "#665c54" :dark4 "#7c6f64" :light0_hard "#f9f5d7"
   :light0 "#fbf1c7" :light0_soft "#f2e5bc" :light1 "#ebdbb2" :light2 "#d5c4a1"
   :light3 "#bdae93" :light4 "#a89984" :bright_red "#fb4934"
   :bright_green "#b8bb26" :bright_yellow "#fabd2f" :bright_blue "#83a598"
   :bright_purple "#d3869b" :bright_aqua "#8ec07c" :bright_orange "#fe8019"
   :neutral_red "#cc241d" :neutral_green "#98971a" :neutral_yellow "#d79921"
   :neutral_blue "#458588" :neutral_purple "#b16286" :neutral_aqua "#689d6a"
   :neutral_orange "#d65d0e" :faded_red "#9d0006" :faded_green "#79740e"
   :faded_yellow "#b57614" :faded_blue "#076678" :faded_purple "#8f3f71"
   :faded_aqua "#427b58" :faded_orange "#af3a03" :gray "#928374"
   :bg0 "#32302f" :bg1 "#3c3836" :bg2 "#504945" :bg3 "#665c54" :bg4 "#7c6f64"
   :fg0 "#fbf1c7" :fg1 "#ebdbb2" :fg2 "#d5c4a1" :fg3 "#bdae93" :fg4 "#a89984"
   :red "#fb4934" :green "#b8bb26" :yellow "#fabd2f" :blue "#83a598"
   :purple "#d3869b" :aqua "#8ec07c" :orange "#fe8019" :NONE "NONE"
   :sl "#32302e"})

(defn resolve-color [color]
  (or (string.match color "#%x%x%x%x%x%x")
      (a.get gruvbox color)))
(defn lushcolor [color]
  (hsl (resolve-color color)))

(defn __ [...] (str.join " " [...]))
(defn notblank? [s] (not (str.blank? s)))

(defn fg [color] (str.join [:guifg= (resolve-color color)]))
(defn bg [color] (str.join [:guibg= (resolve-color color)]))
(defn gui [prop] (str.join [:gui= prop]))

(def highlight  nvim.ex.highlight)
(def highlight! nvim.ex.highlight_)
(defn hi  [group ...] (highlight  (__ group ...)) group)
(defn hi! [group ...] (highlight! (__ group ...)) group)
(defn highlight-link  [source target] (highlight  (__ :link source target)) source)
(defn highlight-link! [source target] (highlight! (__ :link source target)) source)
(defn highlight-clear  [group] (highlight  (__ :clear group)) group)
(defn highlight-clear! [group] (highlight! (__ :clear group)) group)
(def hlclear  highlight-clear)
(def hlclear! highlight-clear!)

(defn- rotate [c x] (c.rotate x))
(defn- saturate [c x] (c.saturate x))
(defn- desaturate [c x] (c.desaturate x))
(defn- lighten [c x] (c.lighten x))
(defn- darken [c x] (c.darken x))
(defn- abs-rotate [c x] (c.abs_rotate x))
(defn- abs-saturate [c x] (c.abs_saturate x))
(defn- abs-desaturate [c x] (c.abs_desaturate x))
(defn- abs-lighten [c x] (c.abs_lighten x))
(defn- abs-darken [c x] (c.abs_darken x))
(defn- hue [c x] (c.hue x))
(defn- saturation [c x] (c.saturation x))
(defn- lightness [c x] (c.lightness x))
(defn- h [c] (a.get c :h))
(defn- s [c] (a.get c :s))
(defn- l [c] (a.get c :l))

