(module dotfiles.util.string
  {require {a aniseed.core
            str aniseed.string
            util dotfiles.util}})

(defn chars [s]
  (vim.split s ""))

(defn formatter [...]
  (let [args [...]]
    (fn [s] (string.format s (unpack args)))))

(defn splitter [pat]
  (fn [s] (str.split s pat)))

; aniseed.string (split s pat)
;
; maybe I should stick to the aniseed signature
; if this is called with 2 arguments?
(def split
  (lambda split [pat ?s]
    (if ?s (str.split ?s pat)
           (splitter pat))))

; (aniseed.string.join [xs] [sep xs])
(def join str.join)
; (aniseed.string.blank? s)
(def blank? str.blank?)
; (aniseed.string.triml s)
(def triml str.triml)
; (aniseed.string.trimr s)
(def trimr str.trimr)
; (aniseed.string.trim s)
(def trim str.trim)

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
       (util.min-of)))

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

