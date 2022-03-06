(local ffi (require :ffi))
(local util (require :dotfiles.util))
(local a (require :aniseed.core))

(local state
  {:logs []
   :log-storage {:req [] :res [] :prev []}})

;; store diffs from parinfer.vim here
;; (clear-logs)

; (local logs [])
; (local log-storage {:req [] :res [] :prev []})

(fn store [k s]
  (table.insert (. state.log-storage k) s)
  (string.format "<%s#%s>" k (length (. state.log-storage k))))
(fn clear-logs []
  (for [i 1 (length state.logs)] (table.remove state.logs))
  (each [_ v (pairs state.log-storage)]
    (for [i 1 (length v)] (table.remove v))))

(local req-filter
  {:mode true
   :text #(store :req $)
   :options
   {:cursorLine true
    :cursorX true
    :forceBalance false
    :prevCursorLine true
    :prevCursorX true
    :prevText #(store :prev $)}})
(local res-filter
  {:cursorLine true
   :cursorX true
   :error true
   :parenTrails true
   :parens true
   :success true
   :tabStops true
   :text #(store :res $)})

(fn filter-table [t ft]
  "filter `t` by removing keys not present in `ft`
  collect expects two /seperate/ bodies, one for the new key and another
  for the new value. (values k v) also works but is considered 'legacy'"
  (collect [k v (pairs t)]
    (when (. ft k) k)
    (let [f (. ft k)]
      (if (= "table" (type f)) (filter-table v f)
          (= "function" (type f)) (f v)
          v))))

(fn log-request [req] (filter-table req req-filter))
(fn log-response [res] (filter-table res res-filter))
(fn do-log [req res from to]
  (table.insert
    state.logs
    [(log-request req)
     (log-response res)
     (vim.diff from to {:result_type :indices})]))

(fn has [s] (= 1 (vim.fn.has s)))
(fn uname-darwin? [] (= "Darwin\n" (vim.fn.system "uname")))
(fn resolve-lib []
  "adapted version of parinfer.vim#guess_dylib_path()"
  (let [libname
        (if (has "macunix") "libparinfer_rust.dylib"
            (has "unix") (if (uname-darwin?)
                             "libparinfer_rust.dylib"
                             "libparinfer_rust.so")
            (has "win32") "parinfer_rust.dll"
            nil)]
    (when libname
      (vim.api.nvim_get_runtime_file (.. "target/release/" libname) false))))

(fn load-parinfer []
  (ffi.cdef "char *run_parinfer(const char *json);")
  (tset state :interface (ffi.load state.lib-path)))

(fn setup-global []
  (tset state :log do-log)
  (tset _G :parinfer state))
  ; (tset _G :parinfer
  ;   {:interface state.interface
  ;    :log do-log}))

(fn setup []
  (tset state :lib-path (?. (resolve-lib) 1))
  (load-parinfer)
  (setup-global))


(setup)
state

