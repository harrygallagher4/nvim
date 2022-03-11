(local ffi (require :ffi))
(local nvim (require :aniseed.nvim))

; store diffs from parinfer.vim here
; (clear-logs)
; (#$ state.logs)
; (#$ state.log-storage.req)
; (#$ state.log-storage.res)
; (#$ state.log-storage.prev)
(local state {:logs [] :log-storage {:req [] :res [] :prev []}})

(fn store [k s]
  "stores a value in state.log-storage[k] and returns a string
  representing the index it was stored at"
  (table.insert (. state.log-storage k) s)
  (string.format "<%s#%s>" k (length (. state.log-storage k))))
(fn clear-logs []
  "clears state.logs and state.log-storage.*"
  (for [i 1 (length state.logs)] (table.remove state.logs))
  (each [_ v (pairs state.log-storage)]
    (for [i 1 (length v)] (table.remove v))))

(local req-filter
  {:mode true :text #(store :req $)
   :options
   {:cursorLine true :cursorX true :forceBalance false
    :prevCursorLine true :prevCursorX true :prevText #(store :prev $)}})
(local res-filter
  {:cursorLine true :cursorX true :error true :parenTrails true
   :parens true :success true :tabStops true :text #(store :res $)})

(fn filter-table [t filter-spec]
  "filter `t` by removing keys not present in `filter-spec`
  collect expects two /seperate/ bodies, one for the new key and another
  for the new value. (values k v) also works but is considered 'legacy'"
  (collect [k v (pairs t)]
    (when (. filter-spec k) k)
    (let [f (. filter-spec k)]
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

(fn has? [s] (= 1 (vim.fn.has s)))
(fn darwin? [] (= "Darwin\n" (vim.fn.system "uname")))
(fn resolve-lib []
  "adapted version of parinfer.vim#guess_dylib_path()"
  (let [libname
        (if (has? "macunix") "libparinfer_rust.dylib"
            (has? "unix") (if (darwin?) "libparinfer_rust.dylib"
                              "libparinfer_rust.so")
            (has? "win32") "parinfer_rust.dll")]
    (when libname
      (nvim.get_runtime_file (.. "target/release/" libname) false))))

(fn load-parinfer []
  (ffi.cdef "char *run_parinfer(const char *json);")
  (tset state :interface (ffi.load state.lib-path)))

; the global state variable is for logging parinfer-rust's changes in a
; more friendly format. it isn't really needed anymore but i'm leaving
; it until i've implemented the better text change mechanism using
; nvim_buf_set_text instead of nvim_buf_set_lines in order to preserve
; extmarks if possible
(fn setup-global []
  (tset state :log do-log)
  (tset _G :parinfer state))

; packadd! parinfer-rust will add the plugin to runtimepath without
; sourcing plugin/parinfer.vim. this way the library can still be
; located but parinfer.vim won't interfere
(fn setup []
  (vim.cmd "packadd! parinfer-rust")
  (tset state :lib-path (?. (resolve-lib) 1))
  (load-parinfer)
  (setup-global)
  state)

(setup)

