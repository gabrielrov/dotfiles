local dap_fts = { 'dap-repl', 'dapui_watches', 'dapui_hover' }

return {
  'saghen/blink.cmp',
  version = '1.*', -- use a release tag to download pre-built binaries
  dependencies = {
    'L3MON4D3/LuaSnip', -- engine responsable for snippets
    'mayromr/blink-cmp-dap',
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    local blink = require('blink.cmp')
    local interface = require('custom.blink.interface')
    local completions = require('custom.blink.completion_init')

    blink.setup({
      enabled = function()
        return not vim.tbl_contains({ 'DressingInput', 'oil', 'TelescopePrompt', 'harpoon' }, vim.bo.filetype)
      end,
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'dap' },
        per_filetype = vim.tbl_extend('force', {
          ['dap-repl'] = { 'dap' },
          dapui_watches = { 'dap' },
          dapui_hover = { 'dap' },
        }, completions.sources),

        providers = {
          lsp = {
            opts = {
              tailwind_color_icon = '',
            },
            transform_items = interface.filter('lsp'),
          },
          snippets = {
            score_offset = 10,
            should_show_items = function(ctx)
              -- hides snippets after trigger characters
              if ctx.trigger.initial_kind == 'trigger_character' then
                return false
              end

              local ok, node = pcall(vim.treesitter.get_node)
              if ok and node and vim.startswith(node:type(), 'string') then
                return false
              end

              return true
            end,
            transform_items = interface.filter('snippets'),
          },
          dap = {
            name = 'dap',
            module = 'blink-cmp-dap',
          },
        },
      },

      fuzzy = {
        max_typos = 0,
        sorts = interface.sorts({ 'score', 'sort_text' }),
      },

      completion = {
        menu = {
          max_height = 10,
          scrolloff = 0,

          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  if vim.api.nvim_get_mode().mode == 'c' then
                    return '' -- removes icons in cmdline
                  end
                  return ctx.kind_icon .. ctx.icon_gap
                end,
              },
            },
          },
          cmdline_position = function()
            if vim.g.ui_cmdline_pos ~= nil then -- custom (i.e noice)
              local pos = vim.g.ui_cmdline_pos
              return { pos[1] - 1, pos[2] + 1 } -- matches position with removed cmdline icons
            end
            local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
            return { vim.o.lines - height, 0 }
          end,
        },

        list = {
          selection = {
            preselect = function()
              return not vim.tbl_contains(dap_fts, vim.bo.filetype)
            end,
          },
        },

        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = false },
        trigger = {
          show_on_keyword = true, -- alphanumeric, '-' and '_'
          show_on_trigger_character = true, -- chars provided by lsp

          show_on_backspace = false,

          show_on_insert = false,
          show_on_insert_on_trigger_character = false,
          show_on_accept_on_trigger_character = false, -- triggers when cursor comes after trigger character after completion

          show_on_blocked_trigger_characters = { ' ', '\n', '\t', '}' }, -- autopairs triggers closing chars (i.e '}')
        },
      },
      signature = {
        enabled = true,
        trigger = { enabled = false },
        window = {
          scrollbar = true,
          show_documentation = false,
        },
      },
      snippets = { preset = 'luasnip' },
      keymap = { preset = 'none' },
      cmdline = {
        completion = {
          ghost_text = { enabled = false },
          list = {
            selection = {
              preselect = false,
            },
          },
          menu = {
            auto_show = function()
              local type = vim.fn.getcmdtype()
              return type == '/' or type == '?'
            end,
          },
        },
        keymap = {
          preset = 'none',
          ['<C-space>'] = { 'show', 'hide' },
          ['<Tab>'] = { 'show_and_insert_or_accept_single', 'select_next' },
          ['<S-Tab>'] = { 'show_and_insert_or_accept_single', 'select_prev' },
          ['<C-n>'] = { 'select_next', 'fallback' },
          ['<C-p>'] = { 'select_prev', 'fallback' },
          ['<C-l>'] = { 'accept' },
          ['<C-c>'] = { 'cancel', 'fallback' },
        },
      },
      appearance = {
        kind_icons = {
          Text = '󰉿',
          Variable = '',
          Function = '󰆧',
          Method = '󰆧',
          Unit = '󰑭',
          Operator = '󰆕',
          Constructor = '󰒓',
          Class = '󰠱',
          Field = '󰜢',
          Property = '󰜢',
          Interface = '',
          Struct = '󰙅',
          Module = '󰅩',
          Constant = '',
          Value = '',
          Enum = '',
          EnumMember = '',
          Keyword = '󰌋',
          Color = '󰏘',
          File = '󰈙',
          Reference = '󰈇',
          Folder = '󰉋 ',
          Snippet = '',
          Event = '',
          TypeParameter = '',
        },
        use_nvim_cmp_as_default = true, -- sets highlight groups to nvim-cmp's, good for support
      },
    })

    vim.keymap.set('i', '<C-Space>', function()
      -- NOTE: currently blink.show doesn't return boolean properly when a provider is passed, using 'show' for now
      -- local providers = vim.tbl_keys(require('blink.cmp.sources.lib').get_enabled_providers())
      -- local filtered_providers = vim.tbl_filter(function(provider)
      --   return provider ~= 'snippets'
      -- end, providers)
      --
      -- blink.show({ providers = filtered_providers })
      return blink.show() or blink.show_documentation() or blink.hide_documentation()
    end)

    vim.keymap.set('i', '<C-j>', function()
      return blink.select_and_accept() or vim.api.nvim_input('<CR>') -- works with autopairs indent
    end)

    vim.keymap.set('i', '<C-n>', blink.select_next)
    vim.keymap.set('i', '<C-p>', blink.select_prev)

    vim.keymap.set('i', '<C-u>', function()
      return blink.scroll_documentation_up()
        or vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-u>', true, false, true), 'n', false)
    end)

    vim.keymap.set('i', '<C-d>', function()
      return blink.scroll_documentation_down()
        or vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-d>', true, false, true), 'n', false)
    end)

    vim.keymap.set({ 'i', 's' }, '<C-l>', function()
      return blink.snippet_forward() and blink.hide()
    end)

    vim.keymap.set({ 'i', 's' }, '<C-k>', function()
      return blink.snippet_backward() and blink.hide()
    end)

    vim.keymap.set('i', '<C-q>', function()
      return blink.show_signature() or blink.hide_signature()
    end)

    vim.keymap.set('i', '<C-c>', function()
      return blink.cancel() or vim.api.nvim_input('<C-c>')
    end)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = dap_fts,
      callback = function()
        vim.keymap.set('i', '<C-j>', '<CR>')

        vim.keymap.set('i', '<C-Space>', function()
          return blink.show() or blink.hide()
        end, { buffer = true })

        vim.keymap.set('i', '<Tab>', function()
          return blink.show_and_insert_or_accept_single() or blink.select_next()
        end, { buffer = true })

        vim.keymap.set('i', '<S-Tab>', function()
          return blink.show_and_insert_or_accept_single() or blink.select_prev()
        end, { buffer = true })
      end,
    })
  end,
}
