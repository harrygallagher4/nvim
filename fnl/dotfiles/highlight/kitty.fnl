(module dotfiles.highlight.kitty
  {require {a aniseed.core
            str dotfiles.util.string
            lustache lustache}})

(def- ffffff 16777215)

(defn- safe-bg [group]
  (string.format "#%06x" (a.get group :background ffffff)))
(defn- safe-fg [group]
  (string.format "#%06x" (a.get group :foreground ffffff)))
(defn- get-bg [group]
  (if (a.get group :reverse false)
      (safe-fg group)
      (safe-bg group)))
(defn- get-fg [group]
  (if (a.get group :reverse false)
      (safe-bg group)
      (safe-fg group)))

(defn- get-hl [group]
  (-> (vim.api.nvim_get_hl_by_name group true)
      (#{:bg (get-bg $) :fg (get-fg $)})))

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
  (str.multiline-str
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
  (str.multiline-str
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

; after this is generated the theme can be reloaded with:
; > kitty @ set-colors --all --configured ~/.config/kitty/nvim_auto_colors.conf
(defn generate-kitty! []
  (->>
    (lustache:render template view)
    (a.spit "/Users/harry/.config/kitty/nvim_auto_colors.conf")))

(defn generate-fzf! []
  (->>
    (lustache:render fzf-template view)
    (a.spit "/Users/harry/.fzf-theme.zsh")))

