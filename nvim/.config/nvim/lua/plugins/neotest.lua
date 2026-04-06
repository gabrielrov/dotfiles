return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',

    'marilari88/neotest-vitest',
    'nvim-neotest/neotest-jest',
  },
  keys = {
    {
      '<leader>x',
      function()
        require('neotest').summary.toggle()
        local win = vim.fn.bufwinid('Neotest Summary')
        if win > -1 then
          vim.api.nvim_set_current_win(win) -- autofocus window
        end
      end,
      desc = 'Toggle neotest summary',
    },
    {
      '<leader>X',
      function()
        require('neotest').output.open({ enter = true, last_run = true })
      end,
      desc = 'Toggle neotest output',
    },
  },
  config = function()
    local neotest = require('neotest')
    neotest.setup({
      adapters = {
        require('neotest-vitest'),
        require('neotest-jest')({
          jestCommand = 'npm test --',
          jestConfigFile = 'custom.jest.config.ts',
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      },
      status = {
        signs = false,
      },
      diagnostic = {
        enabled = false,
      },
      output = {
        open_on_run = false, -- popup that opens after running tests
      },
      summary = {
        animated = true,
        count = true, -- display number of tests found
        expand_errors = true, -- expand all errors
        follow = true, -- expand on current file
        mappings = {
          attach = 'a',
          clear_marked = 'M',
          clear_target = 'T',
          debug = 'gd',
          debug_marked = 'gD',
          expand = { 'h', '<2-LeftMouse>' },
          expand_all = { 'l', 'e' },
          help = 'g?',
          jumpto = '<C-j>',
          mark = 'm',
          next_failed = 'J',
          output = 'o',
          prev_failed = 'K',
          run = 'r',
          run_marked = 'R',
          short = 'O',
          stop = 'u',
          target = 't',
          watch = 'gw',
        },
        open = 'botright vsplit | vertical resize 50',
      },
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'neotest-summary',
      callback = function()
        vim.keymap.set('n', '<CR>', '<C-j>', { remap = true })
        vim.keymap.set('n', '<Esc>', function()
          require('utils.close_win')('Neotest summary close')
        end, { buffer = true })
      end,
    })
  end,
}
