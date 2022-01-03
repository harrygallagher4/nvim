" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
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
  local success, result = pcall(loadstring(s))
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
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["SyntaxAttr.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/SyntaxAttr.vim"
  },
  aniseed = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/aniseed"
  },
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/astronauta.nvim"
  },
  ["compe-conjure"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/compe-conjure"
  },
  ["completion-treesitter"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/completion-treesitter"
  },
  conjure = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/conjure"
  },
  delimitMate = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/delimitMate"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  fzf = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["guihua.lua"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/guihua.lua"
  },
  harryg = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/harryg"
  },
  ["indent-blankline.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/lush.nvim"
  },
  ["luv-vimdocs"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/luv-vimdocs"
  },
  ["material.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/material.nvim"
  },
  melange = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/melange"
  },
  ["navigator.lua"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/navigator.lua"
  },
  neoformat = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  ["neuron.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/neuron.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-luadev"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-luadev"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["nvim.lua"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/nvim.lua"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["parinfer-rust"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/parinfer-rust"
  },
  playground = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope-ghq.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/telescope-ghq.nvim"
  },
  ["telescope-packer.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/telescope-packer.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["vim-boxdraw"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/vim-boxdraw"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-easy-align"] = {
    commands = { "EasyAlign", "LiveEasyAlign" },
    keys = { { "", "<Plug>(EasyAlign)" }, { "", "<Plug>(LiveEasyAlign)" }, { "v", "<Plug>(EasyAlign)" }, { "v", "<Plug>(LiveEasyAlign)" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/vim-easy-align"
  },
  ["vim-lf"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-lf"
  },
  ["vim-nix"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-nix"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-sayonara"] = {
    commands = { "Sayonara" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/vim-sayonara"
  },
  ["vim-slash"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-slash"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["wilder.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/harry/.local/share/nvim/site/pack/packer/opt/wilder.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^aniseed%.env"] = "aniseed",
  ["^nvim%-autopairs"] = "nvim-autopairs"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat)then
      to_load[#to_load + 1] = plugin_name
    end
  end

  require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end


-- Command lazy-loads
time([[Defining lazy-load commands]], true)
vim.cmd [[command! -nargs=* -range -bang -complete=file EasyAlign lua require("packer.load")({'vim-easy-align'}, { cmd = "EasyAlign", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file LiveEasyAlign lua require("packer.load")({'vim-easy-align'}, { cmd = "LiveEasyAlign", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Sayonara lua require("packer.load")({'vim-sayonara'}, { cmd = "Sayonara", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[vnoremap <silent> <Plug>(LiveEasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(LiveEasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> <Plug>(EasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(EasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(EasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(EasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>(LiveEasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(LiveEasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
