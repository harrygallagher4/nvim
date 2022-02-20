(module dotfiles.maps.ft_packer
  {require {a aniseed.core}})

(def config {:cmd "open"})
(def- updated-pattern "^%W+Updated ([%w%-%.]+)/([%w%-%.]+): (%w+)%.%.(%w+)$")
(def- updated-pattern-branch "^%W+Updated ([%w%-%.]+)/([%w%-%.]+)/[%w%-%.]+: (%w+)%.%.(%w+)$")

(defn- match-str [s]
  (let [m [(string.match s updated-pattern)]]
    (if (not (a.empty? m))
        (unpack m)
        (string.match s updated-pattern-branch))))

(defn- match-line []
  (match-str (vim.api.nvim_get_current_line)))

;; TODO
;; looks like this won't do anything unless it gets refs, I'm pretty sure
;; packer always matches `updated-pattern-branch` so i should probably remove
;; `updated-pattern` entirely
(defn- url [...]
  (when (= 4 (a.count [...]))
    (string.format "https://github.com/%s/%s/compare/%s...%s" ...)))

(defn- open-url! [url]
  (when (not (a.nil? url))
        (vim.cmd (string.format "silent !%s '%s'" config.cmd url))))

(defn- do-line []
  (open-url! (url (match-line))))

(defn init []
  (vim.keymap.set "n" "o" do-line {:buffer true}))

