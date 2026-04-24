return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  config = function()
    require('dressing').setup({
      input = { -- this is handled by noice.nvim
        enabled = false,
      },
      select = {
        enabled = true,
      },
    })
  end,
}
