local ls = require('luasnip')
local fmt = require('custom.luasnip.fmt')

local s = ls.snippet -- new snippet
local i = ls.insert_node -- insert cursor

ls.add_snippets('lua', {
  s('l', fmt('local {}', { i(1) })),
  s('re', fmt("require('{}')", { i(1) })),
})
