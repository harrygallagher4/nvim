local _2afile_2a = "fnl/dotfiles/module/telescope.fnl"
local _2amodule_name_2a = "dotfiles.module.telescope"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["_LOCALS"] = {}
  _2amodule_locals_2a = (_2amodule_2a)._LOCALS
end
local a, action_set, actions, builtin, devicons, keymap, nvim, p_actions, previewers, str, telescope, themes, trouble, util, _ = require("aniseed.core"), require("telescope.actions.set"), require("telescope.actions"), require("telescope.builtin"), require("nvim-web-devicons"), require("astronauta.keymap"), require("aniseed.nvim"), require("telescope._extensions.project.actions"), require("telescope.previewers"), require("aniseed.string"), require("telescope"), require("telescope.themes"), require("trouble.providers.telescope"), require("dotfiles.util"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["action-set"] = action_set
_2amodule_locals_2a["actions"] = actions
_2amodule_locals_2a["builtin"] = builtin
_2amodule_locals_2a["devicons"] = devicons
_2amodule_locals_2a["keymap"] = keymap
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["p-actions"] = p_actions
_2amodule_locals_2a["previewers"] = previewers
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["telescope"] = telescope
_2amodule_locals_2a["themes"] = themes
_2amodule_locals_2a["trouble"] = trouble
_2amodule_locals_2a["util"] = util
_2amodule_locals_2a["_"] = _
local function setup_devicons()
  return devicons.setup({override = {fennel = {color = "#e6b439", icon = "\238\152\160", name = "Fennel"}, fnl = {color = "#e6b439", icon = "\238\152\160", name = "Fennel"}}})
end
_2amodule_2a["setup_devicons"] = setup_devicons
setup_devicons()
do end (_G)["fix_devicons"] = setup_devicons
local compiled_fnl
local function _1_(s)
  return string.gsub(s, ".fnl$", ".lua")
end
compiled_fnl = a.map(_1_, util.glob((util["config-path"] .. "/fnl/**/*.fnl")))
do end (_2amodule_locals_2a)["compiled-fnl"] = compiled_fnl
telescope.setup({defaults = {border = true, file_ignore_patterns = compiled_fnl, layout_config = {height = 0.92, horizontal = {preview_width = 80, prompt_position = "top"}, mirror = false, vertical = {height = 0.6, mirror = true, width = 0.8}, width = 0.92}, layout_strategy = "horizontal", mappings = {i = {["<c-j>"] = actions.move_selection_next, ["<c-k>"] = actions.move_selection_previous, ["<c-n>"] = actions.preview_scrolling_down, ["<c-p>"] = actions.preview_scrolling_up, ["<c-s>"] = actions.file_split, ["<c-t>"] = trouble.open_with_trouble, ["<esc>"] = actions.close}}, path_display = {"shorten"}, prompt_prefix = "\226\157\175 ", selection_caret = "\226\157\175 ", sorting_strategy = "ascending"}, extensions = {fzf = {case_mode = "smart_case", override_file_sorter = true, override_generic_sorter = true}}})
telescope.load_extension("fzf")
telescope.load_extension("project")
telescope.load_extension("ghq")
telescope.load_extension("packer")
local projects = {display_type = "full", layout_config = {height = 16, width = 60}}
_2amodule_locals_2a["projects"] = projects
local nopreview = themes.get_dropdown({layout_config = {height = 0.6667, width = 0.8}, previewer = false, prompt_title = false})
do end (_2amodule_locals_2a)["nopreview"] = nopreview
local function project_maps(_0, keymap0)
  keymap0("i", "<c-p>", p_actions.recent_project_files)
  keymap0("i", "<c-t>", p_actions.search_in_project_files)
  keymap0("i", "<c-o>", p_actions.find_project_files)
  keymap0("i", "<c-w>", p_actions.change_working_directory)
  return true
end
_2amodule_locals_2a["project-maps"] = project_maps
local project_file = (vim.fn.stdpath("data") .. "/telescope-projects.txt")
do end (_2amodule_2a)["project-file"] = project_file
local function get_projects()
  local function _2_(_241)
    return a.merge(unpack(_241))
  end
  local function _3_(_241)
    return {[a.second(_241)] = a.first(_241)}
  end
  local function _4_(_241)
    return str.split(_241, "=")
  end
  local function _5_(_241)
    return not str["blank?"](_241)
  end
  local function _6_(_241)
    return str.split(_241, "\n")
  end
  return _2_(a.map(_3_, a.map(_4_, a.filter(_5_, _6_(a.slurp(project_file))))))
end
_2amodule_2a["get-projects"] = get_projects
local function dir_project_name(dir)
  return a.get(get_projects(), dir)
end
_2amodule_2a["dir-project-name"] = dir_project_name
local function is_project_3f(dir)
  return not a["nil?"](dir_project_name(dir))
end
_2amodule_2a["is-project?"] = is_project_3f
local function cwd_is_project_3f()
  return is_project_3f(vim.fn.getcwd())
end
_2amodule_2a["cwd-is-project?"] = cwd_is_project_3f
local function cwd_project()
  return dir_project_name(vim.fn.getcwd())
end
_2amodule_2a["cwd-project"] = cwd_project
local function oldfiles_theme(project_3f)
  local function _7_()
    if project_3f then
      return {cwd_only = true, prompt_title = "oldfiles (project)", results_title = vim.fn.getcwd()}
    end
  end
  return a.merge({cwd_only = false, preview_title = false, prompt_title = "oldfiles", results_title = false}, _7_())
end
_2amodule_locals_2a["oldfiles-theme"] = oldfiles_theme
local maps
local function _8_()
  return telescope.extensions.project.project(a.merge(projects, {attach_mappings = project_maps}))
end
local function _9_()
  return builtin.oldfiles(oldfiles_theme(cwd_project()))
end
local function _10_()
  return builtin.command_history(nopreview)
end
local function _11_()
  return builtin.commands(nopreview)
end
local function _12_()
  return builtin.oldfiles(oldfiles_theme(false))
end
local function _13_()
  return builtin.reloader()
end
local function _14_()
  return builtin.buffers()
end
local function _15_()
  return builtin.find_files()
end
local function _16_()
  return builtin.live_grep()
end
maps = {["<a-p>"] = _8_, ["<c-p>"] = _9_, ["<leader>:"] = _10_, ["<leader>;"] = _11_, ["<leader><c-p>"] = _12_, ["<leader>lm"] = _13_, ["<leader>o"] = _14_, ["<leader>p"] = _15_, ["<leader>t"] = _16_}
_2amodule_locals_2a["maps"] = maps
for left, right in pairs(maps) do
  vim.keymap.nnoremap({left, right})
end
return nil