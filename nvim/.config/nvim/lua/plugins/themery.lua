return {
  'zaldih/themery.nvim',
  dependencies = {
    'EdenEast/nightfox.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>t', '<cmd>Themery<cr>', desc = 'Themery' },
  },
  config = function()
    vim.cmd('colorscheme duskfox') -- default colorscheme

    require('utils.ft').clear_c_hjkl('themery', { bind_c_j = true })
    require('themery').setup({
      themes = {
        'duskfox',
        'nordfox',
        'nightfox',

        'catppuccin-mocha',
        'catppuccin-macchiato',
        'catppuccin-frappe',

        'tokyonight-moon',
        'tokyonight-night',
        'tokyonight-storm',

        'github_dark_dimmed',
        'carbonfox',
        'github_dark_default',
      },
      livePreview = true,
    })
  end,
}
