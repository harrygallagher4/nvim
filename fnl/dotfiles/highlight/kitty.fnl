(module dotfiles.highlight.kitty
  {require {a aniseed.core
            str aniseed.string
            lustache lustache}})

(def- ffffff 16777215)

(defn- min-of [xs]
  (math.min (unpack xs)))
(defn- split-at [sep s]
  (str.split s sep))
(defn- trim-multiline [s]
  (->> s
       (split-at "\n")
       (a.map str.trim)
       (str.join "\n")))

(defn- common-indent [s]
  (->> s
       (split-at "\n")
       (a.map #(string.match $ "^(%s+)%S"))
       (a.map string.len)
       (min-of)))

(defn- trim-leading-spaces [indent input]
  (let [f (fn [s] (if (string.match s (.. "^" (string.rep "%s" indent)))
                      (string.sub s (+ 1 indent))
                      (string.match s "^%s+$")
                      ""
                      s))]
    (if (a.nil? input) f (f input))))

(defn- trim-common [s]
  (let [indent (common-indent s)
        lines (split-at "\n" s)]
    (->> lines
      (a.map (trim-leading-spaces indent))
      (str.join "\n"))))

(defn- tail [xs]
  (let [[h & t] xs] t))

(defn- multiline-str [s]
  (->> s
       (split-at "\n")
       (a.rest)
       (str.join "\n")
       (trim-common)))

(defn- safe-bg [group]
  (string.format
    "#%06x"
    (a.get group :background ffffff)))
(defn- safe-fg [group]
  (string.format
    "#%06x"
    (a.get group :foreground ffffff)))
(defn- get-bg [group]
  (if (a.get group :reverse false)
      (safe-fg group)
      (safe-bg group)))
(defn- get-fg [group]
  (if (a.get group :reverse false)
      (safe-bg group)
      (safe-fg group)))

(defn- get-hl [group]
  (let [g (vim.api.nvim_get_hl_by_name group true)]
    {:bg (get-bg g)
     :fg (get-fg g)}))

; (get-bg (vim.api.nvim_get_hl_by_name :Cursor true))

; (defn- get-hl [group]
;   (let [g (vim.api.nvim_get_hl_by_name group true)
;         bg (a.get g :background ffffff)
;         fg (a.get g :foreground ffffff)]
;     {:bg (string.format "#%06x" bg)
;      :fg (string.format "#%06x" fg)}))

(def-
  view
  (setmetatable
    {:scheme_name vim.g.colors_name
     :0 vim.g.terminal_color_0
     :1 vim.g.terminal_color_1
     :2 vim.g.terminal_color_2
     :3 vim.g.terminal_color_3
     :4 vim.g.terminal_color_4
     :5 vim.g.terminal_color_5
     :6 vim.g.terminal_color_6
     :7 vim.g.terminal_color_7
     :8 vim.g.terminal_color_8
     :9 vim.g.terminal_color_9
     :10 vim.g.terminal_color_10
     :11 vim.g.terminal_color_11
     :12 vim.g.terminal_color_12
     :13 vim.g.terminal_color_13
     :14 vim.g.terminal_color_14
     :15 vim.g.terminal_color_15}
    {:__index
     (fn [t k]
       (get-hl k))}))


(def- template
  (multiline-str
    "
      # generated from nvim colorscheme: {{scheme_name}}

      background {{Normal.bg}}
      foreground {{Normal.fg}}
      cursor {{Cursor.bg}}
      cursor_text_color background

      url_color {{13}}

      selection_background {{Visual.bg}}
      selection_foreground {{Normal.fg}}

      tab_bar_background {{BufferLineBackground.bg}}
      active_tab_background {{BufferLineBufferSelected.bg}}
      active_tab_foreground {{BufferLineBufferSelected.fg}}
      active_tab_font_style bold-italic
      inactive_tab_background {{BufferLineBackground.bg}}
      inactive_tab_foreground {{BufferLineBackground.fg}}
      inactive_tab_font_style normal

      color0 {{0}}
      color1 {{1}}
      color2 {{2}}
      color3 {{3}}
      color4 {{4}}
      color5 {{5}}
      color6 {{6}}
      color7 {{7}}
      color8 {{8}}
      color9 {{9}}
      color10 {{10}}
      color11 {{11}}
      color12 {{12}}
      color13 {{13}}
      color14 {{14}}
      color15 {{15}}
    "))

(def- fzf-template
  (multiline-str
    "
      _gen_fzf_default_opts() {
      local color00='{{Normal.bg}}'
      local color01='{{4}}'
      local color0A='{{6}}'
      local color0C='{{7}}'
      local color0D='{{1}}'
      export FZF_DEFAULT_OPTS=\"$FZF_DEFAULT_OPTS\"\\
      \" --color=dark,fg+:$color01,bg:$color00,bg+:$color00,gutter:$color00,spinner:$color0C,hl:$color0D,fg:$color04,header:$color0D,info:$color0A,pointer:$color0C,marker:$color0C,prompt:$color0A,hl+:$color0A\"
      }
      _gen_fzf_default_opts
    "))

(defn generate-kitty []
  (a.spit
    "/Users/harry/.config/kitty/nvim_auto_colors.conf"
    (lustache:render template view)))

(defn generate-fzf []
  (a.spit
    "/Users/harry/.fzf-theme.zsh"
    (lustache:render fzf-template view)))

