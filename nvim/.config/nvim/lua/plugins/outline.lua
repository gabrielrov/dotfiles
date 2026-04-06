return {
  'hedyhli/outline.nvim',
  keys = {
    { '<leader>s', '<cmd>Outline<CR>', desc = 'Toggle outline (symbols)' },
  },
  config = function()
    require('utils.ft').clear_c_hjkl('Outline', { bind_c_j = true })
    require('utils.ft').bind_close_win('Outline', 'OutlineClose')
    require('utils.ft').bind_close_win('OutlineHelp', 'close')

    require('outline').setup({
      outline_window = {
        position = 'right',
        auto_close = true, -- closes window if item is selected with enter
        focus_on_open = true,
      },
      outline_items = {
        show_symbol_details = false, -- extra symbol details as virtual text
        show_symbol_lineno = false, -- line numbers for each symbol
      },
      keymaps = {
        fold_all = 'H',
        unfold_all = 'L',

        show_help = 'g?',
        toggle_preview = '<Nop>',
        close = '<Nop>',
        down_and_jump = 'J',
        up_and_jump = 'K',
        restore_location = '-',
      },
      symbols = {
        icons = {
          Constant = { icon = '', hl = 'Constant' },
        },
      },
    })

    require('utils.ft').bind_close_win('OutlineHelp', 'close')
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'Outline',
      callback = function()
        vim.keymap.set('n', '<C-o>', '<Nop>', { buffer = true })
        vim.keymap.set('n', '<C-i>', '<Nop>', { buffer = true })
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'OutlineHelp',
      callback = function()
        vim.defer_fn(function()
          vim.keymap.set('n', '<Esc>', function()
            require('utils.close_win')('close')
          end, { buffer = true })
        end, 0)
      end,
    })
  end,
}
