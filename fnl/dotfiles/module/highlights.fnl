(module dotfiles.module.highlights
  {require {a aniseed.core
            str aniseed.string
            nvim aniseed.nvim
            lush lush
            colorizer colorizer}
   require-macros [dotfiles.macros
                   dotfiles.highlight.macros]})

; (let [info (require "galaxyline.provider_fileinfo")]
;   (identity (info.get_current_file_name)))
; (let [status (get (require "galaxyline") :section)]
;   (assoc! status :mid []))
;  (assoc! status :mid [{:FennelTest {:provider (constantly "Fennel!")}}])
;  (assoc! status.mid 1 {:FennelTest {:provider "GetLspClient"}}))

(colorizer.setup nil {:names false :mode "both"})
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
      (get gruvbox color)))
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
(defn- h [c] (get c :h))
(defn- s [c] (get c :s))
(defn- l [c] (get c :l))




; (hln! :TelescopeNormal :Pmenu)
; (hln! :TelescopePreviewNormal :Pmenu)
; (hl!  :TelescopeBorder (fg :#1f2335) (bg :#1f2335))


(global harryg_
  (fn []
    (a.map
      #[(vim.api.nvim_buf_get_name $)
        (vim.api.nvim_buf_get_option $ :filetype)
        (vim.api.nvim_buf_get_option $ :buftype)]
      (vim.api.nvim_list_bufs))))


; (defn melange-greys []
;   (values
;     (map tostring
;       [(hsl 30 10 15)
;        (hsl 30 10 20)
;        (hsl 30 15 30)
;        (hsl 30 20 35)
;        (hsl 30 20 55)
;        (hsl 30 30 90)])
;     (map tostring
;       [(hsl 30 10 15)
;        (-> (hsl 30 10 15)
;            (lighten 5))
;        (-> (hsl 30 10 15)
;            (lighten 5) (lighten 5))
;        (-> (hsl 30 10 15)
;            (lighten 5) (lighten 5) (lighten 20) (saturate 10))
;        (-> (hsl 30 10 15)
;            (lighten 5) (lighten 5) (lighten 20) (saturate 10) (lighten 10))
;        (-> (hsl 30 10 15)
;            (lighten 5) (lighten 5) (lighten 20) (saturate 10) (lighten 10) (lighten 20))
;        (-> (hsl 30 10 15)
;            (lighten 5) (lighten 5) (lighten 20) (saturate 10) (lighten 10) (lighten 20) (lighten 70))
;        (-> (hsl 30 10 15)
;            (lighten 5) (lighten 5) (lighten 20) (saturate 10) (lighten 10) (lighten 20) (lighten 70) (lighten 80))])))

; (let [(a b) (melange-greys)]
;   [[(. b 1) (. a 1)]
;    [(. b 2) (. a 2)]
;    [(. b 3)]
;    [(. b 4) (. a 3)]
;    [(. b 5) (. a 4)]
;    [(. b 6) (. a 5)]
;    [(. b 7) (. a 6)]
;    [(. b 8)]])

;
; galaxyline
;
; (def- galaxyline-bg (color-> :bg0 (darken 10) (saturate 10)))

; (defn- gruvgalaxy [key color]
;   (assoc-in! (require "galaxyline.theme") [:default key] (resolve-color color)))
; (each [k v (pairs
;              {:bg galaxyline-bg
;               :fg :fg4
;               :scroll :faded_blue
;               :red :neutral_red
;               :orange :neutral_orange
;               :yellow :neutral_yellow
;               :green :neutral_green
;               :cyan :neutral_aqua
;               :blue :neutral_blue
;               :magenta :neutral_purple
;               :violet :purple})]
;   (gruvgalaxy k v))

; (defonce- statusline (require "evilline"))

; (hln! :Normal :GruvboxFg3)
; (hln! :NormalFloat :Pmenu)
; (hln! :Function :GruvboxYellow)
; (hln! :Keyword :GruvboxRedBold)
; (hln! :TelescopeNormal :GruvboxFg3)
; (hln! :TelescopeBorder :GruvboxBg4)
; (hln! :TelescopePromptBorder :GruvboxBg4)
; (hln! :TelescopePreviewBorder :GruvboxBg4)
; (hln! :TelescopeResultsBorder :GruvboxBg4)
; (hln! :TSNone :Normal)
; (hln! :MsgArea :GruvboxFg4)
; (hl!  :MsgArea (fg :fg3))
; (hl!  :ModeMsg (fg :green) (bg :NONE) (gui :bold))
; (hl!  :LineNr (fg :bg3) (bg :NONE))
; (hl!  :SignColumn (bg :NONE))
; (hl!  :CursorLineNr (fg :aqua) (bg :NONE) (gui :bold))
; (hl!  :CursorLine (bg :NONE))
; (hl!  :Visual (bg :bg2))
; (hl!  :StatusLine (fg :NONE) (bg galaxyline-bg))
; (hl!  :StatusLineNC (fg :bg0) (bg galaxyline-bg))
; (hl!  :TelescopeSelection (fg :fg3) (bg :dark0))
; (hl!  :TelescopeMatching (fg :yellow) (gui :bold))
; (hl!  :Pmenu (fg :fg2) (bg :bg1))
; (hl!  :PmenuSel (fg :bg0) (bg :neutral_purple))
; (hl!  :PmenuThumb (bg :faded_purple))
; (hl!  :PmenuSbar (bg :bg1))

; (comment
;   (let [hlstr (nvim.fn.execute "highlight CursorColumn")]
;     (string.match hlstr "%Wguibg=([#%w]+)")
;     (string.match "GruvboxFg1     xxx guifg=#ebdbb2 guibg=#ffffff fg=1" "%Wguifg=([%w#]+)")
;     (string.match "                   links to GruvboxRedBold" "links to (%w+)%c?"))
;   (str.split (nvim.fn.execute "highlight Directory") "\n")                   
;   (str.split                                                                 
;     (first
;       (filter notblank?                                                 
;               (str.split (nvim.fn.execute "highlight Directory") "\n")))
;     "Directory%s+xxx"))                                                     

; (comment (let [purple (hsl gruvbox.purple)]
;            (-> purple
;                (rotate 180)
;                (tostring))))

; (comment (let [purple (hsl gruvbox.purple)
;                dark (purple.darken 10)]
;            (tostring dark)))

; (comment (let [x 1]
;            (macro hl! [group ...] `(-> ,group (hlclear!) (hi! ,...)))))
; (macrodebug (hl! :Function (fg :bg3)))
; (macrodebug (hln! :Normal :GruvboxFg3))

; (vim.inspect (vim.api.nvim_get_hl_by_name "ErrorMsg" true))
; (string.format "%x" 16468276)
; (vim.api.nvim_get_context {})
; (vim.api.nvim__get_hl_defs 0)
; (vim.api.nvim_get_color_map)
; (vim.api.nvim_get_mode)

;
; color functions from vimrc
;
; function harryg#colors#base16()
;     call g:Base16hi("VertSplit", g:base16_gui01, "none", "", "", "bold", "")
;     call g:Base16hi("StatusLine", "", "none", "", "", "", "")
;     call g:Base16hi("StatusLineNC", "", "none", "", "", "", "")
;     call g:Base16hi("MatchParen", "", g:base16_gui02, "", "", "bold", "")
;     call g:Base16hi("EndOfBuffer", g:base16_gui00, g:base16_gui00, "", "", "", "")
;     call g:Base16hi("Cursor", g:base16_gui00, g:base16_gui04, "", "", "", "")
;     call g:Base16hi("CursorLineNr", g:base16_gui05, "", "", "", "italic", "")
;
;     highlight clear CursorLine
;     highlight CursorLineNr guibg=NONE
;     highlight LineNr guibg=NONE gui=italic
;     highlight SignColumn guibg=NONE
; endfunction
;
; function harryg#colors#gruvbox()
;     if exists("g:fzf_colors")
;         unlet g:fzf_colors['bg']
;     endif
;     highlight LineNr guibg=NONE
;     highlight SignColumn guibg=NONE
;     highlight CursorLine guibg=NONE
;     highlight CursorLineNr guibg=NONE
; endfunction
;

