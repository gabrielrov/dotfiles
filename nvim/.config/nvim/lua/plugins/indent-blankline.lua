return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  main = 'ibl',
  config = function()
    require('ibl').setup({
      indent = {
        char = '▏',
        tab_char = '▏', -- still show indent guides if indent is a tab
      },
      scope = {
        enabled = false,
      },
      exclude = {
        filetypes = {
          'undotree',
          'harpoon',
          'trouble',
          'text',
          'markdown',
        },
      },
    })
  end,
}
