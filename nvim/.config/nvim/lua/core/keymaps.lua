-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear keys (keep close to top to avoid side effects)
vim.keymap.set({ 'n', 'x' }, '<Space>', '<Nop>')
vim.keymap.set('c', '<C-d>', '<Nop>') -- Causes conflicts with completion
vim.keymap.set({ 'n', 'x' }, '<C-w><C-w>', '<Nop>')
vim.keymap.set('n', 'H', '<Nop>')
vim.keymap.set('n', 'L', '<Nop>')
vim.keymap.set({ 'n', 'x' }, '<leader><Esc>', '<Nop>')
vim.keymap.set('n', 'gt', '<Nop>')
vim.keymap.set('n', 'gT', '<Nop>')
vim.keymap.set('n', 'gO', '<Nop>')
vim.keymap.set('n', 'ga', '<Nop>')
vim.keymap.set({ 'x', 's' }, '<C-n>', '<Nop>')
vim.keymap.set({ 'x', 's' }, '<C-p>', '<Nop>')
vim.keymap.set({ 'x', 's' }, '<C-f>', '<Nop>')
vim.keymap.set({ 'x', 's' }, '<C-b>', '<Nop>')

vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gra')
vim.keymap.del('x', 'gra')
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'gri')

vim.keymap.set('n', '<Esc>', require('utils.clear_hl_and_popup'), { desc = 'Clear highlights and popups' })
vim.keymap.set('n', '<C-Space>', '<C-^>', { desc = 'Switch to the previous buffer' })

vim.keymap.set('t', '<C-q>', '<C-\\><C-n>', { remap = true, desc = 'Exit terminal mode' })

vim.keymap.set('s', '<C-Space>', '<C-g>c', { desc = 'Delete selection' })

-- Lsp
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = 'Rename symbol across project' })
vim.keymap.set('n', '<leader>z', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Diagnostics popup' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })

vim.keymap.set({ 'n', 'x' }, '<leader>p', function()
  local format = require('utils.format')
  local result = format()

  if result and result.found_tailwind then
    pcall(vim.cmd, 'TailwindSort')
  end
end, { desc = 'Format' })

vim.keymap.set('n', '<leader>R', function()
  vim.notify('Restarting lsp...')
  vim.cmd('LspRestart')
end, { desc = 'Go to declaration' })

-- Undo
vim.keymap.set('n', require('utils.bindings').timeline_undo, 'g-', { desc = 'Timeline undo' })
vim.keymap.set('n', require('utils.bindings').timeline_redo, 'g+', { desc = 'Timeline redo' })

-- Emacs-like command movements
vim.keymap.set({ 'i', 'c' }, '<C-a>', '<Home>')
vim.keymap.set({ 'i', 'c' }, '<C-e>', '<End>')

vim.keymap.set({ 'i', 'c' }, '<C-b>', '<Left>')
vim.keymap.set({ 'i', 'c' }, '<C-f>', '<Right>')
vim.keymap.set({ 'i', 'c' }, '<M-b>', '<S-Left>')
vim.keymap.set({ 'i', 'c' }, '<M-f>', '<S-Right>')

vim.keymap.set('i', '<M-.>', '<C-a>')
vim.keymap.set('i', '<M-y>', '<C-e>')

vim.keymap.set({ 'i', 'c' }, '<M-u>', '<C-u>') -- As an alternative when <C-u> is binded to something else

-- Facilitate indent
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('x', '<', '<gv')

-- Facilitate change list navigation
vim.keymap.set('n', '<M-,>', function()
  local count = vim.v.count > 0 and vim.v.count or 1
  vim.cmd("norm! m'" .. count .. 'g,')
end, { desc = 'Previous change' })

vim.keymap.set('n', '<M-;>', function()
  local count = vim.v.count > 0 and vim.v.count or 1
  vim.cmd("norm! m'" .. count .. 'g;')
end, { desc = 'Next change' })

vim.keymap.set('n', '<M-.>', "m'9999g,", { desc = 'Recent change' })

-- Alternatives to ge
vim.keymap.set({ 'n', 'x', 'o' }, '<C-b>', 'ge', { remap = true })
vim.keymap.set({ 'n', 'x', 'o' }, '<M-b>', 'gE', { remap = true })

-- Alternatives to scroll
vim.keymap.set({ 'n', 'x' }, '<M-d>', '<cmd>norm! 4<CR>')
vim.keymap.set({ 'n', 'x' }, '<M-u>', '<cmd>norm! 4<CR>')

vim.keymap.set({ 'n', 'x' }, '<Down>', '<cmd>norm! 40M<CR>')
vim.keymap.set({ 'n', 'x' }, '<Up>', '<cmd>norm! 40M<CR>')
vim.keymap.set({ 'n', 'i', 'x', 's', 'o', 'c' }, '<ScrollWheelDown>', '<cmd>norm! 40M<CR>')
vim.keymap.set({ 'n', 'i', 'x', 's', 'o', 'c' }, '<ScrollWheelUp>', '<cmd>norm! 40M<CR>')

vim.keymap.set({ 'n', 'x' }, '<Left>', '<C-u>0M')
vim.keymap.set({ 'n', 'x' }, '<Right>', '<C-d>0M')

-- With strings, when using "a" on operator-pending mode or visual modes, not include extra whitespace
vim.keymap.set({ 'o', 'x' }, "a'", "2i'")
vim.keymap.set({ 'o', 'x' }, 'a"', '2i"')
vim.keymap.set({ 'o', 'x' }, 'a`', '2i`')

-- Make underscore behavior consistent
vim.keymap.set({ 'n', 'o', 'x' }, '_', '^')
vim.keymap.set({ 'n', 'o', 'x' }, 'g_', 'g^')

-- Move through wrap and use normal j/k when providing a counter
vim.keymap.set({ 'n', 'x' }, 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true })

vim.keymap.set({ 'n', 'x' }, 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true })

-- Add relative jumps to jump list
vim.cmd("nnoremap <expr> j v:count ? (v:count > 0 ? \"m'\" . v:count : '') . 'j' : 'gj'")
vim.cmd("nnoremap <expr> k v:count ? (v:count > 0 ? \"m'\" . v:count : '') . 'k' : 'gk'")

-- Registers
vim.keymap.set({ 'n', 'x' }, '<C-y>', '"+y', { desc = 'Yank to OS' })
vim.keymap.set('x', '<M-y>', '"+y', { desc = 'Yank to OS' })
vim.keymap.set('n', '<M-y>', '"+y$', { desc = 'Yank rest of line to OS' })

vim.keymap.set({ 'n', 'x' }, '<M-p>', '"+p', { desc = 'Paste from OS' })
vim.keymap.set({ 'n', 'x' }, 'g<M-p>', '"+gp', { desc = 'Paste from OS and go to end' })
vim.keymap.set({ 'n', 'x' }, '<M-P>', '"+P', { desc = 'Paste from OS before cursor' })
vim.keymap.set({ 'n', 'x' }, 'g<M-P>', '"+gP', { desc = 'Paste from OS before cursor and go to end' })

vim.keymap.set({ 'i', 'c' }, '<M-p>', '<C-r>+', { desc = 'Paste from OS' })
vim.keymap.set({ 'i', 'c' }, '<M-P>', '<C-r>+', { desc = 'Paste from OS' })

-- Registers on terminal mode
vim.keymap.set('t', '<M-p>', '<C-\\><C-n>"+pi')
vim.keymap.set('t', '<M-P>', '<C-\\><C-n>"+pi')

vim.keymap.set('t', '<C-r>', function()
  local reg = vim.fn.getcharstr()
  if not reg:match('^[a-zA-Z0-9"#+*%%_=/:.-]$') then
    return
  end

  local keys = vim.api.nvim_replace_termcodes('<C-\\><C-n>"' .. reg .. 'pi', true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end)

vim.keymap.set('n', '<leader>y', function()
  vim.cmd('let @+=@0')
  vim.notify('Register "0" copied into register "+"')
end, { desc = 'Copy register "0" to "+" register' })

vim.keymap.set('n', "<leader>'", function()
  vim.cmd('let @+=@0')
  vim.notify('Register "0" copied into register "+"')
end, { desc = 'Copy register "0" to "+" register' })

-- Don't indent when using the registers with c-r
vim.keymap.set('i', '<C-r>', '<C-r><C-o>', { remap = true })

-- Use 'x' as alternative to black hole register
-- vim.keymap.set({ 'n', 'x' }, 'x', '"_x')
-- vim.keymap.set('n', 'X', '"_X')
-- vim.keymap.set('x', 'X', '"_d') -- Also substitutes behavior of deleting line when using 'X' on 'v' mode

-- Tab
vim.keymap.set({ 'n', 'x' }, '<C-t>', '<cmd>tabnew<CR>', { desc = 'Create tab' })
vim.keymap.set({ 'n', 'x' }, '<C-w>O', '<cmd>tabo<CR>', { desc = 'Tab only' })
vim.keymap.set({ 'n', 'x' }, '<C-w>C', '<cmd>tabclose<CR>', { desc = 'Tab close' })
vim.keymap.set('n', "g'", '<cmd>tabn<CR>')
vim.keymap.set('n', 'g"', '<cmd>tabp<CR>')

vim.keymap.set({ 'n', 'x' }, 'g1', '<cmd>tabn 1<CR>', { desc = 'Go to tab n1' })
vim.keymap.set({ 'n', 'x' }, 'g2', '<cmd>tabn 2<CR>', { desc = 'Go to tab n2' })
vim.keymap.set({ 'n', 'x' }, 'g3', '<cmd>tabn 3<CR>', { desc = 'Go to tab n3' })
vim.keymap.set({ 'n', 'x' }, 'g4', '<cmd>tabn 4<CR>', { desc = 'Go to tab n4' })
vim.keymap.set({ 'n', 'x' }, 'g5', '<cmd>tabn 5<CR>', { desc = 'Go to tab n5' })
vim.keymap.set({ 'n', 'x' }, 'g6', '<cmd>tabn 6<CR>', { desc = 'Go to tab n6' })
vim.keymap.set({ 'n', 'x' }, 'g7', '<cmd>tabn 7<CR>', { desc = 'Go to tab n7' })
vim.keymap.set({ 'n', 'x' }, 'g8', '<cmd>tabn 8<CR>', { desc = 'Go to tab n8' })
vim.keymap.set({ 'n', 'x' }, 'g9', '<cmd>tabn 9<CR>', { desc = 'Go to tab n9' })

-- Improve repetitive window movements
vim.keymap.set({ 'n', 'x' }, '<C-w>H', '<C-w>H<C-w>', { remap = true })
vim.keymap.set({ 'n', 'x' }, '<C-w>J', '<C-w>J<C-w>', { remap = true })
vim.keymap.set({ 'n', 'x' }, '<C-w>K', '<C-w>K<C-w>', { remap = true })
vim.keymap.set({ 'n', 'x' }, '<C-w>L', '<C-w>L<C-w>', { remap = true })

vim.keymap.set({ 'n', 'x' }, '<C-w>l', '<cmd>vertical resize +5<cr><C-w>', { remap = true })
vim.keymap.set({ 'n', 'x' }, '<C-w>h', '<cmd>vertical resize -5<cr><C-w>', { remap = true })
vim.keymap.set({ 'n', 'x' }, '<C-w>k', '<cmd>horizontal resize +5<cr><C-w>', { remap = true })
vim.keymap.set({ 'n', 'x' }, '<C-w>j', '<cmd>horizontal resize -5<cr><C-w>', { remap = true })

vim.keymap.set({ 'n', 'x' }, '<C-w>.', '<cmd>vertical resize +5<cr><C-w>', { remap = true })
vim.keymap.set({ 'n', 'x' }, '<C-w>,', '<cmd>vertical resize -5<cr><C-w>', { remap = true })
vim.keymap.set({ 'n', 'x' }, '<C-w>>', '<cmd>horizontal resize +5<cr><C-w>', { remap = true })
vim.keymap.set({ 'n', 'x' }, '<C-w><', '<cmd>horizontal resize -5<cr><C-w>', { remap = true })

vim.keymap.set({ 'n', 'i', 'x', 's' }, '<C-s>', '<cmd>w<CR>', { desc = 'Write file (save)' })
vim.keymap.set({ 'n', 'x' }, '<C-e>', '<cmd>e!<CR>', { desc = 'Discard changes' })

-- Shortcuts to ':' and '/'
vim.keymap.set({ 'n', 'x' }, '<C-p>', ':', { desc = 'Command mode (pallete)' })
vim.keymap.set({ 'n', 'x', 'o' }, '<C-n>', '/', { desc = 'Search' })
vim.keymap.set({ 'n', 'x', 'o' }, '<M-n>', '?', { desc = 'Search backwards' })

-- Quick comments remapped to work with comment plugins (ie. Comment.nvim)
vim.keymap.set('n', '<C-c>', 'gcc', { remap = true })
vim.keymap.set('x', '<C-c>', 'gc', { remap = true })

-- Marks go to col
vim.keymap.set('n', "'", '`')

-- Swap gf and gF
vim.keymap.set('n', 'gf', 'gF') -- goes to line if any
vim.keymap.set('n', 'gF', 'gf')

-- Quickfix popup keymaps
require('utils.ft').clear_c_hjkl('qf', { bind_c_j = true })
require('utils.ft').bind_close_win('qf', 'cclose')

-- inspectTree
require('utils.ft').bind_close_win('query', 'close')
require('utils.ft').clear_c_hjkl('query', { bind_c_j = true })
