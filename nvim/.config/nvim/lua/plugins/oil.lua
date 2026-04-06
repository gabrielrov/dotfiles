local toggle_binding = '<leader>w'

return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    {
      toggle_binding,
      function()
        require('oil').open_float()
      end,
      desc = 'Open oil (workspace)',
    },
  },
  cmd = 'Oil',
  init = function()
    -- loads oil if nvim was opened on a directory
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function(data)
        local stat = vim.uv.fs_stat(data.file)
        if stat and stat.type == 'directory' then
          require('lazy').load({ plugins = { 'oil.nvim' } })
        end
      end,
    })
  end,
  config = function()
    local oil = require('oil')

    local show_hidden = true

    -- notify when toggling hidden files
    local hidden_enabled = show_hidden
    local notify_toggle_hidden = {
      callback = function()
        oil.toggle_hidden()
        hidden_enabled = not hidden_enabled

        if hidden_enabled then
          vim.notify('Hidden files enabled')
        else
          vim.notify('Hidden files disabled')
        end
      end,
      mode = 'n',
      desc = 'Toggle hidden files',
    }

    oil.setup({
      default_file_explorer = true,
      watch_for_changes = true, -- watch the filesystem for changes and reload oil

      lsp_file_methods = {
        enabled = true,
        autosave_changes = false, -- autosave buffers that are updated with lsp
      },
      win_options = {
        wrap = true,
      },

      view_options = {
        show_hidden = show_hidden, -- show files and directories that start with "."

        is_hidden_file = function(name) -- what is considered a hidden file
          return vim.startswith(name, '.')
        end,
        is_always_hidden = function(name) -- never show
          return name == '..'
        end,
      },

      preview_win = {
        preview_method = 'scratch', -- loads entire buffer without attaching lsp (necessary to scroll)
      },

      use_default_keymaps = false,
      keymaps = {
        ['<C-space>'] = 'actions.open_cwd',
        ['<C-h>'] = 'actions.open_cwd',

        ['<C-j>'] = 'actions.select',
        ['<C-k>'] = 'actions.parent',

        ['<C-l>'] = 'actions.preview',

        ['K'] = 'actions.preview_scroll_up',
        ['J'] = 'actions.preview_scroll_down',

        ['gd'] = { 'actions.cd', opts = { scope = 'tab' }, desc = 'Change cwd on tab', mode = 'n' },
        ['gr'] = 'actions.refresh',
        ['g.'] = notify_toggle_hidden,
        ['gs'] = 'actions.change_sort',
        ['g?'] = 'actions.show_help',

        [toggle_binding] = 'actions.close',
        ['<C-c>'] = 'actions.close',

        ['<CR>'] = 'actions.select',
      },
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'oil_preview', -- confirmation popup
      callback = function()
        vim.keymap.set('n', '<C-j>', 'y', { buffer = true, remap = true })
        vim.keymap.set('n', '<CR>', 'y', { buffer = true, remap = true })
        vim.keymap.set('n', '<C-k>', 'n', { buffer = true, remap = true })
        vim.keymap.set('n', '<C-h>', '<Nop>', { buffer = true })
        vim.keymap.set('n', '<C-l>', '<Nop>', { buffer = true })
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'oil',
      callback = function()
        local actions = require('oil.actions')

        vim.keymap.set('n', '<Esc>', function()
          require('utils.close_win')(actions.close.callback)
        end, { buffer = true })

        -- allow saving while in insert mode
        vim.keymap.set({ 'n', 'i', 'x', 's' }, '<C-s>', '<Esc><cmd>w<CR>', { buffer = true })
      end,
    })
  end,
}
