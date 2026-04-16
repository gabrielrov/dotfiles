return {
  'kdheepak/lazygit.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = { 'LazyGit', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
  keys = {
    { '<leader>l', '<cmd>LazyGit<CR>', desc = 'LazyGit' },
  },
  config = function()
    vim.g.lazygit_floating_window_border_chars = { '', '', '', '', '', '', '', '' }
  end,
}
