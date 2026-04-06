return {
  'iamcco/markdown-preview.nvim',
  ft = 'markdown',
  build = function()
    require('lazy').load({ plugins = { 'markdown-preview.nvim' } })
    vim.fn['mkdp#util#install']() -- installs with node
  end,
  config = function()
    vim.g.mkdp_auto_close = 0 -- closes tab afer exiting buffer
    vim.g.mkdp_refresh_slow = 0 -- refreshes only after exiting insert mode
    vim.g.mkdp_page_title = '「${name}」' -- page title
    vim.g.mkdp_combine_preview = 0 -- uses single page when calling multiple times
  end,
}
