;; https://raw.githubusercontent.com/gpanders/dotfiles/2dfbd5c1b56b1607149f48ce9d0dd7a910735637/.config/nvim/plugin/cursorhold.fnl
(module dotfiles.module.cursorhold
  {require {a aniseed.core
            util dotfiles.util
            options dotfiles.options}
   require-macros [dotfiles.macros]})

(local timer (vim.loop.new_timer))
(local timeout 100)
(local {: oset+ : oset-} options)

(oset+ :eventignore [:CursorHold :CursorHoldI])

(fn callback [event]
  (oset- :eventignore event)
  (util.cmd "doautocmd <nomodeline> %s" event)
  (oset+ :eventignore event))

(augroup cursorhold
  (autocmd :CursorMoved "*"
    (timer:stop)
    (let [{: mode} (vim.api.nvim_get_mode)
          reg (vim.fn.reg_recording)]
      (when (and (= :n (mode:sub 1 1)) (= "" reg))
        (timer:start timeout 0 #(vim.schedule #(callback :CursorHold))))))
  (autocmd :CursorMovedI "*"
    (timer:stop)
    (let [reg (vim.fn.reg_recording)]
      (when (= "" reg)
        (timer:start timeout 0 #(vim.schedule #(callback :CursorHoldI)))))))

