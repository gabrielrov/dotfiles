return {
  'williamboman/mason.nvim', -- the package manager
  dependencies = {
    'williamboman/mason-lspconfig.nvim', -- allow lspconfig server names
    'WhoIsSethDaniel/mason-tool-installer.nvim', -- API to ensure that mason installs packages
  },
  lazy = false,
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup()

    require('utils.ft').clear_c_hjkl('mason', { bind_c_j = true })

    require('mason-tool-installer').setup({
      ensure_installed = {
        -- language servers
        'html',
        'cssls',
        'ts_ls',
        'tailwindcss',
        'emmet_ls',
        'lua_ls',
        'eslint',
        'prismals',

        'jsonls',

        -- formatters
        'prettier',
        'stylua',

        -- debugger adapters
        'js-debug-adapter',
      },
    })
  end,
}
