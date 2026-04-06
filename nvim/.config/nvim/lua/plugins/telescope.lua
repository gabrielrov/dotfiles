return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<C-f>', '<cmd>Telescope find_files<CR>', desc = 'Find files' },
    {
      '<C-f>',
      function()
        require('oil.actions').close.callback()
        vim.cmd('Telescope find_files')
      end,
      desc = 'Find files',
      ft = 'oil',
    },

    {
      '<leader>ff',
      function()
        require('telescope.builtin').find_files({ hidden = true, prompt_title = 'Find Files (Hidden)' })
      end,
      desc = 'Find files including hidden',
    },
    {
      '<leader>ff',
      function()
        require('oil.actions').close.callback()
        require('telescope.builtin').find_files({ hidden = true, prompt_title = 'Find Files (Hidden)' })
      end,
      desc = 'Find files including hidden',
      ft = 'oil',
    },

    {
      '<leader>fe',
      function()
        require('telescope.builtin').find_files({
          hidden = true,
          no_ignore = true,
          prompt_title = 'Find Files (Hidden,Ignored)',
        })
      end,
      desc = 'Find every file',
    },
    {
      '<leader>fe',
      function()
        require('oil.actions').close.callback()
        require('telescope.builtin').find_files({
          hidden = true,
          no_ignore = true,
          prompt_title = 'Find Files (Hidden,Ignored)',
        })
      end,
      desc = 'Find every file',
      ft = 'oil',
    },

    {
      '<leader>fl',
      function()
        local icons = require('utils.icons')
        require('telescope.builtin').git_status({
          git_icons = {
            added = icons.git.added,
            deleted = icons.git.deleted,
            changed = icons.git.modified,
            renamed = icons.git.renamed,
            untracked = icons.git.untracked,
            copied = '>',
            unmerged = '‡',
          },
        })
      end,
      desc = 'Find git status files',
    },
    {
      '<leader>fk',
      function()
        require('telescope.builtin').keymaps({ show_plug = false })
      end,
      desc = 'Find keymaps',
    },
    {
      '<leader>fn',
      function()
        require('telescope.builtin').find_files({
          hidden = true,
          cwd = '~/dotfiles/',
          prompt_title = 'Dotfiles',
        })
      end,
      desc = 'Find dotfiles (neovim and alike)',
    },

    { '<leader>fa', '<cmd>Telescope live_grep<CR>', desc = 'Find all strings (grep)' },
    {
      '<leader>fa',
      function()
        vim.cmd('Alpha')
        vim.cmd('Telescope live_grep')
      end,
      desc = 'Find all strings (grep)',
      ft = 'alpha',
    },

    { '<leader>fd', '<cmd>Telescope diagnostics<CR>', desc = 'Find diagnostics' },

    { '<leader>fq', '<cmd>Telescope quickfix<CR>', desc = 'Find quickfix' },
    { '<leader>Q', '<cmd>Telescope quickfixhistory<CR>', desc = 'Find quickfix history' },

    { '<leader>/', '<cmd>Telescope search_history<CR>', desc = 'Find search history' },
    { '<leader>?', '<cmd>Telescope search_history<CR>', desc = 'Find search history' },
    { '<leader><C-n>', '<cmd>Telescope search_history<CR>', desc = 'Find search history' },
    { '<leader><M-n>', '<cmd>Telescope search_history<CR>', desc = 'Find search history' },

    { '<leader>:', '<cmd>Telescope command_history<CR>', desc = 'Find command history' },
    { '<leader><C-p>', '<cmd>Telescope command_history<CR>', desc = 'Find command history' },

    { '<leader>f/', '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'Find in buffer' },
    { '<leader>f<C-n>', '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'Find in buffer' },
    { '<leader>f<M-n>', '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'Find in buffer' },

    { '<leader>fo', '<cmd>Telescope oldfiles<CR>', desc = 'Find oldfiles' },
    { '<leader>fb', '<cmd>Telescope buffers<CR>', desc = 'Find buffers' },
    { '<leader>fc', '<cmd>Telescope colorscheme<CR>', desc = 'Find colorschemes' },

    { '<leader>fs', '<cmd>Telescope lsp_document_symbols<CR>', desc = 'Find symbols' },
    { '<leader>fS', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', desc = 'Find symbols across project' },

    { '<leader>fy', '<cmd>Telescope registers<CR>', desc = 'Find registers' },
    { '<leader>fm', '<cmd>Telescope marks<CR>', desc = 'Find marks' },

    { 'gd', '<cmd>Telescope lsp_definitions<CR>', desc = 'Go to definition' },
    { 'gr', '<cmd>Telescope lsp_references<CR>', desc = 'Go to references' },
    { 'gt', '<cmd>Telescope lsp_type_definitions<CR>', desc = 'Go to type definition' },
    { 'gI', '<cmd>Telescope lsp_implementations<CR>', desc = 'Go to implementations' },

    { 'g[', '<cmd>Telescope lsp_incoming_calls<CR>', desc = 'Go to incoming calls' },
    { 'g]', '<cmd>Telescope lsp_outgoing_calls<CR>', desc = 'Go to outgoing calls' },

    { '<leader>f.', '<cmd>Telescope resume<CR>', desc = 'Telescope resume' },
    { '<leader>fh', '<cmd>Telescope help_tags<CR>', desc = 'Find help' },
  },
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<C-x>'] = false,
            ['<C-f>'] = false,
            ['<M-f>'] = false,

            ['<C-s>'] = actions.select_horizontal,

            ['<Esc>'] = actions.close,
            ['<C-j>'] = actions.select_default,

            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
          },
        },
      },
      pickers = {
        git_status = {
          mappings = {
            i = {
              ['<C-g>'] = actions.git_staging_toggle,
              ['<Tab>'] = function(bufnr)
                actions.toggle_selection(bufnr)
                actions.move_selection_previous(bufnr)
              end,
            },
          },
        },
      },
    })
  end,
}
