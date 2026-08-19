return {
  'mikavilpas/yazi.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>w',
      '<cmd>Yazi<CR>',
      mode = { 'n', 'v' },
      desc = 'Open yazi at current file',
    },
    {
      '<leader>W',
      '<cmd>Yazi cwd<CR>',
      desc = 'Open yazi at current directory',
    },
    {
      '<leader>e',
      '<cmd>Yazi toggle<CR>',
      desc = 'Open last yazi session',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function(data)
        local stat = vim.uv.fs_stat(data.file)
        if stat and stat.type == 'directory' then
          require('lazy').load({ plugins = { 'noice.nvim' } }) -- load for account for new status bar height when positioning win
          require('lazy').load({ plugins = { 'yazi.nvim' } })
        end
      end,
    })
  end,
  config = function()
    require('utils.ft').bind_tmux_nav('yazi')

    local function set_highlights()
      vim.api.nvim_set_hl(0, 'YaziBorder', { fg = '#4C566A' })
    end

    set_highlights()
    vim.api.nvim_create_autocmd('ColorScheme', { pattern = '*', callback = set_highlights })

    require('yazi').setup({
      open_for_directories = true,
      clipboard_register = '"',
      highlight_hovered_buffers_in_same_directory = false,

      floating_window_scaling_factor = 0.92,

      yazi_floating_window_border = {
        { '┌', 'YaziBorder' },
        { '─', 'YaziBorder' },
        { '┐', 'YaziBorder' },
        { '│', 'YaziBorder' },
        { '┘', 'YaziBorder' },
        { '─', 'YaziBorder' },
        { '└', 'YaziBorder' },
        { '│', 'YaziBorder' },
      },

      hooks = {
        before_opening_window = function(options)
          options.width = options.width - 1
          options.height = options.height - 1
        end,
      },

      keymaps = {
        show_help = '<F2>',

        change_working_directory = '<M-/>',

        copy_relative_path_to_selected_files = '<C-y>',
        send_to_quickfix_list = '<M-q>',
        grep_in_directory = '<M-g>',

        open_file_in_vertical_split = '<M-v>',
        open_file_in_horizontal_split = '<M-s>',
        open_file_in_tab = '<M-t>',

        cycle_open_buffers = false,

        -- uses other dependencies
        open_and_pick_window = false,
        replace_in_directory = false,
      },
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'yazi',
      callback = function(args)
        -- goes to terminal mode when getting back from popups (e.g when asking if files should be modified)
        vim.api.nvim_create_autocmd('WinEnter', {
          buffer = args.buf,
          callback = function()
            vim.cmd('norm! i')
          end,
        })
      end,
    })
  end,
}
