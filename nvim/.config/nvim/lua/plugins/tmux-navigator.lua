return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    local modes = { 'n', 'i', 'x', 's', 'o', 't', 'c' }

    vim.keymap.set(modes, '<A-h>', '<cmd>TmuxNavigateLeft<cr>')
    vim.keymap.set(modes, '<A-j>', '<cmd>TmuxNavigateDown<cr>')
    vim.keymap.set(modes, '<A-k>', '<cmd>TmuxNavigateUp<cr>')
    vim.keymap.set(modes, '<A-l>', '<cmd>TmuxNavigateRight<cr>')
  end,
}
