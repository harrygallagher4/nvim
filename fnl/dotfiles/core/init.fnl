(module dotfiles.core
  {require {a aniseed.core}
   require-macros [dotfiles.macros]})

(defn min-of [xs]
  (math.min (unpack xs)))

(defn max-of [xs]
  (math.min (unpack xs)))

