return {
  'neovim/nvim-lspconfig', -- sets up lsp's
  dependencies = {
    'williamboman/mason.nvim', -- provides mason-lspconfig to use handlers
    'saghen/blink.cmp', -- provides capabilities for completion with lsp's
    'nvimtools/none-ls.nvim', -- setup none-ls server when loading
    { 'luckasRanarison/tailwind-tools.nvim', name = 'tailwind-tools' }, -- additional functionality for tailwind lsp
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- sets up mason installed servers
    require('mason-lspconfig').setup_handlers({
      function(server_name) -- default
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      ['lua_ls'] = function()
        lspconfig['lua_ls'].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        })
      end,

      ['html'] = function()
        local default = require('lspconfig.configs.html').default_config.filetypes
        local filetypes = vim.list_extend(vim.deepcopy(default), { 'ejs' })

        lspconfig['html'].setup({
          filetypes = filetypes,
          capabilities = capabilities,
        })
      end,

      ['emmet_ls'] = function()
        local default = require('lspconfig.configs.emmet_ls').default_config.filetypes
        local filetypes = vim.list_extend(vim.deepcopy(default), { 'ejs' })

        lspconfig['emmet_ls'].setup({
          filetypes = filetypes,
          capabilities = capabilities,
          init_options = {
            jsx = {
              options = { -- for possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ['output.selfClosingStyle'] = 'xhtml', -- closes self closing tags with a space before the slash
              },
            },
            html = {
              options = {
                ['output.selfClosingStyle'] = 'xhtml',
              },
            },
          },
        })
      end,

      ['ts_ls'] = function()
        lspconfig['ts_ls'].setup({
          capabilities = capabilities,
          settings = {
            diagnostics = {
              ignoredCodes = {
                7016, -- 'invalid' imports (causing incorrect linting)
                80001, -- commonJs imports,
              },
            },
          },
        })
      end,

      ['cssls'] = function()
        lspconfig['cssls'].setup({
          capabilities = capabilities,
          settings = {
            css = {
              lint = {
                unknownAtRules = 'ignore',
              },
            },
            scss = {
              lint = {
                unknownAtRules = 'ignore',
              },
            },
            less = {
              lint = {
                unknownAtRules = 'ignore',
              },
            },
          },
        })
      end,
    })
  end,
}
