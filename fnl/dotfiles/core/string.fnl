(module dotfiles.core.string
  {require {a aniseed.core
            str aniseed.string
            core dotfiles.core}})

(defn splitter [pat]
  (fn [s] (str.split s pat)))

(def split
  (lambda split [pat ?s]
    (if ?s (str.split ?s pat)
           (splitter pat))))

(defn trim-multiline [s]
  (->> s
       (split "\n")
       (a.map str.trim)
       (str.join "\n")))

(defn common-indent [s]
  (->> s
       (split "\n")
       (a.map #(string.match $ "^(%s+)%S"))
       (a.map string.len)
       (core.min-of)))

(defn trim-leading-spaces [indent input]
  (let [f (fn [s] (if (string.match s (.. "^" (string.rep "%s" indent)))
                      (string.sub s (+ 1 indent))
                      (string.match s "^%s+$")
                      ""
                      s))]
    (if (a.nil? input) f (f input))))

(defn trim-common [s]
  (let [indent (common-indent s)
        lines (split "\n" s)]
    (->> lines
        (a.map (trim-leading-spaces indent))
        (str.join "\n"))))

(defn multiline-str [s]
  (->> s
       (split "\n")
       (a.rest)
       (str.join "\n")
       (trim-common)))

