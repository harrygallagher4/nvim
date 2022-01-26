(module dotfiles.module.conjure
  {require {a aniseed.core
            o dotfiles.options}})

(o.gset "conjure#log#jump_to_latest#enabled" true)
(o.gset "conjure#log#jump_to_latest#cursor_scroll_position" "top")

