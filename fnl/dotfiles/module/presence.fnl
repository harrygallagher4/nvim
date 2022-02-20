(module dotfiles.module.presence
  {require {a aniseed.core
            u dotfiles.util
            cmd dotfiles.commands}
   autoload {: presence}})

(def- state {:started false})
(defn setup [...] (: presence :setup ...))

(defn- start-if-necessary! []
  (when (not state.started)
    (setup
      {:auto_update 0
       :main_image "neovim" ; or "file"
       :buttons true
       :blacklist []})
    (presence:handle_focus_gained)
    (u.cmd "augroup dotfiles_presence")
    (u.cmd "au VimLeavePre * lua require'%s'.stop()" *module-name*)
    (u.cmd "augroup END")
    (tset state :started true)))

(defn start []
  (start-if-necessary!))

(defn update []
  (start-if-necessary!)
  (vim.schedule_wrap #(presence.handle_buf_enter)))

(defn stop []
  (presence:handle_vim_leave_pre))

(cmd.mod-cmd! :PresenceStart *module-name* :start)
(cmd.mod-cmd! :PresenceStop *module-name* :stop)
(cmd.mod-cmd! :PresenceUpdate *module-name* :update)

