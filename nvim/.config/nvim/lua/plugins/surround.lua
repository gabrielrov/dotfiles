local keymaps = {
  -- autopairs
  insert = false,
  insert_line = false,

  -- sufixed with 'line' also indents
  normal = '\\',
  normal_cur = '\\\\',
  visual = '\\',
  normal_line = '|',
  normal_cur_line = '||',
  visual_line = '|',
  delete = '\\d',
  change = '\\c',
  change_line = '|c',
}

return {
  'kylechui/nvim-surround',
  version = '*',
  keys = {
    { keymaps.normal, desc = 'Add a surrounding pair around a motion (normal mode)' },
    { keymaps.normal_cur, desc = 'Add a surrounding pair around the current line (normal mode)' },
    { keymaps.visual, desc = 'Add a surrounding pair around a visual selection', mode = 'x' },
    { keymaps.normal_line, desc = 'Add a surrounding pair around a motion, on new lines (normal mode)' },
    { keymaps.normal_cur_line, desc = 'Add a surrounding pair around the current line, on new lines (normal mode)' },
    { keymaps.visual_line, desc = 'Add a surrounding pair around a visual selection, on new lines', mode = 'x' },
    { keymaps.delete, desc = 'Delete a surrounding pair' },
    { keymaps.change, desc = 'Change a surrounding pair' },
    { keymaps.change_line, desc = 'Change a surrounding pair, putting replacements on new lines' },
  },
  config = function()
    require('nvim-surround').setup({
      -- swap open and closing pairs bindings for whitepaces
      surrounds = {
        [')'] = {
          add = { '( ', ' )' },
          delete = '^(. ?)().-( ?.)()$',
        },
        ['('] = {
          add = { '(', ')' },
          delete = '^(.)().-(.)()$',
        },
        ['}'] = {
          add = { '{ ', ' }' },
          delete = '^(. ?)().-( ?.)()$',
        },
        ['{'] = {
          add = { '{', '}' },
          delete = '^(.)().-(.)()$',
        },
        ['>'] = {
          add = { '< ', ' >' },
          delete = '^(. ?)().-( ?.)()$',
        },
        ['<'] = {
          add = { '<', '>' },
          delete = '^(.)().-(.)()$',
        },
        [']'] = {
          add = { '[ ', ' ]' },
          delete = '^(. ?)().-( ?.)()$',
        },
        ['['] = {
          add = { '[', ']' },
          delete = '^(.)().-(.)()$',
        },
      },
      aliases = {
        ['a'] = '<',
        ['b'] = '(',
        ['B'] = '{',
        ['r'] = '[',
        ['q'] = { '"', "'", '`' },
        ['s'] = { '{', '[', '(', '<', '"', "'", '`' },
      },

      move_cursor = 'sticky',
      keymaps = keymaps,
    })
  end,
}
