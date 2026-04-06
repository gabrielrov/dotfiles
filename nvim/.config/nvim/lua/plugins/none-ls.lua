return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  lazy = true,
  config = function()
    local null_ls = require('null-ls')
    local formatting = null_ls.builtins.formatting

    null_ls.setup({
      sources = {
        -- formatters
        formatting.stylua,
        formatting.prettier.with({
          -- treats '.ejs' as if it was '.html'
          extra_filetypes = { 'ejs' },
          extra_args = function(params)
            if params.bufname:match('%.ejs$') then
              return { '--parser', 'html' }
            end
            return {}
          end,
        }),
      },
    })
  end,
}
