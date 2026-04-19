-- By default, nvim writes to a temp file and then renames it when saving.
-- Because of that, some programs trying to watch the file can lost track of it.
-- This option writes directly to the file, preventing potential issues.
vim.opt.backupcopy = 'yes'

vim.opt.shada = "'500" -- number for wich previous files will be remembered (marks, oldfiles)

-- enable swapfile
vim.opt.swapfile = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1 -- disable aditional netrw features

-- true colors suport
vim.opt.termguicolors = true

vim.opt.relativenumber = true
vim.opt.number = true

-- follow identation on wrap
vim.opt.breakindent = true

-- save undo history
vim.opt.undofile = true

-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- open space to line symbols
vim.opt.signcolumn = 'yes'

-- wait time for conflcting keys - Default is 1000
vim.opt.timeout = false

-- change position of new splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- show empty chars
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = ' ' }

-- window at bottom when using :s
vim.opt.inccommand = 'split'

-- how many lines keep around cursor when moving vertically
vim.opt.scrolloff = 15

-- tabs
local tab_size = 2
vim.opt.shiftwidth = tab_size -- trailing tabs
vim.opt.tabstop = tab_size -- leading tabs
vim.opt.expandtab = true -- spaces instead of tabs

-- use status bar globally
vim.opt.laststatus = 3

-- don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- change some icons
vim.opt.fillchars = {
  vert = '▎',
  vertleft = '▎',
  vertright = '▎',
  verthoriz = '▎',

  -- ─  ▁
  horiz = '─',
  horizup = '─',
  horizdown = '─',

  eob = ' ', -- end of buffer (normally '~')
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
}

vim.diagnostic.config({
  virtual_text = false, -- inline diagnostic
  underline = true,
  signs = false,
})

local icons = require('utils.icons')

-- for plugins like trouble
vim.fn.sign_define('DiagnosticSignError', { text = icons.diagnostics.error })
vim.fn.sign_define('DiagnosticSignWarn', { text = icons.diagnostics.warn })
vim.fn.sign_define('DiagnosticSignInfo', { text = icons.diagnostics.info })
vim.fn.sign_define('DiagnosticSignHint', { text = icons.diagnostics.hint })
