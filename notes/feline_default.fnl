(local vi-mode-utils (require :feline.providers.vi_mode))

;; just so each component sticks out a little
(local vi-mode :vi_mode)
(local file-size :file_size)
(local file-type :file_type)
(local position :position)
(local diagnostic-errors :diagnostic_errors)
(local diagnostic-warnings :diagnostic_warnings)
(local diagnostic-hints :diagnostic_hints)
(local diagnostic-info :diagnostic_info)
(local git-branch :git_branch)
(local git-diff-added :git_diff_added)
(local git-diff-changed :git_diff_changed)
(local git-diff-removed :git_diff_removed)
(local line-percentage :line_percentage)
(local scroll-bar :scroll_bar)

(local M {:active {} :inactive {}})

(tset M.active 1
      [{:provider "▊ "
        :hl {:fg :skyblue}}
       {:provider vi-mode
        :hl #{:style "bold"
              :name (vi-mode-utils.get_mode_highlight_name)
              :fg (vi-mode-utils.get_mode_color)}}
       {:provider file-size
        :hl {:style :bold :bg :oceanblue :fg :white}
        :left_sep [:slant_left_2
                   {:str " "
                    :hl {:fg :NONE :bg :oceanblue}}]
        :right_sep [{:str " "
                     :hl {:fg :NONE :bg :oceanblue}}
                    :slant_right_2
                    " "]}
       {:provider file-size
        :right_sep [" "
                    {:str :slant_left_2_thin
                     :hl {:fg :fg :bg :bg}}]}
       {:provider position
        :left_sep " "
        :right_sep [" "
                    {:str :slant_right_2_thin
                     :hl {:fg :fg :bg :bg}}]}
       {:provider diagnostic-errors :hl {:fg :red}}
       {:provider diagnostic-warnings :hl {:fg :yellow}}
       {:provider diagnostic-hints :hl {:fg :cyan}}
       {:provider diagnostic-info :hl {:fg :skyblue}}])

(tset M.active 2
      [{:provider git_branch
        :hl {:style :bold :bg :black :fg :white}
        :right_sep {:str " "
                    :hl {:fg :NONE :bg :black}}}
       {:provider git-diff-added
        :hl {:fg :green :bg :black}}
       {:provider git-diff-changed
        :hl {:fg :orange :bg :black}}
       {:provider git-diff-removed
        :hl {:fg :red :bg :black}
        :right_sep {:str " "
                    :hl {:fg :NONE :bg :black}}}
       {:provider line-percentage
        :hl {:style :bold}
        :right_sep " "
        :left_sep "  "}
       {:provider scroll-bar
        :hl {:fg :skyblue :style :bold}}])

(tset M.inactive 1
      [{:provider file-type
        :hl {:style :bold :bg :oceanblue :fg :white}
        :right_sep [{:str " "
                     :hl {:fg :NONE :bg :oceanblue}}
                    :slant_right]
        :left_sep {:str " "
                   :hl {:fg :NONE :bg :oceanblue}}}
       {}])

M

