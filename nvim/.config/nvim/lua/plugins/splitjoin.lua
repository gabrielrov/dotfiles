return {
  'Wansmer/treesj',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    { 'echasnovski/mini.splitjoin', version = '*' },
  },
  keys = {
    {
      'gs',
      function()
        require('treesj').toggle()
      end,
      desc = 'Split/join',
    },
  },
  config = function()
    local treesj = require('treesj')
    local mini_splitjoin = require('mini.splitjoin')

    mini_splitjoin.setup({
      mappings = { toggle = '' },
    })

    treesj.setup({
      use_default_keymaps = false,
      check_syntax_error = true, -- doesn't act on syntax errors in favor of fallback
      notify = false,
      max_join_length = 9999999999999999999,

      -- fallback config
      on_error = function()
        mini_splitjoin.toggle()
      end,
    })
  end,
}
