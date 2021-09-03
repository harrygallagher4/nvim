local _2afile_2a = "fnl/dotfiles/module/telescope.fnl"
local _1_
do
  local name_4_auto = "dotfiles.module.telescope"
  local module_5_auto
  do
    local x_6_auto = _G.package.loaded[name_4_auto]
    if ("table" == type(x_6_auto)) then
      module_5_auto = x_6_auto
    else
      module_5_auto = {}
    end
  end
  module_5_auto["aniseed/module"] = name_4_auto
  module_5_auto["aniseed/locals"] = ((module_5_auto)["aniseed/locals"] or {})
  do end (module_5_auto)["aniseed/local-fns"] = ((module_5_auto)["aniseed/local-fns"] or {})
  do end (_G.package.loaded)[name_4_auto] = module_5_auto
  _1_ = module_5_auto
end
local autoload
local function _3_(...)
  return (require("aniseed.autoload")).autoload(...)
end
autoload = _3_
local function _6_(...)
  local ok_3f_21_auto, val_22_auto = nil, nil
  local function _5_()
    return {require("aniseed.core"), require("telescope.actions.set"), require("telescope.actions"), require("telescope.builtin"), require("nvim-web-devicons"), require("astronauta.keymap"), require("aniseed.nvim"), require("telescope._extensions.project.actions"), require("telescope.previewers"), require("aniseed.string"), require("telescope"), require("telescope.themes"), require("trouble.providers.telescope"), require("dotfiles.util")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true}, require = {["action-set"] = "telescope.actions.set", ["p-actions"] = "telescope._extensions.project.actions", a = "aniseed.core", actions = "telescope.actions", builtin = "telescope.builtin", devicons = "nvim-web-devicons", keymap = "astronauta.keymap", nvim = "aniseed.nvim", previewers = "telescope.previewers", str = "aniseed.string", telescope = "telescope", themes = "telescope.themes", trouble = "trouble.providers.telescope", util = "dotfiles.util"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local str = _local_4_[10]
local telescope = _local_4_[11]
local themes = _local_4_[12]
local trouble = _local_4_[13]
local util = _local_4_[14]
local action_set = _local_4_[2]
local actions = _local_4_[3]
local builtin = _local_4_[4]
local devicons = _local_4_[5]
local keymap = _local_4_[6]
local nvim = _local_4_[7]
local p_actions = _local_4_[8]
local previewers = _local_4_[9]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.module.telescope"
do local _ = ({nil, _1_, nil, {{nil}, nil, nil, nil}})[2] end
local setup_devicons
do
  local v_23_auto
  do
    local v_25_auto
    local function setup_devicons0()
      return devicons.setup({override = {fennel = {color = "#e6b439", icon = "\238\152\160", name = "Fennel"}, fnl = {color = "#e6b439", icon = "\238\152\160", name = "Fennel"}}})
    end
    v_25_auto = setup_devicons0
    _1_["setup_devicons"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["setup_devicons"] = v_23_auto
  setup_devicons = v_23_auto
end
setup_devicons()
do end (_G)["fix_devicons"] = setup_devicons
local compiled_fnl
do
  local v_23_auto
  local function _8_(s)
    return string.gsub(s, ".fnl$", ".lua")
  end
  v_23_auto = a.map(_8_, util.glob((util["config-path"] .. "/fnl/**/*.fnl")))
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["compiled-fnl"] = v_23_auto
  compiled_fnl = v_23_auto
end
telescope.setup({defaults = {border = true, file_ignore_patterns = compiled_fnl, layout_config = {height = 0.92, horizontal = {preview_width = 80, prompt_position = "top"}, mirror = false, vertical = {height = 0.6, mirror = true, width = 0.8}, width = 0.92}, layout_strategy = "horizontal", mappings = {i = {["<c-j>"] = actions.move_selection_next, ["<c-k>"] = actions.move_selection_previous, ["<c-n>"] = actions.preview_scrolling_down, ["<c-p>"] = actions.preview_scrolling_up, ["<c-s>"] = actions.file_split, ["<c-t>"] = trouble.open_with_trouble, ["<esc>"] = actions.close}}, path_display = {"shorten"}, prompt_prefix = "\226\157\175 ", selection_caret = "\226\157\175 ", sorting_strategy = "ascending"}, extensions = {fzf = {case_mode = "smart_case", override_file_sorter = true, override_generic_sorter = true}}})
telescope.load_extension("fzf")
telescope.load_extension("project")
telescope.load_extension("ghq")
telescope.load_extension("packer")
local projects
do
  local v_23_auto = {display_type = "full", layout_config = {height = 16, width = 60}}
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["projects"] = v_23_auto
  projects = v_23_auto
end
local nopreview
do
  local v_23_auto = themes.get_dropdown({layout_config = {height = 0.6667, width = 0.8}, previewer = false, prompt_title = false})
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["nopreview"] = v_23_auto
  nopreview = v_23_auto
end
local project_maps
do
  local v_23_auto
  local function project_maps0(_, keymap0)
    keymap0("i", "<c-p>", p_actions.recent_project_files)
    keymap0("i", "<c-t>", p_actions.search_in_project_files)
    keymap0("i", "<c-o>", p_actions.find_project_files)
    keymap0("i", "<c-w>", p_actions.change_working_directory)
    return true
  end
  v_23_auto = project_maps0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["project-maps"] = v_23_auto
  project_maps = v_23_auto
end
local project_file
do
  local v_23_auto
  do
    local v_25_auto = (vim.fn.stdpath("data") .. "/telescope-projects.txt")
    do end (_1_)["project-file"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["project-file"] = v_23_auto
  project_file = v_23_auto
end
local get_projects
do
  local v_23_auto
  do
    local v_25_auto
    local function get_projects0()
      local function _9_(_241)
        return a.merge(unpack(_241))
      end
      local function _10_(_241)
        return {[a.second(_241)] = a.first(_241)}
      end
      local function _11_(_241)
        return str.split(_241, "=")
      end
      local function _12_(_241)
        return not str["blank?"](_241)
      end
      local function _13_(_241)
        return str.split(_241, "\n")
      end
      return _9_(a.map(_10_, a.map(_11_, a.filter(_12_, _13_(a.slurp(project_file))))))
    end
    v_25_auto = get_projects0
    _1_["get-projects"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["get-projects"] = v_23_auto
  get_projects = v_23_auto
end
local dir_project_name
do
  local v_23_auto
  do
    local v_25_auto
    local function dir_project_name0(dir)
      return a.get(get_projects(), dir)
    end
    v_25_auto = dir_project_name0
    _1_["dir-project-name"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["dir-project-name"] = v_23_auto
  dir_project_name = v_23_auto
end
local is_project_3f
do
  local v_23_auto
  do
    local v_25_auto
    local function is_project_3f0(dir)
      return not a["nil?"](dir_project_name(dir))
    end
    v_25_auto = is_project_3f0
    _1_["is-project?"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["is-project?"] = v_23_auto
  is_project_3f = v_23_auto
end
local cwd_is_project_3f
do
  local v_23_auto
  do
    local v_25_auto
    local function cwd_is_project_3f0()
      return is_project_3f(vim.fn.getcwd())
    end
    v_25_auto = cwd_is_project_3f0
    _1_["cwd-is-project?"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["cwd-is-project?"] = v_23_auto
  cwd_is_project_3f = v_23_auto
end
local cwd_project
do
  local v_23_auto
  do
    local v_25_auto
    local function cwd_project0()
      return dir_project_name(vim.fn.getcwd())
    end
    v_25_auto = cwd_project0
    _1_["cwd-project"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["cwd-project"] = v_23_auto
  cwd_project = v_23_auto
end
local oldfiles_theme
do
  local v_23_auto
  local function oldfiles_theme0(project_3f)
    local function _14_()
      if project_3f then
        return {cwd_only = true, prompt_title = "oldfiles (project)", results_title = vim.fn.getcwd()}
      end
    end
    return a.merge({cwd_only = false, preview_title = false, prompt_title = "oldfiles", results_title = false}, _14_())
  end
  v_23_auto = oldfiles_theme0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["oldfiles-theme"] = v_23_auto
  oldfiles_theme = v_23_auto
end
local maps
do
  local v_23_auto
  local function _15_()
    return telescope.extensions.project.project(a.merge(projects, {attach_mappings = project_maps}))
  end
  local function _16_()
    return builtin.oldfiles(oldfiles_theme(cwd_project()))
  end
  local function _17_()
    return builtin.command_history(nopreview)
  end
  local function _18_()
    return builtin.commands(nopreview)
  end
  local function _19_()
    return builtin.oldfiles(oldfiles_theme(false))
  end
  local function _20_()
    return builtin.reloader()
  end
  local function _21_()
    return builtin.buffers()
  end
  local function _22_()
    return builtin.find_files()
  end
  local function _23_()
    return builtin.live_grep()
  end
  v_23_auto = {["<a-p>"] = _15_, ["<c-p>"] = _16_, ["<leader>:"] = _17_, ["<leader>;"] = _18_, ["<leader><c-p>"] = _19_, ["<leader>lm"] = _20_, ["<leader>o"] = _21_, ["<leader>p"] = _22_, ["<leader>t"] = _23_}
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["maps"] = v_23_auto
  maps = v_23_auto
end
for left, right in pairs(maps) do
  vim.keymap.nnoremap({left, right})
end
return nil