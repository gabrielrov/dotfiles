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
          require('lazy').load({ plugins = { 'yazi.nvim' } })
        end
      end,
    })
  end,
  config = function()
    require('yazi').setup({
      open_for_directories = true,
      clipboard_register = '+',
      highlight_hovered_buffers_in_same_directory = false,

      yazi_floating_window_border = 'none',
      floating_window_scaling_factor = 1,

      keymaps = {
        show_help = '<F2>',

        open_file_in_vertical_split = '<C-v>',
        open_file_in_horizontal_split = '<C-s>',
        open_file_in_tab = '<C-t>',

        copy_relative_path_to_selected_files = '<C-y>',
        send_to_quickfix_list = '<C-q>',
        grep_in_directory = '<c-g>',
        change_working_directory = '<C-\\>',

        cycle_open_buffers = false,

        -- uses other dependencies
        open_and_pick_window = false,
        replace_in_directory = false,
      },
    })
  end,
}
