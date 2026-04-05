return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*', -- Recommended version for blink
  lazy = true,
  config = function()
    require('luasnip').config.set_config({
      history = true, -- Jumps through snippet even after finishing it
    })

    -- Custom snippets
    require('custom.luasnip.snippet_init')
  end,
}
