(module dotfiles.util.dirdiff
  {require
   {a aniseed.core
    str dotfiles.util.string}})

(def- diff-line-pattern "^([+-])MD5 %((.-)%) = %w-$")
(def- dump-command "fd -uu '.' %s -t f -x md5sum --tag {} | sort > %s")
(def- diff-command "diff %s %s --unchanged-line-format='' --old-line-format='-%%L' --new-line-format='+%%L'")

(defn- dump-hashes [dir]
  (let [file (vim.fn.tempname)]
    (vim.fn.system
      (string.format dump-command dir file))
    file))

(defn- parse-diff-line [line]
  (-> (string.match line diff-line-pattern)
      (#[$2 (if (= "-" $) -1 (= "+" $) 1 0)])))

(defn- diff-sum-iteratee [acc [file v]]
  (let [cur (or (?. acc file) 0)]
    (a.merge acc {file (+ cur v)})))

(defn- change-type [v]
  (match v 1 "created" -1 "deleted" 0 "modified"))

(defn- trim-filename [prefix f]
  (string.sub f (+ 1 (string.len prefix))))

(defn- translate-change-table [prefix changes]
  (a.map-indexed
    (fn [[k v]] (string.format "%s was %s" (trim-filename prefix k) (change-type v)))
    changes))

(defn- parse-diff [diff prefix]
  (->> diff
       (str.split "\n")
       (a.butlast)
       (a.map parse-diff-line)
       (a.reduce diff-sum-iteratee {})
       (translate-change-table prefix)))

;; STATEFUL
;; (sort of, does nothing if you don't call the result)
(defn compare [dir]
  (let [pre (dump-hashes dir)]
    #(-> diff-command
         (string.format pre (dump-hashes dir))
         (vim.fn.system)
         (parse-diff dir))))

