(module dotfiles.module.telescope
  {require
   {a aniseed.core
    maps dotfiles.maps
    util dotfiles.util
    telescope telescope
    actions telescope.actions
    themes telescope.themes
    trouble trouble.providers.telescope}
   autoload
   {str dotfiles.util.string
    builtin telescope.builtin
    project telescope._extensions.project.actions
    project-utils telescope._extensions.project.utils}})

(def- compiled-fnl
  (a.map
    #(-> $
         (string.gsub ".fnl$" ".lua")
         (string.gsub "/fnl/" "/lua/"))
    (util.glob (.. util.config-path "/fnl/**/*.fnl"))))

(telescope.setup
  {:defaults
   {:prompt_prefix "   "
    :selection_caret "❯ "
    :sorting_strategy "ascending"
    :layout_strategy "horizontal"
    :border true
    :path_display ["smart"]
    :dynamic_preview_title true
    :layout_config {:vertical {:width 0.8
                               :height 0.6
                               :mirror true}
                    :horizontal {:prompt_position "top"
                                 :preview_width 0.45
                                 :width 0.85}}
    :mappings {:i {:<esc> actions.close
                   :<c-j> actions.move_selection_next
                   :<c-k> actions.move_selection_previous
                   :<c-s> actions.file_split
                   :<c-n> actions.preview_scrolling_down
                   :<c-p> actions.preview_scrolling_up
                   :<c-t> trouble.open_with_trouble
                   :<a-t> trouble.open_selected_with_trouble}}
    :file_ignore_patterns compiled-fnl}
   :extensions
   {:zf-native
    {:file {:enable true
            :highlight_results true
            :match_filename true}
     :generic {:enable true
               :highlight_results true
               :match_filename true}}}})

(telescope.load_extension "zf-native")
(telescope.load_extension "project")
(telescope.load_extension "ghq")
(telescope.load_extension "zoxide")

(defn- num-projects [] (length (project-utils.get_projects)))
(defn- projects-width []
  (->> (project-utils.get_projects)
       (a.map #(+ ($.path:len) ($.title:len)))
       (unpack)
       (math.max)))
(defn- projects-theme []
  {:display_type "full"
   :layout_config
   {:width (+ 10 (projects-width))
    :height (+ 5 (num-projects))}})

(def- nopreview
  (themes.get_dropdown
    {:prompt_title false
     :previewer false
     :layout_config
     {:width 0.85
      :height 0.6667}}))

(defn- project-maps [_ keymap]
  (keymap "i" :<c-p> project.recent_project_files)
  (keymap "i" :<c-t> project.search_in_project_files)
  (keymap "i" :<c-o> project.find_project_files)
  (keymap "i" :<c-w> project.change_working_directory)
  true)

(def project-file (util.stdfile "data" "telescope-projects.txt"))

(defn get-projects []
  (->> (a.slurp project-file)
       (str.split "\n")
       (a.filter str.notblank?)
       (a.map (str.split "="))
       (a.map #{(a.second $) (a.first $)})
       (unpack)
       (a.merge)))

(defn dir-project-name [dir]  (a.get (get-projects) dir))
(defn is-project? [dir]       (a.string? (dir-project-name dir)))
(defn cwd-is-project? []      (is-project? (vim.fn.getcwd)))
(defn cwd-project []          (dir-project-name (vim.fn.getcwd)))

(defn- oldfiles-theme [project?]
  (a.merge
    {:prompt_title "oldfiles"
     :previewer false
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

(maps :n
  [["<leader>p"     #(builtin.oldfiles (oldfiles-theme (cwd-project)))]
   ["<leader><c-p>" #(builtin.oldfiles (oldfiles-theme))]
   ["<c-p>"         #(builtin.find_files)]
   ["<leader>t"     #(builtin.live_grep)]
   ["<leader>;"     #(builtin.commands nopreview)]
   ["<leader>:"     #(builtin.command_history nopreview)]
   ["<leader>o"     #(builtin.buffers)]
   ["<leader>lm"    #(builtin.reloader)]
   ["<leader>z"     "<cmd>Telescope zoxide list<cr>"]
   ["<a-p>"         #(telescope.extensions.project.project
                      (a.merge (projects-theme) {:attach_mappings project-maps}))]])

(defn- setup-packer! []
  (when (not (. package.loaded :packer.plugin_utils))
    (let [plugin-utils (require :packer.plugin_utils)
          packer-config-defaults
          {:start_dir (util.stdfile "data" "site/pack/packer/start/")
           :opt_dir (util.stdfile "data" "site/pack/packer/opt/")
           :git {:default_url_format "https://github.com/%s.git"}}]
      (plugin-utils.cfg packer-config-defaults)))
  (when (not telescope.extensions.packer)
    (telescope.load_extension "packer")))

(defn plugin-picker []
  (setup-packer!)
  (telescope.extensions.packer.packer))

(vim.api.nvim_create_user_command :Plugins plugin-picker {})
(vim.cmd "highlight link TelescopePromptPrefix TelescopeBorder")

