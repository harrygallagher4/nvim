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

--[[
vim.g.lsp_utils_location_opts = {
	height = 24,
	mode = 'editor',
	preview = {
		title = 'Location Preview',
		border = false,
	},
	keymaps = {
		n = {
			['<C-j>'] = 'j',
			['<C-k>'] = 'k',
		}
	}
}
vim.g.lsp_utils_symbols_opts = {
	height = 24,
	mode = 'editor',
	preview = {
		title = 'Symbols Preview',
		border = false,
	},
	prompt = {},
}

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
]]

local M = {}

function M.setup(servers, default)
  if default == nil then default = {} end
  for k,v in pairs(servers) do
    local name = type(k) == 'number' and v or k
    local conf = type(k) == 'number' and default or v
    lspconfig[name].setup(conf)
  end
end

return M

