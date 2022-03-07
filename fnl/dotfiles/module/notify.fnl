(module dotfiles.module.notify
  {require {a aniseed.core notify notify}
   autoload {default-renderer notify.render.default
             minimal-renderer notify.render.minimal}})

(local vim-notify vim.notify)
(local vim-notify-once vim.notify_once)

(fn pad-message-line [s] (.. " " s))
(fn pad! [notification]
  (tset
    notification :message
    (a.map pad-message-line notification.message))
  notification)

(defn default-pad [bufnr notif highlights]
  (default-renderer bufnr (pad! notif) highlights))

(defn minimal-pad [bufnr notif highlights]
  (minimal-renderer bufnr (pad! notif) highlights))

(defn setup []
  (notify.setup {:render default-pad})
  (tset vim :notify notify))

(defn cleanup []
  (tset vim :notify vim-notify)
  (tset vim :notify_once vim-notify-once))

(setup)

