return {
  { 'EdenEast/nightfox.nvim', lazy = true },
  { 'catppuccin/nvim', name = 'catppuccin', lazy = true },
  { 'projekt0n/github-nvim-theme', lazy = true },

  {
    'vague2k/vague.nvim',
    opts = { colors = { func = '#bc96b0', keyword = '#787bab', string = '#8a739a', number = '#8f729e' } },
    lazy = true,
  },

  { 'olivercederborg/poimandres.nvim', lazy = true },
  { 'oahlen/iceberg.nvim', lazy = true },
  { 'kvrohit/substrata.nvim', lazy = true },
  { 'dgox16/oldworld.nvim', lazy = true },
  { 'gbprod/nord.nvim', lazy = true },

  {
    'zaldih/themery.nvim',
    lazy = false,
    keys = {
      { '<leader>t', '<cmd>Themery<cr>', desc = 'Themery' },
    },
    config = function()
      vim.cmd('colorscheme duskfox') -- default colorscheme

      require('utils.ft').clear_c_hjkl('themery', { bind_c_j = true })
      require('utils.ft').bind_tmux_nav('themery')

      require('themery').setup({
        themes = {
          'duskfox',
          'nightfox',

          'nord',
          'poimandres',
          'iceberg',

          'catppuccin',
          'catppuccin-macchiato',

          'substrata',
          'vague',
          'oldworld',
          'carbonfox',
          'github_dark_default',
        },
      })
    end,
  },
}
