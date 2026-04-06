return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'ThePrimeagen/harpoon',
    'letieu/harpoon-lualine',
  },
  lazy = false,
  config = function()
    local icons = require('utils.icons')

    local options = {
      theme = 'auto',
      disabled_filetypes = {
        statusline = {}, -- only ignores the ft for statusline.
        winbar = {}, -- only ignores the ft for winbar.
        -- ignores for both \/
      },

      --                     
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
    }

    local sections = {
      lualine_a = {},
      lualine_b = {
        {
          'harpoon2',
          icon = '󰛢',
          indicators = { '1', '2', '3', '4' },
          active_indicators = { '1', '2', '3', '4' },
          color_active = { fg = '#10b981' },

          padding = { left = 1, right = 1 },
        },
      },
      lualine_c = {
        {
          'filetype',
          padding = { left = 1, right = 0 },
          icon_only = true,
          icon = {
            align = 'left',
          },
        },
        {
          'filename',
          path = 1, -- displayed path
          symbols = {
            modified = icons.buffer.modified,
            readonly = '',
            unnamed = 'Unnamed',
            newfile = '',
          },
        },
        -- show macros
        {
          function()
            local reg = vim.fn.reg_recording()
            if reg == '' then
              return ''
            end
            return ' recording @' .. reg
          end,
          color = { fg = '#ff9e64' },
          padding = { left = 2, right = 1 },
        },
      },
      lualine_x = {
        {
          'searchcount',
          padding = { left = 1, right = 2 },
        },
        {
          'diagnostics',
          symbols = {
            hint = icons.diagnostics.hint,
            info = icons.diagnostics.info,
            warn = icons.diagnostics.warn,
            error = icons.diagnostics.error,
          },
          padding = { left = 1, right = 2 },
        },
        {
          'diff',
          padding = { left = 1, right = 1 },
          colored = true,
          symbols = {
            added = ' ',
            modified = ' ',
            removed = ' ',
          },
          -- where to get git info from
          source = function()
            -- using gitsigns, it updates in real time, with no need to save
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
      },
      lualine_y = {
        {
          padding = { left = 1, right = 0 },
          function()
            return vim.t.maximized and ' ' or ''
          end,
        },
        {
          function()
            local line_count = vim.api.nvim_buf_line_count(0)
            return line_count .. 'L'
          end,
        },
        {
          padding = { left = 0, right = 1 },
          'progress',
        },
      },
      lualine_z = {},
    }

    -- custom
    local oil = {
      options = vim.deepcopy(options),
      sections = vim.deepcopy(sections),
      filetypes = { 'oil' },
    }

    -- cleaner displayed path
    oil.sections.lualine_c[2] = {
      function()
        local oil_directory = vim.fn.fnamemodify(require('oil').get_current_dir(), ':~')
        local modified_symbol = vim.bo.modified and ' ' .. icons.buffer.modified or ''
        return oil_directory .. modified_symbol
      end,
    }

    require('lualine').setup({
      options = options,
      sections = sections,
      extensions = { oil },
    })
  end,
}
