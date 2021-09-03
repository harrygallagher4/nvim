local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local fileinfo = require('galaxyline.provider_fileinfo')

local sl = require('dotfiles.module.galaxyline')
local c = require('dotfiles.module.highlights')['resolve-color']

local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer'}

local function has_lsp()
  return #vim.lsp.buf_get_clients() > 0
end

--
-- reset statusline
--
gls.left = {}
gls.right = {}
gls.mid = {}
gls.short_line_left = {}
gls.short_line_right = {}

--
-- left section
--
gls.left[1] = {
  RainbowRed = {
    provider = function() return '▊ ' end,
    highlight = 'GalaxyViMode'
  }
}
gls.left[2] = {
  ViMode = {
    provider = function()
      local mode_color = {n = colors.red, i = colors.green,v=colors.blue,
        [''] = colors.blue,V=colors.blue,
        c = colors.magenta,no = colors.red,s = colors.orange,
        S=colors.orange,[''] = colors.orange,
        ic = colors.yellow,R = colors.violet,Rv = colors.violet,
        cv = colors.red,ce=colors.red, r = colors.cyan,
        rm = colors.cyan, ['r?'] = colors.cyan,
        ['!']  = colors.red,t = colors.red}
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
      return '  '
    end,
    highlight = {colors.red,colors.bg,'bold'}
  }
}
gls.left[3] ={
  FileIcon = {
    provider = sl.file_icon,
    condition = condition.buffer_not_empty,
    highlight = {fileinfo.get_file_icon_color,colors.bg}
  }
}
gls.left[4] = {
  FileName = {
    provider = sl.file_name,
    separator = ' ',
    condition = condition.buffer_not_empty,
    separator_highlight = {'NONE',colors.bg},
    highlight = {fileinfo.get_file_icon_color,colors.bg,'bold,italic'}
    -- highlight = {colors.magenta,colors.bg,'italic'}
  }
}
gls.left[5] = {
  FileSize = {
    provider = sl.file_size,
    separator = ' ',
    condition = condition.buffer_not_empty,
    separator_highlight = {'NONE',colors.bg},
    highlight = {c'bg4',colors.bg}
  }
}
gls.left[6] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = ' ',
    highlight = {colors.red,colors.bg}
  }
}
gls.left[7] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = ' ',
    highlight = {colors.yellow,colors.bg}
  }
}
gls.left[8] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = ' ',
    highlight = {colors.cyan,colors.bg}
  }
}
gls.left[9] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = ' ',
    highlight = {colors.blue,colors.bg}
  }
}

--
-- right section
--
gls.right[1] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = has_lsp,
    icon = '  ',
    highlight = {colors.cyan,colors.bg}
  }
}
gls.right[2] = {
  FileEncode = {
    provider = sl.file_encoding,
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg}
  }
}
gls.right[3] = {
  FileFormat = {
    provider = sl.file_format,
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg}
  }
}
gls.right[4] = {
  LineInfo = {
    provider = sl.cursor_coordinates,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg}
  }
}
gls.right[5] = {
  PerCent = {
    provider = sl.cursor_percentage,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg}
  }
}
gls.right[6] = {
  GitIcon = {
    provider = function() return ' ' end,
    -- condition = condition.check_git_workspace,
    condition = function () return false end,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.violet,colors.bg,'bold'}
  }
}
gls.right[7] = {
  GitBranch = {
    provider = 'GitBranch',
    -- condition = condition.check_git_workspace,
    condition = function () return false end,
    highlight = {colors.violet,colors.bg}
  }
}
gls.right[8] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = ' ',
    highlight = {colors.green,colors.bg}
  }
}
gls.right[9] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = '柳',
    highlight = {colors.orange,colors.bg}
  }
}
gls.right[10] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = ' ',
    highlight = {colors.red,colors.bg}
  }
}
gls.right[11] = {
  Scrollbar = {
    provider = 'ScrollBar',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.scroll,colors.bg}
  }
}
gls.right[12] = {
  RainbowBlue = {
    provider = function() return '▊' end,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = 'GalaxyViMode'
  }
}

--
-- short line left
--
gls.short_line_left[1] = {
  WinNrNC = {
    provider = sl.window_number,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.magenta,colors.bg,'bold'}
  }
}
gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
}
gls.short_line_left[3] = {
  BufferType = {
    provider = sl.buffer_filetype,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {c'bg4',colors.bg,'bold,italic'}
  }
}

--
-- short line right
--
gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.fg,colors.bg}
  }
}
-- gls.short_line_right[2] = {
--   WinIdCustom = {
--     provider = dotfiles.winid,
--     highlight = {colors.fg,colors.bg}
--   }
-- }

