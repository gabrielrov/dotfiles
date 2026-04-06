return {
  'folke/flash.nvim',
  keys = {
    {
      's',
      function()
        require('flash').jump()
      end,
      desc = 'Flash jump',
      mode = { 'n', 'x', 'o' },
    },
    {
      'S',
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Flash jump to treesitter range',
      mode = { 'n', 'x', 'o' },
    },
    {
      'r',
      function()
        require('flash').remote()
      end,
      desc = 'Flash remote',
      mode = 'o',
    },
    {
      'R',
      function()
        local register = vim.v.register
        require('flash').treesitter_search({
          action = function(match, state)
            require('flash.jump').remote_op(match, state, register)
          end,
        })
      end,
      desc = 'Flash remote on treesitter range',
      mode = 'o',
    },
  },
  config = function()
    local flash = require('flash')

    flash.setup({
      search = {
        multi_window = true,
        exclude = {
          'notify',
          'noice',
          'flash_prompt',
          function(win)
            -- exclude non-focusable windows
            return not vim.api.nvim_win_get_config(win).focusable
          end,
        },
      },
      highlight = {
        backdrop = true, -- when searching, fade out text
        matches = true, -- highlights text as you type
        groups = {
          backdrop = 'FlashBackdrop',
          label = 'FlashLabel',
          match = 'FlashMatch',
          current = 'FlashMatch', -- does not show different color to first match
        },
      },
      modes = {
        char = {
          enabled = false,
          highlight = {
            backdrop = false, -- fade out text with f/t
          },
        },
        treesitter_search = {
          label = {
            rainbow = {
              enabled = true,
            },
          },
        },
      },
    })

    -- consistent highlights
    -- local function set_highlights()
    --   vim.api.nvim_set_hl(0, 'FlashBackdrop', { fg = '#6c7087' })
    --   vim.api.nvim_set_hl(0, 'FlashLabel', { fg = '#a6e3a2' })
    --   vim.api.nvim_set_hl(0, 'FlashMatch', { fg = '#b4beff' })
    -- end
    --
    -- set_highlights()
    --
    -- vim.api.nvim_create_autocmd('ColorScheme', {
    --   pattern = '*',
    --   callback = set_highlights,
    -- })
  end,
}
