return {
  {
    'windwp/nvim-autopairs', -- General pairs and <CR> indent behavior
    event = 'InsertEnter',
    config = function()
      local pairs = require('nvim-autopairs')
      pairs.setup({
        disable_filetype = {
          'TelescopePrompt',
          'harpoon',
          'dap-repl',
          'dapui_watches',
          'DressingInput',
        },

        -- Avoid buggy / iconsistent behavior on those modes
        disable_in_macro = true,
        disable_in_replace_mode = true,
        disable_in_visualblock = true,

        -- Indent
        map_cr = true, -- C-j is being mapped to CR outside

        -- Delete pairs with those
        map_bs = true,
        map_c_h = true,
        map_c_w = true,
      })

      local Rule = require('nvim-autopairs.rule')
      local cond = require('nvim-autopairs.conds')

      pairs.add_rules({
        Rule('<!--', '-->', { 'ejs' }):with_cr(cond.none()),
        Rule('>[%w%s]*$', '^%s*</', { 'ejs' }):only_cr():use_regex(true),
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag', -- Closes and rename html tags pairs
    event = 'InsertEnter',
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close_on_slash = true,
          enable_rename = true,
        },
        aliases = {
          ['ejs'] = 'html',
        },
      })
    end,
  },
}
