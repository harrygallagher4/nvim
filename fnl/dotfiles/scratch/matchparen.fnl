(module dotfiles.scratch.matchparen
  {require {nvim aniseed.nvim
            util dotfiles.util}})
;;
;; just realized I committed this file earlier so if someone is reading this:
;; this module doesn't actually do anything, I was just messing around with
;; nvim-ts-rainbow to see if I could highlight the parens containing the
;; cursor easily. results are mixed lol, I might mess with this more
;;

(def- ns (. (nvim.get_namespaces) :rainbow_ns))
(def- autocmd-group "rainbow_matchparen")

; {:hl_group "rainbowcol1" :end_col 0 :end_row 0 :priority 120 ...}
; [... :hl_eol :right_gravity :end_right_gravity]
(def- ctx {:mark nil})
(defn- set-mark! [m]
  (tset ctx :mark (. m 3)))

(defn- get-cursor-extmark []
  (let [[cx- cy] (nvim.win_get_cursor 0)
        cx (- cx- 1)
        cpos [cx cy]
        [mark] (nvim.buf_get_extmarks 0 ns cpos cpos {})]
    (when mark
      (nvim.buf_get_extmark_by_id 0 ns (. mark 1) {:details true}))))

(defn- set-hl! []
  (util.cmd "highlight %s gui=bold" ctx.mark.hl_group))
(defn- unset-hl! []
  (util.cmd "highlight %s gui=NONE" ctx.mark.hl_group))

(defn cursor_moved []
  (let [mark (get-cursor-extmark)]
    (when ctx.mark (unset-hl!))
    (when mark
      (set-mark! mark)
      (set-hl!))))

; (setup)
(defn setup []
  (util.cmd "augroup %s" autocmd-group)
  (util.cmd "autocmd!")
  (util.cmd "autocmd CursorMoved <buffer> lua require'%s'.cursor_moved()" *module-name*)
  (util.cmd "augroup END"))

(defn disable []
  (util.cmd "autocmd! %s" autocmd-group))

