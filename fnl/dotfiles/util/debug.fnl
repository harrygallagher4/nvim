(module dotfiles.util.debug
  {require
   {a aniseed.core
    util dotfiles.util}})

(local state {:logs [] :storage {} :filters {}})

(fn store [k s]
  "stores a value in state.log-storage[k] and returns a string
  representing the index it was stored at"
  (when (= nil (. state.storage k))
    (tset state :storage k []))
  (table.insert (. state.storage k) s)
  (string.format "<%s#%s>" k (length (. state.storage k))))

(fn clear-logs []
  "clears state.logs and state.log-storage.*"
  (for [i 1 (length state.logs)] (table.remove state.logs))
  (each [_ v (pairs state.storage)]
    (for [i 1 (length v)] (table.remove v))))

(fn add-type [ltype f]
  (tset state.filters ltype f))

; these are holdovers from parinfer logging
(add-type :req
  {:text #(store :req $)
   :options {:forceBalance false :prevText #(store :prev $)}})
(add-type :res
  {:text #(store :res $)})

(fn filter-table [t filter-spec]
  "filter `t` by removing keys not present in `filter-spec`
  collect expects two /seperate/ bodies, one for the new key and another
  for the new value. (values k v) also works but is considered 'legacy'"
  (collect [k v (pairs t)]
    (when (not= false (. filter-spec k)) k)
    (let [f (. filter-spec k)]
      (if (= "table" (type f)) (filter-table v f)
          (= "function" (type f)) (f v)
          v))))

(fn log* [data]
  (let [s (if (a.string? data) data
              (a.pr-str data))]
    (table.insert state.logs data)
    (util.cmd "echomsg %s" s)))

(fn log [ltype l]
  (let [to-log (if (= nil l) ltype
                   (= nil (. state.filters ltype)) l
                   (filter-table l (. state.filters ltype)))]
    (log* to-log)))

{: log : clear-logs : add-type : state}

