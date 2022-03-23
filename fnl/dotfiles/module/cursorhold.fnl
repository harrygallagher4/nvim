;; adapted from:
;; <https://raw.githubusercontent.com/gpanders/dotfiles/2dfbd5c1b56b1607149f48ce9d0dd7a910735637/.config/nvim/plugin/cursorhold.fnl>
(module dotfiles.module.cursorhold
  {require
   {options dotfiles.options}})

(local timer (vim.loop.new_timer))
(local {: oset+ : oset-} options)

(local schedule vim.schedule)
(local reg-recording vim.fn.reg_recording)
(local del-augroup vim.api.nvim_del_augroup_by_name)
(local create-augroup vim.api.nvim_create_augroup)
(local create-autocmd vim.api.nvim_create_autocmd)
(local do-autocmd vim.api.nvim_do_autocmd)
(local get-mode vim.api.nvim_get_mode)

(var timeout (or vim.g.cursorhold_updatetime 100))
(defn set-updatetime [n]
  (set timeout n))

(fn callback [event]
  (oset- :eventignore event)
  (do-autocmd event {:modeline false})
  (oset+ :eventignore event))

(fn cursor-moved []
  (timer:stop)
  (when (-> (get-mode) (. :mode) (string.sub 1 1) (= :n)
            (and (= "" (reg-recording))))
    (timer:start timeout 0 #(schedule #(callback :CursorHold)))))

(fn cursor-moved-i []
  (timer:stop)
  (when (= "" (reg-recording))
    (timer:start timeout 0 #(schedule #(callback :CursorHoldI)))))

(defn setup []
  (oset+ :eventignore [:CursorHold :CursorHoldI])
  (create-augroup "fix_cursorhold" {:clear true})
  (create-autocmd :CursorMoved {:group "fix_cursorhold" :callback cursor-moved})
  (create-autocmd :CursorMovedI {:group "fix_cursorhold" :callback cursor-moved-i}))

(defn cleanup []
  (oset- :eventignore [:CursorHold :CursorHoldI])
  (del-augroup "fix_cursorhold"))

(setup)

