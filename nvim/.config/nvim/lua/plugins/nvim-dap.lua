return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio', -- Async stuff
    },
    keys = {
      {
        '<leader>j',
        function()
          require('dap').continue()
        end,
        desc = 'Continue debugger',
      },
      {
        '<leader>0',
        function()
          require('dap').run_last()
        end,
        desc = 'Rerun last debugger session',
      },
      {
        '<leader>J',
        function()
          local dap = require('dap')
          local dapui = require('dapui')
          local session = dap.session()

          -- 'terminate' on sessions of type 'launch', else defaults to 'disconnect'
          if session and session.config.request == 'launch' then
            dap.terminate({ all = true, hierarchy = true })
          else
            dap.disconnect({ terminateDebuggee = true })
            dap.close()
          end

          dapui.close()
          dap.repl.close()
          dap.clear_breakpoints()
        end,
        desc = 'Disconnect debugger',
      },
      {
        '<leader>k',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle debugger breakpoint',
      },
      {
        '<leader>K',
        function()
          require('dap').clear_breakpoints()
        end,
        desc = 'Clear debugger breakpoints',
      },
      {
        '<leader>9',
        function()
          require('dap').set_breakpoint(nil, nil, vim.fn.input('Log Point'))
        end,
        desc = 'Set log debugger breakpoint',
      },
      {
        '<leader>8',
        function()
          require('dap').set_breakpoint(vim.fn.input('Condition'))
        end,
        desc = 'Set conditional debugger breakpoint',
      },
      {
        '<leader>7',
        function()
          require('dap').set_breakpoint(nil, vim.fn.input('Hit Condition'))
        end,
        desc = 'Set hit condition debugger breakpoint',
      },
      {
        '<leader>m',
        function()
          require('dap').repl.close({ mode = 'toggle' })
          require('dapui').toggle({ reset = true })
        end,
        desc = 'Toggle debugger ui',
      },
      {
        'M',
        function()
          require('dapui').eval(nil, { enter = true })
        end,
        mode = { 'n', 'x' },
        desc = 'Eval debugger expression',
      },
      {
        '<leader>i',
        function()
          require('dapui').close()
          require('dap').repl.toggle({ height = 12 })
        end,
        desc = 'Toggle debugger repl',
      },
      {
        '<leader>I',
        function()
          require('dap').repl.clear()
        end,
        desc = 'Clear debugger repl',
      },
      {
        '<leader>1',
        function()
          require('dap').step_over()
        end,
        desc = 'Step over on debugger',
      },
      {
        '<leader>2',
        function()
          require('dap').step_into()
        end,
        desc = 'Step into on debugger',
      },
      {
        '<leader>3',
        function()
          require('dap').step_out()
        end,
        desc = 'Step out on debugger',
      },
      {
        '<leader>4',
        function()
          require('dap').step_back()
        end,
        desc = 'Step back on debugger',
      },
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      local ft = require('utils.ft')

      ft.clear_c_hjkl({
        'dapui_watches',
        'dapui_scopes',
        'dapui_stacks',
        'dapui_breakpoints',
        'dap-repl',
        'dapui_console',
        'dapui_hover',
      }, { bind_c_j = true })

      ft.bind_close_win({
        'dapui_watches',
        'dapui_scopes',
        'dapui_stacks',
        'dapui_breakpoints',
        'dapui_console',
        'dapui_hover',
      }, dapui.close)

      ft.bind_close_win('dap-repl', function()
        dapui.close()
        dap.repl.close({ mode = 'toggle' })
      end)

      ft.bind_shell_movements({ 'dap-repl', 'dapui_watches' })

      dapui.setup({
        layouts = { -- 'console' contents usually appear on 'repl'
          {
            elements = {
              {
                id = 'scopes',
                size = 0.70,
              },
              {
                id = 'breakpoints',
                size = 0.10,
              },
              {
                id = 'stacks',
                size = 0.20,
              },
            },
            position = 'left',
            size = 40,
          },
          {
            elements = {
              {
                id = 'watches',
                size = 0.5,
              },
              {
                id = 'repl',
                size = 0.5,
              },
            },
            position = 'bottom',
            size = 11,
          },
        },
        controls = {
          element = 'repl',
          enabled = false, -- Disable repl icons
        },
        mappings = {
          edit = 'e',
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          repl = 'r',
          toggle = 't',
        },
      })

      vim.fn.sign_define('DapBreakpoint', {
        text = '󰻃', -- 󰻃 
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      })

      vim.fn.sign_define('DapBreakpointRejected', {
        text = '󰻃',
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      })

      vim.fn.sign_define('DapStopped', {
        text = '', --  → 
        texthl = 'Conditional',
        linehl = 'Visual',
        numhl = '',
      })
      vim.fn.sign_define('DapBreakpointCondition', {
        text = '󰻃',
        texthl = 'Conditional',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapLogPoint', {
        text = '󰻃',
        texthl = 'DiagnosticSignInfo',
        linehl = '',
        numhl = '',
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'dap-repl', 'dapui_watches' },
        callback = function()
          vim.keymap.set('i', '<C-w>', '<C-S-w>', { buffer = true }) -- Fix C-w triggering window bindings
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'dap-repl',
        callback = function()
          vim.cmd('set wrap')

          vim.keymap.set('n', '<C-e>', function()
            dap.repl.clear()
          end, { buffer = true })

          vim.keymap.set('n', 'gf', function()
            require('custom.nvim-dap.repl_go_to_path')(true)
          end, { buffer = true })

          vim.keymap.set('n', 'gF', function()
            require('custom.nvim-dap.repl_go_to_path')(false)
          end, { buffer = true })
        end,
      })

      require('custom.nvim-dap.adapter_init')
    end,
  },
  {
    'rcarriga/cmp-dap',
    dependencies = {
      'mfussenegger/nvim-dap',
      'hrsh7th/nvim-cmp',
    },
    ft = { 'dap-repl', 'dapui_watches', 'dapui_hover' },
    config = function()
      local cmp = require('cmp')

      cmp.setup.filetype(
        { 'dap-repl', 'dapui_watches', 'dapui_hover' },
        require('custom.nvim-cmp.completions.nvim-dap')
      )
    end,
  },
}
