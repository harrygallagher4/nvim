;; adapted from:
;; <https://raw.githubusercontent.com/gpanders/dotfiles/2dfbd5c1b56b1607149f48ce9d0dd7a910735637/.config/nvim/plugin/cursorhold.fnl>
(module dotfiles.module.cursorhold
  {require {a aniseed.core
            nvim aniseed.nvim
            util dotfiles.util
            options dotfiles.options}})

(local timer (vim.loop.new_timer))
(local {: oset+ : oset-} options)
(var timeout (or vim.g.cursorhold_updatetime 100))

(defn set-updatetime [n]
  (set timeout n))

(fn callback [event]
  (oset- :eventignore event)
  (nvim.do_autocmd event {:modeline false})
  (oset+ :eventignore event))

(fn cursor-moved []
  (timer:stop)
  (when (and (-> (nvim.get_mode) (. :mode) (string.sub 1 1) (= :n))
             (= "" (vim.fn.reg_recording)))
    (timer:start timeout 0 #(vim.schedule #(callback :CursorHold)))))

(fn cursor-moved-i []
  (timer:stop)
  (when (= "" (vim.fn.reg_recording))
    (timer:start timeout 0 #(vim.schedule #(callback :CursorHoldI)))))

(defn setup []
  (oset+ :eventignore [:CursorHold :CursorHoldI])
  (nvim.create_augroup "fix_cursorhold" {:clear true})
  (nvim.create_autocmd :CursorMoved {:group "fix_cursorhold" :callback cursor-moved})
  (nvim.create_autocmd :CursorMovedI {:group "fix_cursorhold" :callback cursor-moved-i}))

(defn cleanup []
  (oset- :eventignore [:CursorHold :CursorHoldI])
  (nvim.del_augroup "fix_cursorhold"))

(setup)

