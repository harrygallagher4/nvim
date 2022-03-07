(module dotfiles.compile
  {require
   {a aniseed.core
    env aniseed.env
    fs aniseed.fs
    fennel aniseed.fennel
    compile aniseed.compile
    str dotfiles.util.string
    dirdiff dotfiles.util.dirdiff
    util dotfiles.util}})

(defn- set-minus [s1 s2]
  (icollect [_ v (ipairs s1)]
    (when (not (vim.tbl_contains s2 v)) v)))

(def- config-root (vim.fn.stdpath :config))
(defn- config-dir [dir] (vim.fn.expand (.. config-root fs.path-sep dir)))
(defn- fnl-file? [path] (= (vim.fn.fnamemodify path ":e") "fnl"))
(def- fnl-dir (config-dir "fnl"))
(def- lua-dir (config-dir "lua"))


(defn- time-changed [path]
  (-> (vim.loop.fs_stat path)
      (. :mtime)
      (. :sec)))

(defn- file-times [paths]
  (a.reduce
    #(a.merge $ {$2 (time-changed $2)})
    {} paths))

(defn- glob-times [path glob]
  (file-times (util.glob (.. path "/" glob))))

(defn- time-differences? [ftimes]
  (let [files (a.keys ftimes)
        current-times (file-times files)]
    (a.filter #(~= (. ftimes $) (. current-times $)) files)))

(defn- is-aniseed-module? [path]
  (if (fnl-file? path) true
      (with-open [f (io.open path)]
        (a.string? (string.match (f:read) "^local _2afile_2a = .*$")))))

(defn- filter-unmanaged [files]
  (icollect [k v (ipairs files)]
    (when (is-aniseed-module? v) v)))

(defn- compiled-name [file]
  (if (string.match file "/macros.fnl$") file
      (string.gsub file "fnl$" "lua")))

(defn- compiled-files []
  (let [fnlfiles (fs.relglob fnl-dir "**/*.fnl")]
    (a.map #(.. lua-dir (compiled-name $)) fnlfiles)))

(defn clean! []
  (let [dirty (-> (vim.fn.globpath lua-dir "**/*.*" true true)
                  (filter-unmanaged)
                  (set-minus (compiled-files)))]
    (a.run! os.remove dirty)))

; manually compile everything in ~/.config/nvim/fnl
(defn compile-all! []
  (fennel.add-path (.. fnl-dir fs.path-sep "?.fnl"))
  (compile.glob "**/*.fnl" fnl-dir lua-dir {}))

; well, apparently aniseed compiles the entire directory if any file is
; changed, so unfortunately it isn't possible to detect *which* files
; were compiled without reading all of them before & after
(defn aniseed-compile! []
  (let [dir (util.stdfile "config" "lua/")
        cmp (dirdiff.compare dir)]
    (env.init {:module "dummy" :compile true})
    (let [lines (cmp)]
      (if (> (length lines) 0)
          (vim.notify (a.concat ["Compiled!"] lines) vim.log.levels.INFO)
          (vim.notify "Nothing to compile" vim.log.levels.WARN)))))

; this isn't used anywhere but I thought I'd make a function out of it
; (aniseed-reload "dotfiles" "^dotfiles%..+") uncaches `dotfiles` and
; all `dotfiles.*` modules, then requires `dotfiles`
(defn aniseed-reload [mod prefix-pattern]
  (each [k _ (ipairs package.loaded)]
    (when (or (= mod k) (string.match k prefix-pattern))
      (tset package.loaded k nil)))
  (env.init {:module mod :compile true}))

