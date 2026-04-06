return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*', -- recommended version for blink
  lazy = true,
  config = function()
    require('luasnip').config.set_config({
      history = true, -- jumps through snippet even after finishing it
    })

    -- custom snippets
    require('custom.luasnip.snippet_init')
  end,
}
