return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    {
      ']h',
      function()
        require('custom.text-objects.repeat').git_hunk(true)
      end,
      desc = 'Git next hunk',
      mode = { 'n', 'x', 'o' },
    },
    {
      '[h',
      function()
        require('custom.text-objects.repeat').git_hunk(false)
      end,
      desc = 'Git previous hunk',
      mode = { 'n', 'x', 'o' },
    },
    { '<leader>h', '<cmd>Gitsigns preview_hunk<CR>', desc = 'Git preview hunk diff' },
    { '<leader>H', '<cmd>Gitsigns reset_hunk<CR>', desc = 'Git reset hunk' },
    { '<leader>H', ':Gitsigns reset_hunk<CR>', desc = 'Git reset selected hunk', mode = 'x' },
    { '<leader>b', '<cmd>Gitsigns blame_line<CR>', desc = 'Git preview blame' },
    { '<leader>B', '<cmd>Gitsigns blame<CR>', desc = 'Git all blames' },
    { '<leader>g', '<cmd>Gitsigns stage_hunk<CR>', desc = 'Git stage hunk' },
    { '<leader>g', ':Gitsigns stage_hunk<CR>', desc = 'Git stage selected hunk', mode = 'x' },
    { 'ih', '<cmd>Gitsigns select_hunk<CR>', desc = 'Select hunk', mode = { 'o', 'x' } },
    { 'ah', '<cmd>Gitsigns select_hunk<CR>', desc = 'Select hunk', mode = { 'o', 'x' } },
  },
  config = function()
    require('utils.ft').clear_c_hjkl('gitsigns-blame', { bind_c_j = true })
    require('utils.ft').bind_close_win('gitsigns-blame', 'close')

    require('gitsigns').setup({
      -- untracked files don't need to be refreshed when committed to be attached
      attach_to_untracked = true,
      signs = {
        untracked = { text = '' },
      },
    })
  end,
}
