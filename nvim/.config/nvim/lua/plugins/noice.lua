return {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  event = 'VeryLazy',
  keys = {
    { '<leader>n', '<cmd>Noice telescope<CR>', desc = 'Notifications' },
  },
  config = function()
    require('utils.ft').clear_c_hjkl('noice')

    require('noice').setup({
      routes = require('custom.noice.notify_filters'),
      lsp = {
        progress = { enabled = false }, -- Disable lsp notifications
        hover = { silent = true }, -- Disable hover notification when not avaliable
        signature = { enabled = false },
      },
      cmdline = {
        view = 'cmdline', -- cmdline, cmdline_popup

        -- Basically ligatures for commands
        format = {
          -- cmdline = false,
          -- search_down = false,

          -- Change search icon
          search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' }, --  

          lua = false,
          help = false,
          filter = false, -- ! (bang)
        },
      },
      messages = {
        view_search = false,
      },
    })
  end,
}
