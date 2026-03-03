return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master', -- NOTE: Older and more stable branch
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('nvim-treesitter.configs').setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },

      ensure_installed = {
        'vim',
        'vimdoc',
        'regex',
        'diff',
        'tmux',
        'lua',
        'javascript',
        'tsx',
        'html',
        'css',
        'typescript',
        'jsdoc',
        'bash',
        'markdown',
        'markdown_inline',
        'yaml',
        'toml',
        'query',
        'json',
        'gitcommit',
        'gitignore',
        'git_config',
        'sql',
        'prisma',
      },
    })
  end,
}
