local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

configs.neuron_ls = {
  default_config = {
    cmd = {'neuron-language-server'};
    filetypes = {'markdown'};
    root_dir = util.root_pattern('.neuron');
    settings = {};
  };
}

local function p(i)
  print(vim.inspect(i))
end

local x = {
  'vimls',
  sumneko_lua = {
    on_attach=p,
  }
}

for k,v in pairs(x) do
  local name = type(k) == 'number' and v or k
  local config = type(k) == 'number' and p or v
  p(name)
  p(config)
end
