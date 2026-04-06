local ls = require('luasnip')
local fmt = require('custom.luasnip.fmt')

local s = ls.snippet -- new snippet
local i = ls.insert_node -- insert cursor
local f = ls.function_node
local rep = require('luasnip.extras').rep -- repeats

-- local jest = {
--   s('jd', fmt("describe('{}', () => {{\n  {}\n}})", { i(1), i(2, '//') })),
--   s('jt', fmt("test('{}', () => {{\n  {}\n}})", { i(1), i(2, '//') })),
--   s('je', fmt('expect({}).toBe({})', { i(1), i(2) })),
-- }
--
-- ls.add_snippets('javascript', jest)

local common = {
  s('c', fmt('const {}', { i(1) })),
  s('l', fmt('let {}', { i(1) })),

  s('imp', fmt("import {{ {} }} from '{}'", { i(2), i(1) })),
  s('re', fmt("require('{}')", { i(1) })),

  s(
    'for',
    fmt(
      [[
        for (let {} = 0; {} < {}; {}++) {{
          {}
        }}
      ]],
      { i(1, 'i'), rep(1, 'i'), i(2, '_'), rep(1, 'i'), i(3) }
    )
  ),

  s(
    'forof',
    fmt(
      [[
        for (const {} of {}) {{
          {}
        }}
      ]],
      { i(1, 'name'), i(2, '_'), i(3) }
    )
  ),

  s(
    'forin',
    fmt(
      [[
        for (const {} in {}) {{
          {}
        }}
      ]],
      { i(1, 'name'), i(2, '_'), i(3) }
    )
  ),

  s('cl', fmt('console.log({})', i(1))),

  s(
    'if',
    fmt(
      [[
        if ({}) {{
          {}
        }}
      ]],
      { i(1), i(2) }
    )
  ),

  s(
    'tch',
    fmt(
      [[
        switch ({}) {{
          case '{}': {{
            {}
          }}
        }}
      ]],
      { i(1), i(2), i(3) }
    )
  ),

  s(
    'dowhile',
    fmt(
      [[
        do {{
          {}
        }} while ({})
      ]],
      { i(2), i(1) }
    )
  ),

  s(
    'try',
    fmt(
      [[
        try {{
          {}
        }} catch (err) {{
          {}
        }}
      ]],
      { i(1), i(2) }
    )
  ),
}

local javascript = {
  s('fs', fmt('({}) => {}', { i(1), i(2) })),

  s(
    'f',
    fmt(
      [[
        ({}) => {{
          {}
        }}
      ]],
      { i(1), i(2) }
    )
  ),

  s(
    'cf',
    fmt(
      [[
        const {} = ({}) => {{
          {}
        }}
      ]],
      { i(1, 'name'), i(2), i(3) }
    )
  ),

  s(
    'lf',
    fmt(
      [[
        let {} = ({}) => {{
          {}
        }}
      ]],
      { i(1, 'name'), i(2), i(3) }
    )
  ),

  s(
    'fun',
    fmt(
      [[
        function {}({}) {{
          {}
        }}
      ]],
      { i(1, 'name'), i(2), i(3) }
    )
  ),

  s(
    'ef',
    fmt(
      [[
        export default function {}({}) {{
          {}
        }}
      ]],
      {
        f(function(_, snip)
          return vim.fn.fnamemodify(snip.env.TM_FILENAME, ':r')
        end),
        i(1),
        i(2),
      }
    )
  ),
}

local typescript = {
  s('fs', fmt('({}){} => {}', { i(1), i(2), i(3) })),

  s(
    'f',
    fmt(
      [[
        ({}){} => {{
          {}
        }}
      ]],
      { i(1), i(2), i(3) }
    )
  ),

  s(
    'cf',
    fmt(
      [[
        const {} = ({}){} => {{
          {}
        }}
      ]],
      { i(1, 'name'), i(2), i(3), i(4) }
    )
  ),

  s(
    'lf',
    fmt(
      [[
        let {} = ({}){} => {{
          {}
        }}
      ]],
      { i(1, 'name'), i(2), i(3), i(4) }
    )
  ),

  s(
    'fun',
    fmt(
      [[
        function {}({}){} {{
          {}
        }}
      ]],
      { i(1, 'name'), i(2), i(3), i(4) }
    )
  ),

  s(
    'ef',
    fmt(
      [[
        export default function {}({}){} {{
          {}
        }}
      ]],
      {
        f(function(_, snip)
          return vim.fn.fnamemodify(snip.env.TM_FILENAME, ':r')
        end),
        i(1),
        i(2),
        i(3),
      }
    )
  ),

  s('t', fmt('type {}', { i(1) })),
  s(
    'i',
    fmt(
      [[
        interface {} {{
          {}
        }}
      ]],
      { i(1, 'Name'), i(2) }
    )
  ),
}

local react = {
  s(
    'us',
    fmt('const [{}, set{}] = useState({})', {
      i(1, 'name'),
      f(function(args)
        return args[1][1]:gsub('^%l', string.upper)
      end, { 1 }),
      i(2),
    })
  ),
}

ls.add_snippets('javascript', common)
ls.add_snippets('javascript', javascript)
ls.add_snippets('javascriptreact', common)
ls.add_snippets('javascriptreact', javascript)
ls.add_snippets('javascriptreact', react)

ls.add_snippets('typescript', common)
ls.add_snippets('typescript', typescript)
ls.add_snippets('typescriptreact', common)
ls.add_snippets('typescriptreact', typescript)
ls.add_snippets('typescriptreact', react)
