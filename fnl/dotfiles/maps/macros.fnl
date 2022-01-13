{
 :map_gen       (fn [f lhs rhs ...]
                  (let [a# [lhs rhs] o# [...]]
                    (while (< 0 (length o#))
                      (tset a# (table.remove o# 1) (table.remove o# 1)))
                    `(,(sym (.. "vim._keymap." f)) ,a#)))
 :tc            (fn [str]
                  (_G.vim.api.nvim_replace_termcodes str true true true))
 :cmap          (fn [...]
                  `(map_gen :cmap ,...))
 :cnoremap      (fn [...]
                  `(map_gen :cnoremap ,...))
 :imap          (fn [...]
                  `(map_gen :imap ,...))
 :inoremap      (fn [...]
                  `(map_gen :inoremap ,...))
 :lmap          (fn [...]
                  `(map_gen :lmap ,...))
 :lnoremap      (fn [...]
                  `(map_gen :lnoremap ,...))
 :map           (fn [...]
                  `(map_gen :map ,...))
 :nmap          (fn [...]
                  `(map_gen :nmap ,...))
 :nnoremap      (fn [...]
                  `(map_gen :nnoremap ,...))
 :keymap.nnoremap (fn [...]
                    `(map_gen :nnoremap ,...))
 :noremap       (fn [...]
                  `(map_gen :noremap ,...))
 :omap          (fn [...]
                  `(map_gen :omap ,...))
 :onoremap      (fn [...]
                  `(map_gen :onoremap ,...))
 :smap          (fn [...]
                  `(map_gen :smap ,...))
 :snoremap      (fn [...]
                  `(map_gen :snoremap ,...))
 :tmap          (fn [...]
                  `(map_gen :tmap ,...))
 :tnoremap      (fn [...]
                  `(map_gen :tnoremap ,...))
 :vmap          (fn [...]
                  `(map_gen :vmap ,...))
 :vnoremap      (fn [...]
                  `(map_gen :vnoremap ,...))
 :xmap          (fn [...]
                  `(map_gen :xmap ,...))
 :xnoremap      (fn [...]
                  `(map_gen :xnoremap ,...))}

