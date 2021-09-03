(module dotfiles.util.neoformat
  {require {a aniseed.core
            nvim aniseed.nvim}})

(defn- coerce-to-seq [s]
  (match s
    (x ? (a.table? x)) x
    (x ? (a.string? x)) [x]))

(defn- as-seq [[k v]]
  [k (coerce-to-seq v)])

(defn- set-formatter! [[k v]]
  (a.assoc vim.g (.. :neoformat_enabled_ k) v))

(defn init [formatters]
  (->> formatters
       (a.map-indexed as-seq)
       (a.run! set-formatter!)))

