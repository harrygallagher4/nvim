(module dotfiles.compile
  {require {a aniseed.core
            env aniseed.env
            fs aniseed.fs
            fennel aniseed.fennel
            compile aniseed.compile}})

(defn- set-minus [s1 s2]
  (icollect [_ v (ipairs s1)]
    (when (not (vim.tbl_contains s2 v)) v)))

(def- config-root (vim.fn.stdpath :config))
(defn- config-dir [dir] (vim.fn.expand (.. config-root fs.path-sep dir)))
(defn- fnl-file? [path] (= (vim.fn.fnamemodify path ":e") "fnl"))
(def- fnl-dir (config-dir "fnl"))
(def- lua-dir (config-dir "lua"))

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

(defn aniseed-compile! []
  (env.init {:module "init" :compile true}))

