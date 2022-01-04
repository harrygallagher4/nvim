-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/harry/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/harry/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/harry/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/harry/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/harry/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["SyntaxAttr.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/SyntaxAttr.vim",
    url = "https://github.com/inkarkat/SyntaxAttr.vim"
  },
  aniseed = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/aniseed",
    url = "https://github.com/Olical/aniseed"
  },
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/astronauta.nvim",
    url = "https://github.com/tjdevries/astronauta.nvim"
  },
  ["auto-session"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["compe-conjure"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/compe-conjure",
    url = "https://github.com/tami5/compe-conjure"
  },
  ["completion-treesitter"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/completion-treesitter",
    url = "https://github.com/nvim-treesitter/completion-treesitter"
  },
  conjure = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/conjure",
    url = "https://github.com/Olical/conjure"
  },
  delimitMate = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/delimitMate",
    url = "https://github.com/Raimondi/delimitMate"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  fzf = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/fzf",
    url = "/usr/local/opt/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  harryg = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/harryg",
    url = "/Users/harry/.config/nvim/localplugin"
  },
  ["indent-blankline.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/tami5/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/hoob3rt/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  ["luv-vimdocs"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/luv-vimdocs",
    url = "https://github.com/nanotee/luv-vimdocs"
  },
  melange = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/melange",
    url = "https://github.com/savq/melange"
  },
  neoformat = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/neoformat",
    url = "https://github.com/sbdchd/neoformat"
  },
  neorg = {
    config = { "\27LJ\2\në\1\0\0\a\0\15\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\r\0005\3\3\0004\4\0\0=\4\4\0034\4\0\0=\4\5\0034\4\0\0=\4\6\0035\4\n\0005\5\b\0005\6\a\0=\6\t\5=\5\v\4=\4\f\3=\3\14\2B\0\2\1K\0\1\0\tload\1\0\0\21core.norg.dirman\vconfig\1\0\0\15workspaces\1\0\0\1\0\1\17my_workspace\f~/neorg\24core.norg.concealer\18core.neorgcmd\18core.defaults\1\0\0\nsetup\nneorg\frequire\0" },
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/neorg",
    url = "https://github.com/nvim-neorg/neorg"
  },
  ["neuron.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/neuron.nvim",
    url = "https://github.com/oberblastmeister/neuron.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua",
    url = "https://github.com/akinsho/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "/Users/harry/Projects/nvim/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-compe",
    url = "https://github.com/hrsh7th/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["nvim.lua"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/nvim.lua",
    url = "https://github.com/norcalli/nvim.lua"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["parinfer-rust"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/parinfer-rust",
    url = "https://github.com/eraserhd/parinfer-rust"
  },
  playground = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["session-lens"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/session-lens",
    url = "https://github.com/rmagatti/session-lens"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-writer.nvim"
  },
  ["telescope-ghq.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/telescope-ghq.nvim",
    url = "https://github.com/nvim-telescope/telescope-ghq.nvim"
  },
  ["telescope-packer.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/telescope-packer.nvim",
    url = "https://github.com/nvim-telescope/telescope-packer.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-boxdraw"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/vim-boxdraw",
    url = "https://github.com/gyim/vim-boxdraw"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-easy-align"] = {
    commands = { "EasyAlign", "LiveEasyAlign" },
    keys = { { "", "<Plug>(EasyAlign)" }, { "", "<Plug>(LiveEasyAlign)" }, { "v", "<Plug>(EasyAlign)" }, { "v", "<Plug>(LiveEasyAlign)" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-jq"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-jq",
    url = "https://github.com/bfrg/vim-jq"
  },
  ["vim-lf"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-lf",
    url = "https://github.com/harrygallagher4/vim-lf"
  },
  ["vim-nix"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-nix",
    url = "https://github.com/LnL7/vim-nix"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-sayonara"] = {
    commands = { "Sayonara" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/vim-sayonara",
    url = "https://github.com/mhinz/vim-sayonara"
  },
  ["vim-slash"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-slash",
    url = "https://github.com/junegunn/vim-slash"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["wilder.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/wilder.nvim",
    url = "https://github.com/gelguy/wilder.nvim"
  },
  ["zest.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/zest.nvim",
    url = "https://github.com/tsbohc/zest.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^aniseed%.env"] = "aniseed",
  ["^nvim%-autopairs"] = "nvim-autopairs",
  ["^zest"] = "zest.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: neorg
time([[Config for neorg]], true)
try_loadstring("\27LJ\2\në\1\0\0\a\0\15\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\r\0005\3\3\0004\4\0\0=\4\4\0034\4\0\0=\4\5\0034\4\0\0=\4\6\0035\4\n\0005\5\b\0005\6\a\0=\6\t\5=\5\v\4=\4\f\3=\3\14\2B\0\2\1K\0\1\0\tload\1\0\0\21core.norg.dirman\vconfig\1\0\0\15workspaces\1\0\0\1\0\1\17my_workspace\f~/neorg\24core.norg.concealer\18core.neorgcmd\18core.defaults\1\0\0\nsetup\nneorg\frequire\0", "config", "neorg")
time([[Config for neorg]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file EasyAlign lua require("packer.load")({'vim-easy-align'}, { cmd = "EasyAlign", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LiveEasyAlign lua require("packer.load")({'vim-easy-align'}, { cmd = "LiveEasyAlign", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Sayonara lua require("packer.load")({'vim-sayonara'}, { cmd = "Sayonara", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[vnoremap <silent> <Plug>(EasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(EasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(LiveEasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(LiveEasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> <Plug>(LiveEasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(LiveEasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(EasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(EasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
