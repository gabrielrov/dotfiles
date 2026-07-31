return {
  {
    -- whenever y is used, the cursor doesn't move to start
    'svban/YankAssassin.nvim',
    lazy = false,
    config = function()
      require('YankAssassin').setup({
        -- enabled modes
        auto_normal = true,
        auto_visual = true,
      })
    end,
  },
  {
    -- automatically detects indentation and tab type when opening a buffer
    'tpope/vim-sleuth',
    event = { 'BufReadPre', 'BufNewFile' },
  },
}
