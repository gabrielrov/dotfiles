return {
  {
    'numToStr/Comment.nvim', -- Enhances comment motions
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    keys = {
      { 'gc', desc = 'Comment toggle linewise' },
      { 'gC', 'gc$', desc = 'Comment to end of line', remap = true },
      { 'gc', desc = 'Comment toggle linewise (visual)', mode = 'x' },
      { 'gcc', desc = 'Comment toggle current line' },
      { 'gco', desc = 'Comment insert below' },
      { 'gcO', desc = 'Comment insert above' },
      { 'gcA', desc = 'Comment insert end of line' },
      { 'gcgc', desc = 'Comment undo' },
      { 'gb', desc = 'Comment toggle blockwise' },
      { 'gB', 'gb$', desc = 'Comment toggle blockwise to end of line', remap = true },
      { 'gb', desc = 'Comment toggle blockwise (visual)', mode = 'x' },
      { 'gbb', desc = 'Comment toggle current line blockwise' },
      { 'gbc', desc = 'Comment toggle current block' },
    },
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring', -- Context aware comments (ex. jsx)
    lazy = true,
    config = function()
      require('ts_context_commentstring').setup({
        enable_autocmd = false,
      })
    end,
  },
}
