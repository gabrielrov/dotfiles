local default_ai_tool = 'opencode'

return {
  'folke/sidekick.nvim',
  keys = {
    {
      '<leader>c',
      function()
        require('sidekick.cli').toggle({ name = default_ai_tool })
      end,
      desc = 'Toggle AI chat',
    },
    {
      '<leader>c',
      function()
        require('sidekick.cli').send({ msg = '{position}', name = default_ai_tool })
      end,
      mode = 'x',
      desc = 'Send selection as context to AI chat',
    },
    {
      '<leader>C',
      function()
        require('sidekick.cli').send({ name = default_ai_tool, msg = '{selection}' })
      end,
      mode = 'x',
      desc = 'Send selection to AI chat',
    },
    {
      '<leader>C',
      function()
        require('sidekick.cli').send({ msg = '{file}', name = default_ai_tool })
      end,
      desc = 'Send current file as context to AI chat',
    },
  },
  config = function()
    require('sidekick').setup({
      nes = { -- tab autocomplete feature
        enabled = false,
      },
      cli = {
        -- creates a tmux session if enabled
        mux = {
          enabled = true,
          backend = 'tmux',
          create = 'terminal',
        },
        win = {
          layout = 'float',
          float = {
            width = 1,
            height = 0.99,
          },
          split = {
            width = 0.45,
          },
          keys = {
            stopinsert = false,
            prompt = false,
            buffers = false,
            files = false,
            hide_n = false,
            hide_ctrl_q = false,
            hide_ctrl_dot = false,
            hide_ctrl_z = false,
            nav_left = false,
            nav_down = false,
            nav_up = false,
            nav_right = false,
          },
        },
      },
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'sidekick_terminal',
      callback = function()
        vim.keymap.set('t', '<C-h>', '<C-h>', { buffer = true }) -- regular behavior disabled by default for some reason

        vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>i <BS>', { buffer = true }) -- i <BS> helps with wrong positioning of cursor after jump glitch
        vim.keymap.set('n', 'i', '<cmd>nohlsearch<CR>i <BS>', { buffer = true })
        vim.keymap.set('n', 'I', '<cmd>nohlsearch<CR>I <BS>', { buffer = true })
        vim.keymap.set('n', 'a', '<cmd>nohlsearch<CR>a <BS>', { buffer = true })
        vim.keymap.set('n', 'A', '<cmd>nohlsearch<CR>A <BS>', { buffer = true })
        vim.keymap.set('x', '<C-j>', '<cmd>nohlsearch<CR>yi <BS>', { buffer = true })
        vim.keymap.set('x', '<CR>', '<cmd>nohlsearch<CR>yi <BS>', { buffer = true })
        vim.keymap.set('x', '<C-y>', '<cmd>nohlsearch<CR>"+yi <BS>', { buffer = true })

        vim.keymap.set('t', '<M-h>', '<cmd>silent! !tmux select-pane -L<CR>', { buffer = true })
        vim.keymap.set('t', '<M-j>', '<cmd>silent! !tmux select-pane -D<CR>', { buffer = true })
        vim.keymap.set('t', '<M-k>', '<cmd>silent! !tmux select-pane -U<CR>', { buffer = true })
        vim.keymap.set('t', '<M-l>', '<cmd>silent! !tmux select-pane -R<CR>', { buffer = true })

        -- registers
        vim.keymap.set('t', '<M-p>', '<C-\\><C-n>"+pi', { buffer = true })
        vim.keymap.set('t', '<M-P>', '<C-\\><C-n>"+pi', { buffer = true })

        vim.keymap.set('t', '<C-r>', function()
          local reg = vim.fn.getcharstr()
          if not reg:match('^[a-zA-Z0-9"#+*%%_/:.-]$') then
            return
          end

          local keys = vim.api.nvim_replace_termcodes('<C-\\><C-n>"' .. reg .. 'pi', true, false, true)
          vim.api.nvim_feedkeys(keys, 'n', false)
        end, { buffer = true })

        -------

        vim.keymap.set('t', '<Esc>', '<cmd>Sidekick cli toggle<CR>', { buffer = true, desc = 'Toggle cli' })

        vim.keymap.set('t', '<C-u>', function()
          local chan = vim.b.terminal_job_id
          vim.fn.chansend(chan, '\27\21') -- ctrl+alt+u
        end, { buffer = true, desc = 'Scroll up' })

        vim.keymap.set('t', '<C-d>', function()
          local chan = vim.b.terminal_job_id
          vim.fn.chansend(chan, '\27\4') -- ctrl+alt+d
        end, { buffer = true, desc = 'Scroll down' })

        vim.keymap.set('t', '<M-u>', '<C-u>', { buffer = true, desc = 'Delete line backwards' })
        vim.keymap.set('t', '<C-k>', '<Esc>', { buffer = true, desc = 'Go back' })

        vim.keymap.set('t', '<M-d>', '<C-d>', { buffer = true, desc = 'Kill process / delete session' })
        vim.keymap.set('t', '<M-r>', '<C-r>', { buffer = true, desc = 'Rename session' })

        vim.keymap.set('t', '<C-j>', '<CR>', { buffer = true, desc = 'Submit prompt / Confirm' })
        vim.keymap.set('t', '<CR>', '<C-j>', { buffer = true, desc = 'New line' })
      end,
    })
  end,
}
