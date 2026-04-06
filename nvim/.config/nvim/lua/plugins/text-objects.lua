local textobj_keymaps = {
  select = {
    ['iv'] = { query = '@assignment.rhs', desc = 'Select inside (right) variable' },
    ['av'] = { query = '@assignment.lhs', desc = 'Select around (left) variable' },

    ['if'] = { query = '@function.inner', desc = 'Select inside function' },
    ['af'] = { query = '@function.outer', desc = 'Select around function' },

    ['im'] = { query = '@call.inner', desc = 'Select inside function call (method)' },
    ['am'] = { query = '@call.outer', desc = 'Select around function call (method)' },

    ['il'] = { query = '@loop.inner', desc = 'Select inside loop' },
    ['al'] = { query = '@loop.outer', desc = 'Select around loop' },

    ['ix'] = { query = '@conditional.inner', desc = 'Select inside conditional' },
    ['ax'] = { query = '@conditional.outer', desc = 'Select around conditional' },

    ['io'] = { query = '@class.inner', desc = 'Select inside class (object)' },
    ['ao'] = { query = '@class.outer', desc = 'Select around class (object)' },

    ['ia'] = { query = '@parameter.inner', desc = 'Select inside argument or parameter' },
    ['aa'] = { query = '@parameter.outer', desc = 'Select around argument or parameter' },

    ['ic'] = { query = '@comment.outer', desc = 'Select inside comment' }, -- @comment.inner not implemented for most languages
    ['ac'] = { query = '@comment.outer', desc = 'Select around comment' },

    ['ie'] = { query = '@statement.outer', desc = 'Select inside statement (every) ' }, -- @statement.inner tipically doesn't work
    ['ae'] = { query = '@statement.outer', desc = 'Select around statement (every)' },

    ['an'] = { query = '@number.inner', desc = 'Select number' },
    ['in'] = { query = '@number.inner', desc = 'Select number' },
  },
  swap_previous = {
    ['Hv'] = { query = '@assignment.outer', desc = 'Swap variable with previous' },
    ['Hf'] = { query = '@function.outer', desc = 'Swap function with previous' },
    ['Hm'] = { query = '@call.outer', desc = 'Swap function call (method) with previous' },
    ['Hl'] = { query = '@loop.outer', desc = 'Swap loop with previous' },
    ['Hx'] = { query = '@conditional.outer', desc = 'Swap conditional with previous' },
    ['Ho'] = { query = '@class.outer', desc = 'Swap class (object) with previous' },
    ['Ha'] = { query = '@parameter.inner', desc = 'Swap argument with previous' },
    ['Hc'] = { query = '@comment.outer', desc = 'Swap comment with previous' },
    ['He'] = { query = '@statement.outer', desc = 'Swap statement (every) with previous' },
    ['Hn'] = { query = '@number.inner', desc = 'Swap number with previous' },
  },
  swap_next = {
    ['Lv'] = { query = '@assignment.outer', desc = 'Swap variable with next' },
    ['Lf'] = { query = '@function.outer', desc = 'Swap function with next' },
    ['Lm'] = { query = '@call.outer', desc = 'Swap function call (method) with next' },
    ['Ll'] = { query = '@loop.outer', desc = 'Swap loop with next' },
    ['Lx'] = { query = '@conditional.outer', desc = 'Swap conditional with next' },
    ['Lo'] = { query = '@class.outer', desc = 'Swap class (object) with next' },
    ['La'] = { query = '@parameter.inner', desc = 'Swap argument with next' },
    ['Lc'] = { query = '@comment.outer', desc = 'Swap comment with next' },
    ['Le'] = { query = '@statement.outer', desc = 'Swap statement (every) with next' },
    ['Ln'] = { query = '@number.inner', desc = 'Swap number with next' },
  },
  goto_next_start = {
    [']v'] = { query = '@assignment.outer', desc = 'Next variable' },
    [']f'] = { query = '@function.outer', desc = 'Next function' },
    [']m'] = { query = '@call.outer', desc = 'Next function call (method)' },
    [']l'] = { query = '@loop.outer', desc = 'Next loop' },
    [']x'] = { query = '@conditional.outer', desc = 'Next conditional' },
    [']o'] = { query = '@class.outer', desc = 'Next class (object)' },
    [']a'] = { query = '@parameter.inner', desc = 'Next argument or parameter' },
    [']c'] = { query = '@comment.outer', desc = 'Next comment' },
    [']e'] = { query = '@statement.outer', desc = 'Next statement (every)' },
    [']n'] = { query = '@number.inner', desc = 'Next number' },
  },
  goto_next_end = {
    [']V'] = { query = '@assignment.outer', desc = 'Next variable on end' },
    [']F'] = { query = '@function.outer', desc = 'Next function on end' },
    [']M'] = { query = '@call.outer', desc = 'Next function call (method) on end' },
    [']L'] = { query = '@loop.outer', desc = 'Next loop on end' },
    [']X'] = { query = '@conditional.outer', desc = 'Next conditional on end' },
    [']O'] = { query = '@class.outer', desc = 'Next class (object) on end' },
    [']A'] = { query = '@parameter.inner', desc = 'Next argument or parameter on end' },
    [']C'] = { query = '@comment.outer', desc = 'Next comment on end' },
    [']E'] = { query = '@statement.outer', desc = 'Next statement (every) on end' },
    [']N'] = { query = '@number.inner', desc = 'Next number on end' },
  },
  goto_previous_start = {
    ['[v'] = { query = '@assignment.outer', desc = 'Previous variable' },
    ['[f'] = { query = '@function.outer', desc = 'Previous function' },
    ['[m'] = { query = '@call.outer', desc = 'Previous function call (method)' },
    ['[l'] = { query = '@loop.outer', desc = 'Previous loop' },
    ['[x'] = { query = '@conditional.outer', desc = 'Previous conditional' },
    ['[o'] = { query = '@class.outer', desc = 'Previous class (object)' },
    ['[a'] = { query = '@parameter.inner', desc = 'Previous argument or parameter' },
    ['[c'] = { query = '@comment.outer', desc = 'Previous comment' },
    ['[e'] = { query = '@statement.outer', desc = 'Previous statement (every)' },
    ['[n'] = { query = '@number.inner', desc = 'Previous number' },
  },
  goto_previous_end = {
    ['[V'] = { query = '@assignment.outer', desc = 'Previous variable on end' },
    ['[F'] = { query = '@function.outer', desc = 'Previous function on end' },
    ['[M'] = { query = '@call.outer', desc = 'Previous function call (method) on end' },
    ['[L'] = { query = '@loop.outer', desc = 'Previous loop on end' },
    ['[X'] = { query = '@conditional.outer', desc = 'Previous conditional on end' },
    ['[O'] = { query = '@class.outer', desc = 'Previous class (object) on end' },
    ['[A'] = { query = '@parameter.inner', desc = 'Previous argument or parameter on end' },
    ['[C'] = { query = '@comment.outer', desc = 'Previous comment on end' },
    ['[E'] = { query = '@statement.outer', desc = 'Previous statement (every) on end' },
    ['[N'] = { query = '@number.inner', desc = 'Previous number on end' },
  },
}

return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'master',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    keys = function()
      local keys = require('custom.text-objects.extract_lazy_keys')(textobj_keymaps)
      local other_keys = {
        {
          ';',
          function()
            require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move()
          end,
          mode = { 'n', 'x', 'o' },
        },
        {
          ',',
          function()
            require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move_opposite()
          end,
          mode = { 'n', 'x', 'o' },
        },

        -- make builtin f, F, t, T also repeatable with ; and ,
        {
          'f',
          function()
            return require('nvim-treesitter.textobjects.repeatable_move').builtin_f_expr()
          end,
          mode = { 'n', 'x', 'o' },
          expr = true,
        },
        {
          'F',
          function()
            return require('nvim-treesitter.textobjects.repeatable_move').builtin_F_expr()
          end,
          mode = { 'n', 'x', 'o' },
          expr = true,
        },
        {
          't',
          function()
            return require('nvim-treesitter.textobjects.repeatable_move').builtin_t_expr()
          end,
          mode = { 'n', 'x', 'o' },
          expr = true,
        },
        {
          'T',
          function()
            return require('nvim-treesitter.textobjects.repeatable_move').builtin_T_expr()
          end,
          mode = { 'n', 'x', 'o' },
          expr = true,
        },
        {
          ']d',
          function()
            require('custom.text-objects.repeat').diagnostic(true)
          end,
          desc = 'Next diagnostic',
          mode = { 'n', 'x', 'o' },
        },
        {
          '[d',
          function()
            require('custom.text-objects.repeat').diagnostic(false)
          end,
          desc = 'Previous diagnostic',
          mode = { 'n', 'x', 'o' },
        },
        {
          ']q',
          function()
            require('custom.text-objects.repeat').quickfix(true)
          end,
          desc = 'Next quickfix',
          mode = { 'n', 'x', 'o' },
        },
        {
          '[q',
          function()
            require('custom.text-objects.repeat').quickfix(false)
          end,
          desc = 'Previous Quickfix',
          mode = { 'n', 'x', 'o' },
        },
        {
          ']Q',
          function()
            require('custom.text-objects.repeat').quickfix_file(true)
          end,
          desc = 'Next quickfix file',
          mode = { 'n', 'x', 'o' },
        },
        {
          '[w',
          function()
            require('custom.text-objects.repeat').diff_change(false)
          end,
          desc = 'Previous diff change',
          mode = { 'n', 'x', 'o' },
        },
        {
          ']w',
          function()
            require('custom.text-objects.repeat').diff_change(true)
          end,
          desc = 'Next diff change',
          mode = { 'n', 'x', 'o' },
        },
        {
          "]'",
          function()
            require('custom.text-objects.repeat').mark(true)
          end,
          desc = 'Next mark',
          mode = { 'n', 'x', 'o' },
        },
        {
          "['",
          function()
            require('custom.text-objects.repeat').mark(false)
          end,
          desc = 'Previous mark',
          mode = { 'n', 'x', 'o' },
        },
        {
          '}',
          function()
            require('custom.text-objects.repeat').paragraph(true)
          end,
          desc = 'Next paragraph',
          mode = { 'n', 'x', 'o' },
        },
        {
          '{',
          function()
            require('custom.text-objects.repeat').paragraph(false)
          end,
          desc = 'Previous paragraph',
          mode = { 'n', 'x', 'o' },
        },
      }

      for _, other_key in ipairs(other_keys) do
        table.insert(keys, other_key)
      end
      return keys
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- jump to next ocurrence if not inside any

            keymaps = textobj_keymaps.select,
          },
          swap = {
            enable = true,
            swap_previous = textobj_keymaps.swap_previous,
            swap_next = textobj_keymaps.swap_next,
          },
          move = {
            enable = true,
            set_jumps = true, -- add to jump list

            goto_next_start = textobj_keymaps.goto_next_start,
            goto_next_end = textobj_keymaps.goto_next_end,
            goto_previous_start = textobj_keymaps.goto_previous_start,
            goto_previous_end = textobj_keymaps.goto_previous_end,
          },
        },
      })
    end,
  },
  {
    'echasnovski/mini.indentscope', -- indent textobjs
    version = '*',
    keys = {
      {
        'ii',
        function()
          require('mini.indentscope').textobject(false)
        end,
        mode = { 'x', 'o' },
        desc = 'Select inside indentation',
      },
      {
        'ai',
        function()
          require('mini.indentscope').textobject(true)
        end,
        desc = 'Select around indentation',
        mode = { 'x', 'o' },
      },
      {
        '[i',
        function()
          require('custom.text-objects.repeat').indent(false)
        end,
        desc = 'Previous indentation',
        mode = { 'n', 'x', 'o' },
      },
      {
        ']i',
        function()
          require('custom.text-objects.repeat').indent(true)
        end,
        desc = 'Next indentation',
        mode = { 'n', 'x', 'o' },
      },
    },
    config = function()
      vim.g.miniindentscope_disable = true -- disable indent highlight

      require('mini.indentscope').setup({
        options = {
          try_as_border = true, -- when in indent border selects it's children instead of parent
          indent_at_cursor = false, -- selects based on cursor column
        },
        mappings = {
          object_scope = '',
          object_scope_with_border = '',
          goto_top = '',
          goto_bottom = '',
        },
      })
    end,
  },
  {
    'chrisgrieser/nvim-various-textobjs', -- extra text-objects
    keys = {
      {
        'is',
        function()
          require('various-textobjs').subword('inner')
        end,
        desc = 'Select inside subword', -- camelCase, snake_case, kebab-case
        mode = { 'x', 'o' },
      },
      {
        'as',
        function()
          require('various-textobjs').subword('outer')
        end,
        desc = 'Select around subword',
        mode = { 'x', 'o' },
      },
      {
        'id',
        function()
          require('various-textobjs').entireBuffer()
        end,
        desc = 'Select entire document',
        mode = { 'x', 'o' },
      },
      {
        'ad',
        function()
          require('various-textobjs').entireBuffer()
        end,
        desc = 'Select entire document',
        mode = { 'x', 'o' },
      },
    },
    config = function()
      require('various-textobjs').setup({
        textobjs = {
          subword = {
            -- when deleting start of camelCase, changes remaining uppercase to lowercase
            noCamelToPascalCase = false,
          },
        },
        notify = {
          whenObjectNotFound = false,
        },
      })
    end,
  },
}
