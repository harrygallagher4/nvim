(module dotfiles.module.telescope
  {require {a aniseed.core
            str aniseed.string
            util dotfiles.util
            telescope telescope
            builtin telescope.builtin
            actions telescope.actions
            p-actions telescope._extensions.project.actions
            themes telescope.themes
            devicons nvim-web-devicons
            trouble trouble.providers.telescope}})

; (setup {:default true
;         :override {:fnl {:icon ""
;                          :color "#7bc45c"
;                          :name "fennel"}}})

(defn setup_devicons []
  (devicons.setup
    {:default true
     :override
     {:fnl
      {:icon "" :color "#e6b439" :name "fennel"}}}))
      ;{:icon "" :color "#7bc45c" :name "fennel"}
      ;:fennel {:icon "" :color "#e6b439" :name "Fennel"}}}))
(setup_devicons)
(tset _G :fix_devicons setup_devicons)

(def- compiled-fnl
  (a.map
    (fn [s] (string.gsub s ".fnl$" ".lua"))
    (util.glob (.. util.config-path "/fnl/**/*.fnl"))))

; :borderchars [" " " " " " " " " " " " " " " "]
(telescope.setup
  {:defaults
   {:prompt_prefix "❯ "
    :selection_caret "❯ "
    :sorting_strategy "ascending"
    :layout_strategy "horizontal"
    :border true
    :path_display ["shorten"]
    :layout_config {:vertical {:width 0.8 :height 0.6 :mirror true}
                    :mirror false :width 0.92 :height 0.92
                    :horizontal {:prompt_position "top" :preview_width 80}}
    :mappings {:i {:<esc> actions.close
                   :<c-j> actions.move_selection_next
                   :<c-k> actions.move_selection_previous
                   :<c-s> actions.file_split
                   :<c-n> actions.preview_scrolling_down
                   :<c-p> actions.preview_scrolling_up
                   :<c-t> trouble.open_with_trouble}}
    :file_ignore_patterns compiled-fnl}
   :extensions
   {:fzf
    {:override_generic_sorter true
     :override_file_sorter true
     :case_mode "smart_case"}}})

(telescope.load_extension "fzf")
(telescope.load_extension "project")
(telescope.load_extension "ghq")
; (telescope.load_extension "packer")

(def- projects
  {:display_type "full"
   :layout_config
   {:width 60
    :height 16}})

(def- nopreview
  (themes.get_dropdown
    {:prompt_title false
     :previewer false
     :layout_config
     {:width 0.8
      :height 0.6667}}))

(defn- project-maps [_ keymap]
  (keymap "i" :<c-p> p-actions.recent_project_files)
  (keymap "i" :<c-t> p-actions.search_in_project_files)
  (keymap "i" :<c-o> p-actions.find_project_files)
  (keymap "i" :<c-w> p-actions.change_working_directory)
  true)

(def project-file (.. (vim.fn.stdpath "data") "/telescope-projects.txt"))

(defn get-projects []
  (->> (a.slurp project-file)
       (#(str.split $ "\n"))
       (a.filter #(not (str.blank? $)))
       (a.map #(str.split $ "="))
       (a.map #{(a.second $) (a.first $)})
       (#(a.merge (unpack $)))))

(defn dir-project-name [dir]  (a.get (get-projects) dir))
(defn is-project? [dir]       (not (a.nil? (dir-project-name dir))))
(defn cwd-is-project? []      (is-project? (vim.fn.getcwd)))
(defn cwd-project []          (dir-project-name (vim.fn.getcwd)))

(defn- oldfiles-theme [project?]
  (a.merge
    {:prompt_title "oldfiles"
     :preview_title false
     :results_title false
     :cwd_only false}
    (when project?
      {:prompt_title "oldfiles (project)"
       :results_title (vim.fn.getcwd)
       :cwd_only true})))
       ; todo:
       ;:attach_mappings
       ; (fn [_ km]
       ;   (km "i" :<c-p> (+ actions.close #(builtin.oldfiles (oldfiles-theme false))))
       ;  true})))

(do
  (def- maps
    {:<c-p>         #(builtin.oldfiles (oldfiles-theme (cwd-project)))
     :<leader><c-p> #(builtin.oldfiles (oldfiles-theme false))
     :<leader>p     #(builtin.find_files)
     :<leader>t     #(builtin.live_grep)
     "<leader>;"    #(builtin.commands nopreview)
     :<leader>:     #(builtin.command_history nopreview)
     :<leader>o     #(builtin.buffers)
     :<leader>lm    #(builtin.reloader)
     :<a-p>         #(telescope.extensions.project.project
                       (a.merge projects {:attach_mappings project-maps}))})
  (each [left right (pairs maps)]
    (vim._keymap.nnoremap [left right])))

