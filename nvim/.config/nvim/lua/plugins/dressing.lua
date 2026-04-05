return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  config = function()
    require('utils.ft').clear_c_hjkl('DressingInput', { bind_c_j = true })

    require('dressing').setup({
      input = {
        mappings = {
          n = {
            ['<C-c>'] = 'Close',
          },
          i = {
            ['<Esc>'] = 'Close',
            ['<C-c>'] = 'Close',
            ['<C-j>'] = 'Confirm',
          },
        },
      },
    })
  end,
}
