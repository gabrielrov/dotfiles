return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    {
      '<C-l>',
      function()
        require('custom.harpoon.select')(1)
      end,
      desc = 'Go to harpoon mark 1',
    },
    {
      '<C-k>',
      function()
        require('custom.harpoon.select')(2)
      end,
      desc = 'Go to harpoon mark 2',
    },
    {
      '<C-j>',
      function()
        require('custom.harpoon.select')(3)
      end,
      desc = 'Go to harpoon mark 3',
    },
    {
      '<C-h>',
      function()
        require('custom.harpoon.select')(4)
      end,
      desc = 'Go to harpoon mark 4',
    },
    {
      '<C-q>',
      function()
        require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
      end,
      desc = 'Harpoon',
    },
    {
      '<leader><C-q>',
      function()
        require('custom.harpoon.telescope_picker')()
      end,
      desc = 'Find harpoon marks',
    },
    {
      '<C-m>',
      function()
        require('custom.harpoon.mark')()
      end,
      desc = 'Set harpoon mark',
    },
  },
  config = function()
    local harpoon = require('harpoon')

    require('utils.ft').clear_c_hjkl('harpoon', { bind_c_j = true })

    harpoon:setup({
      settings = {
        save_on_toggle = true,
      },
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'harpoon',
      callback = function()
        -- go to normal mode when saving
        vim.keymap.set({ 'n', 'i', 'x', 's' }, '<C-s>', '<Esc><cmd>w<CR>', { buffer = true })

        vim.defer_fn(function()
          -- harpoon is overiting this binding on every interaction, thus the need to defer
          vim.keymap.set('n', '<Esc>', function()
            require('utils.close_win')('close')
          end, { buffer = true })
        end, 0)
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      -- remove mark binding for those
      pattern = 'qf',
      callback = function()
        vim.keymap.set('n', '<C-m>', '<C-m>', { buffer = true })
      end,
    })
  end,
}
