(module dotfiles.module.galaxyline
  {require {a aniseed.core
            str aniseed.string
            nvim aniseed.nvim
;            fileinfo galaxyline.provider_fileinfo
            devicons nvim-web-devicons}})

; (vim.api.nvim_get_runtime_file "lua/packer.lua" false)


(defn- get-file-info []
  (unpack [(vim.fn.expand "%:t") (vim.fn.expand "%:e")]))

(defn- percent [n d]
  (.. (math.modf (* 100 (/ n d))) "%"))

(defn- format-file-size [size]
  (if (< size (^ 1024 0)) ""
      (< size (^ 1024 1)) (.. size "b")
      (< size (^ 1024 2)) (.. (string.format "%.1f" (/ size (^ 1024 1))) "k")
      (< size (^ 1024 3)) (.. (string.format "%.1f" (/ size (^ 1024 2))) "m")
      (.. (string.format "%.1f" (/ size (^ 1024 3))) "㎇")))

(defn- file_symbol []
  (match [vim.bo.readonly vim.bo.filetype vim.bo.modifiable vim.bo.modified]
    (where [true ft _ _] (not= "help" ft)) ""
    [_ _ true true] " "
    [_ _ _ _] nil))

(defn get_filetype_icon []
  (let [(icon group) (devicons.get_icon nvim.bo.filetype)]
    (or icon "?")))

(defn get_filetype_icon_group []
  (let [(icon group) (devicons.get_icon nvim.bo.filetype)]
    (or group "Normal")))

(defn get_filetype_icon_fg []
  (let [(icon group) (devicons.get_icon nvim.bo.filetype)]
    (if (not (nil? group))
        (string.format "#%x" (a.get (vim.api.nvim_get_hl_by_name group true) :foreground 0))
        "#ffffff")))

(defn get_filetype_icon_bg []
  (let [(icon group) (devicons.get_icon nvim.bo.filetype)]
    (if (not (a.nil? group))
        (string.format "#%x" (a.get (vim.api.nvim_get_hl_by_name group true) :background 0))
        "#ffffff")))

; @Provider
(defn file_icon []
  (.. (get_filetype_icon) " "))

; @Provider
(defn file_name []
  (let [file (vim.fn.expand "%:t")]
    (if (= 1 (vim.fn.empty file)) ""
        (str.join " " (a.concat [file] [(file_symbol)])))))

; @Provider
(defn file_size []
  (format-file-size (vim.fn.getfsize (vim.fn.expand "%:p"))))

; @Provider
(defn file_encoding []
  (if (~= "" vim.bo.fenc) vim.bo.fenc vim.o.enc))

; @Provider
(defn file_format [] vim.bo.fileformat)

; @Provider
(defn cursor_coordinates []
  (str.join ":" [(vim.fn.line ".") (vim.fn.col ".")]))

; @Provider
(defn cursor_percentage []
  (let [line (vim.fn.line ".")
        total (vim.fn.line "$")]
    (match line 1 "top" total "bot" _ (percent line total))))

; @Provider
(defn window_number []
  (str.join "" ["❰" (vim.fn.winnr) "❱"]))

; @Provider
(defn buffer_filetype [] vim.bo.filetype)

;   Notes
; =========
;
; (vim.api.nvim_win_get_option 1008 "statusline")
; autocmd! harry WinLeave * echomsg win_getid()
; GalaxyBufferType xxx guifg=#312926 guibg=#51a0cf
; (vim.api.nvim_win_set_option 1008 "statusline" "%#GalaxyWinNrNC#%{luaeval('require(\"galaxyline\").component_decorator')(\"WinNrNC\")}%#WinNrNCSeparator# %#GalaxySFileName#%{luaeval('require(\"galaxyline\").component_decorator')(\"SFileName\")}%#GalaxyBufferTypeLua#%{luaeval('require(\"galaxyline\").component_decorator')(\"BufferType\")}%#BufferTypeSeparator# %=%#GalaxyBufferIcon#%{luaeval('require(\"galaxyline\").component_decorator')(\"BufferIcon\")}%#GalaxyWinIdCustom#%{luaeval('require(\"galaxyline\").component_decorator')(\"WinIdCustom\")}")
; (vim.api.nvim_win_set_option 1008 "winhighlight" "GalaxyBufferType:DevIconLua")
;
; @wrap:
; > downcase and trim builtin galaxyline components"}})
; (defn wrap [p]
;   (let [provider (get fileinfo p)]
;     (fn [] (let [s (provider)]
;              (str.trim (s:lower))))))
; ((wrap :get_file_format))
; ((wrap :get_current_file_name))
;
; @window_number
; ⁰¹²³⁴⁵⁶⁷⁸⁹ ₀₁₂₃₄₅₆₇₈₉
;「」『』«»❨❩❪❫〈〉《》❲❳⦗⦘〔〕❬❭❰❱ ⌜⌝⌞⌟
; ⌜⌝⌞⌟
; ⸢⸣⸤⸥﹪﹙﹚﹛﹜﹝﹞🯰🯱🯲🯳🯴🯵🯶🯷🯸🯹
;
; @format_fille_size
; ㎅ ㎆ ㎇
;  (if (or (= 0 size) (= -1 size) (= -2 size)) "")
;

