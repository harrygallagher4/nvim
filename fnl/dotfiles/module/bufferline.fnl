(module dotfiles.module.bufferline
  {require {a aniseed.core
            bufferline bufferline}
   require-macros [dotfiles.maps.macros]})

(defn- numbers [{:id id :ordinal ordinal :lower lower :raise raise}]
  (let [winnr (vim.fn.bufwinnr id)]
    (if (= -1 winnr)
        (string.format "%s" id)
        (string.format "%s%s" (raise id) (lower winnr)))))

(bufferline.setup
  {:options
   {:diagnostics "nvim_lsp"
    :numbers numbers
    :separator_style "thick"}})

; (comment (bl.setup
;            {:options
;             {:diagnostics "nvim_lsp"
;              :left_trunc_marker " "
;              :modified_icon " "
;              :right_trunc_marker " "
;              :numbers numbers}}))

(vim.keymap.set :n "<leader>]" "<cmd>:BufferLineCycleNext<cr>")
(vim.keymap.set :n "<leader>[" "<cmd>:BufferLineCyclePrev<cr>")
(vim.keymap.set :n "<leader><leader>o" "<cmd>:BufferLinePick<cr>")

; (nnoremap "<leader>]" "<cmd>:BufferLineCycleNext<cr>")
; (nnoremap "<leader>[" "<cmd>:BufferLineCyclePrev<cr>")
; (nnoremap "<leader><leader>o" "<cmd>:BufferLinePick<cr>")

; (def- sample
;   {:always_show_bufferline [true false]
;    :buffer_close_icon ""
;    :close_icon ""
;    :custom_filter (fn [buf_number] true)
;    :diagnostics [false "nvim_lsp"]
;    :diagnostics_indicator (fn [count level diagnostics] (.. "(" count ")"))
;    :enforce_regular_tabs [false true]
;    :left_trunc_marker ""
;    :mappings [true false]
;    :max_name_length 18
;    :max_prefix_length 15
;    :modified_icon "●"
;    :number_style ["superscript" "" ["none" "subscript"]]
;    :numbers ["none" "ordinal" "buffer_id" "both"]
;    :persist_buffer_sort true
;    :right_trunc_marker ""
;    :separator_style ["slant" "thick" "thin" ["any" "any"]]
;    :show_buffer_close_icons [[true false]]
;    :show_close_icon [true false]
;    :show_tab_indicators [true false]
;    :sort_by ["extension" "relative_directory" "directory" (fn [a b] (> a.modified b.modified))]
;    :tab_size 18
;    :view ["multiwindow" "default"]})

