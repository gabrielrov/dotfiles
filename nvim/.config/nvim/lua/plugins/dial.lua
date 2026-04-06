return {
  'monaqa/dial.nvim',
  keys = {
    {
      '<C-a>',
      function()
        require('dial.map').manipulate('increment', 'normal')
      end,
      desc = 'Dial increment',
    },
    {
      '<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'normal')
      end,
      desc = 'Dial decrement',
    },
    {
      'g<C-a>',
      function()
        require('dial.map').manipulate('increment', 'gnormal')
      end,
      desc = 'Dial increment sequentially',
    },
    {
      'g<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'gnormal')
      end,
      desc = 'Dial decrement sequentially',
    },
    {
      '<C-a>',
      function()
        require('dial.map').manipulate('increment', 'visual')
        vim.cmd('norm! gv')
      end,
      desc = 'Dial increment (visual)',
      mode = 'x',
    },
    {
      '<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'visual')
        vim.cmd('norm! gv')
      end,
      desc = 'Dial decrement (visual)',
      mode = 'x',
    },
    {
      'g<C-a>',
      function()
        require('dial.map').manipulate('increment', 'gvisual')
        vim.cmd('norm! gv')
      end,
      desc = 'Dial increment sequentially (visual)',
      mode = 'x',
    },
    {
      'g<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'gvisual')
        vim.cmd('norm! gv')
      end,
      desc = 'Dial decrement sequentially (visual)',
      mode = 'x',
    },
  },
  config = function()
    local config = require('dial.config')
    local augend = require('dial.augend') --'augend' is a term used in the context of incrementing or decrementing things

    config.augends:register_group({
      default = {
        augend.integer.alias.decimal, -- decimal, decimal_int (includes negative numbers)
        augend.constant.alias.bool,
        augend.date.alias['%Y/%m/%d'],
        augend.integer.alias.hex, -- nonnegative hex number (0x01, 0x1a1f)
        augend.hexcolor.new({ -- (#60a5fa)
          case = 'prefer_lower', -- upper, lower, prefer_upper, prefer_lower
        }),

        -- Exemple:
        -- augend.constant.new({
        --   elements = { '&&', '||' },
        --   word = false, -- true if must be a separated 'word' *
        --   cyclic = true, -- cycle from the last to the first result
        -- }),
      },
    })
  end,
}
