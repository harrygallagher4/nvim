(module dotfiles.maps.ft_packer)

(def config {:cmd "open"})
(local url-pattern "^  URL: (.+)$")

(local pat-format
  [[url-pattern
    #["%s" $2]]
   ["    %x+ .+ %(#?(%d+)%) %(%d+ %w+ ago%)"
    #["%s/pull/%s" $.url $2]]
   ["    %x+ .+ #(%d+) %(%d+ %w+ ago%)"
    #["%s/pull/%s" $.url $2]]
   ["    %x+ Merge pull request #(%d+) from .+%(%d+ %w+ ago%)"
    #["%s/pull/%s" $.url $2]]
   ["^%W+Updated ([%w%-%.]+/[%w%-%.]+): (%w+)%.%.(%w+)$"
    #["https://github.com/%s/compare/%s...%s" $2 $3 $4]]
   ["^%W+Updated ([%w%-%.]+/[%w%-%.]+)/[%w%-%.]+: (%w+)%.%.(%w+)$"
    #["https://github.com/%s/compare/%s...%s" $2 $3 $4]]
   ["    (%x+) .+ %(%d+ %w+ ago%)"
    #["%s/commit/%s" $.url $2]]])

; this works to create a map of line->last url.
; i only had an old log saved so it probably needs to be tested on a
; more recent packer log buffer
(fn line-to-url-map []
  (accumulate [urls []
               i line (ipairs (vim.api.nvim_buf_get_lines 0 0 -1 false))]
    (let [url (string.match line url-pattern)
          prev (or (. urls (- i 1)) 0)]
      (if url (table.insert urls url)
          (table.insert urls prev))
      urls)))

(fn current-line-url []
  (let [urls (line-to-url-map)
        [line] (vim.api.nvim_win_get_cursor 0)]
    (. urls line)))

(fn extract-current-url []
  (let [url (current-line-url)
        line (vim.api.nvim_get_current_line)]
    (var matched nil)
    (each [_ [p f] (pairs pat-format) :until matched]
      (let [m [(string.match line p)]]
        (when (< 0 (length m))
          (->> (f {: url :match m} (unpack m))
               (unpack)
               (string.format)
               (set matched)))))
    matched))

(fn open-url! [url]
  (when (not= nil url)
        (vim.cmd (string.format "silent !%s '%s'" config.cmd url))))

(fn do-line []
  (open-url! (extract-current-url)))

(defn init []
  (vim.keymap.set "n" "o" do-line {:buffer true}))

