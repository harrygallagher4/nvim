(module dotfiles.scratch.maps
  {require {a aniseed.core}})

(def- none
  (setmetatable {} {:__tostring (fn [] "none")}))

(defn- resolve-default [d m]
  (match [d m]
    (where (or [none m] [nil m])) m
    (where (or [d none] [d nil])) d
    (where [d m] (a.string? d))   (.. d m)
    [d m]                         (a.merge d m)))

(defn merge-defaults [d m]
  (for [i 1 4]
    (let [dx (. d i) mx (. m i)]
      (tset m i (resolve-default dx mx))))
  m)


(defn map-multi-defaults [df mf]
  (let [defaults (df none) mappings (mf none)]
    (each [k v (ipairs mappings)]
      (a.pr (merge-defaults defaults v)))))

(map-multi-defaults
  #[$ $ $ {:buffer 1}]
  #[[:n "<c-c>" ":quit"]
    [:v "Y" "y$" {:remap false}]])

(defn map-multi-meta [x y]
  (match [x y]
    (where [f ms] (a.function? f)) "func"
    (where [s ms] (a.string? s)) (map-multi s ms)
    [ms nil] (map-multi ms)))

