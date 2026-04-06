-- maximize Icon added to lualine.lua
return {
  'declancm/maximize.nvim',
  keys = {
    {
      '<C-w>m',
      function()
        require('maximize').toggle()
      end,
      desc = 'Toggle window maximize',
      mode = { 'n', 'x' },
    },
  },
  config = function()
    require('maximize').setup({
      plugins = {
        aerial = { enable = false },
        dapui = { enable = false },
        tree = { enable = false },
      },
    })
  end,
}
