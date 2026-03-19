return {
  'williamboman/mason.nvim', -- The package manager
  dependencies = {
    'williamboman/mason-lspconfig.nvim', -- Allow lspconfig server names
    'WhoIsSethDaniel/mason-tool-installer.nvim', -- API to ensure that mason installs packages
  },
  lazy = false,
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup()

    require('utils.ft').clear_c_hjkl('mason', { bind_c_j = true })

    require('mason-tool-installer').setup({
      ensure_installed = {
        -- Language servers
        'html',
        'cssls',
        'ts_ls',
        'tailwindcss',
        'emmet_ls',
        'lua_ls',
        'eslint',
        'prismals',

        'jsonls',

        -- Formatters
        'prettier',
        'stylua',

        -- Debugger adapters
        'js-debug-adapter',
      },
    })
  end,
}
