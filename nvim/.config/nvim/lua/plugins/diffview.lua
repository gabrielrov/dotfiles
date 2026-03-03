return {
  'sindrets/diffview.nvim',
  keys = {
    { '<leader>L', '<cmd>DiffviewOpen<CR>', desc = 'Open git diffview for file changes' },
    { '<leader>v', '<cmd>DiffviewFileHistory<CR>', desc = 'Open git diffview history' },
    { '<leader>V', '<cmd>DiffviewFileHistory %<CR>', desc = 'Open git diffview history (file)' },
    { '<leader>v', ':DiffviewFileHistory<CR>', desc = 'Open git diffview history (range)', mode = 'x' },
    { '<leader>V', ':DiffviewFileHistory<CR>', desc = 'Open git diffview history (range)', mode = 'x' },
  },
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  config = function()
    local actions = require('diffview.actions')
    local close_win = require('utils.close_win')

    local goto_file_and_close = function()
      actions.goto_file_edit()
      vim.cmd('tabclose #')
    end

    local scroll = 0.35
    local scroll_s = 0.12

    local map = {
      close = '<Esc>',
      help = 'g?',
      cycle_layout = '-',
      goto_file = 'gF',
      goto_file_c = 'gf',
      scroll_down = '<C-d>',
      scroll_down_s = '<M-d>',
      scroll_up = '<C-u>',
      scroll_up_s = '<M-u>',
      restore = 'R',

      choose_ours = '<leader>[',
      choose_theirs = '<leader>]',
      choose_both = '<leader>=',
      choose_none = '<leader>-',

      select_next_entry = 'J',
      select_prev_entry = 'K',

      prev_conflict = '[g',
      next_conflict = ']g',
    }

    require('diffview').setup({
      show_help_hints = false,
      enhanced_diff_hl = true, -- Smooth colors on deletion block

      view = {
        file_history = {
          -- Config for changed files in file history views
          winbar_info = false,
        },
        default = {
          -- Config for changed files, and staged files in diff views
          winbar_info = false,
        },
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase
          layout = 'diff3_mixed',
          winbar_info = true,
        },
      },
      file_panel = {
        win_config = {
          position = 'left',
          width = 35,
        },
      },
      file_history_panel = {
        win_config = {
          position = 'bottom',
          height = 12,
        },
      },
      keymaps = {
        disable_defaults = true,
        view = {
          { 'n', map.goto_file_c, goto_file_and_close, { desc = 'Open the file in the previous tabpage and close' } },
          { 'n', map.goto_file, actions.goto_file_edit, { desc = 'Open the file in the previous tabpage' } },

          { 'n', map.cycle_layout, actions.cycle_layout, { desc = 'Cycle through available layouts.' } },

          {
            'n',
            map.next_conflict,
            function()
              require('custom.text-objects.repeat').diffview_conflict(true)
            end,
            { desc = 'Go to the next conflict' },
          },
          {
            'n',
            map.prev_conflict,
            function()
              require('custom.text-objects.repeat').diffview_conflict(false)
            end,
            { desc = 'Go to the previous conflict' },
          },

          { 'n', map.choose_ours, actions.conflict_choose_all('ours'), { desc = 'Choose current git conflict' } },
          { 'n', map.choose_theirs, actions.conflict_choose_all('theirs'), { desc = 'Choose merged git conflict' } },
          { 'n', map.choose_both, actions.conflict_choose_all('all'), { desc = 'Choose both git conflicts' } },
          { 'n', map.choose_none, actions.conflict_choose_all('none'), { desc = 'Choose neither of git conflicts' } },

          { 'n', map.select_next_entry, actions.select_next_entry, { desc = 'Open the diff for the next file' } },
          { 'n', map.select_prev_entry, actions.select_prev_entry, { desc = 'Open the diff for the previous file' } },

          { 'n', '<C-Space>', actions.toggle_files, { desc = 'Toggle the file panel' } },
          { 'n', '<C-h>', '<Nop>' },
          { 'n', '<C-j>', '<Nop>' },
          { 'n', '<C-k>', '<Nop>' },
          { 'n', '<C-l>', actions.open_commit_log, { desc = 'Open the commit log panel' } },

          {
            'n',
            map.close,
            function()
              close_win('DiffviewClose')
            end,
            { desc = 'Close diffview' },
          },
        },
        diff1 = {
          { 'n', map.help, actions.help({ 'view', 'diff1' }), { desc = 'Open the help panel' } },
        },
        diff2 = {
          { 'n', map.help, actions.help({ 'view', 'diff2' }), { desc = 'Open the help panel' } },
        },
        diff3 = {
          { 'n', map.help, actions.help({ 'view', 'diff3' }), { desc = 'Open the help panel' } },
        },
        diff4 = {
          { 'n', map.help, actions.help({ 'view', 'diff4' }), { desc = 'Open the help panel' } },
        },
        file_panel = {
          { 'n', map.restore, actions.restore_entry, { desc = 'Restore entry to the state on the left side' } },

          { 'n', map.scroll_down, actions.scroll_view(scroll), { desc = 'Scroll the view down' } },
          { 'n', map.scroll_down_s, actions.scroll_view(scroll_s), { desc = 'Scroll the view down slightly' } },
          { 'n', map.scroll_up, actions.scroll_view(-scroll), { desc = 'Scroll the view up' } },
          { 'n', map.scroll_up_s, actions.scroll_view(-scroll_s), { desc = 'Scroll the view up slightly' } },

          { 'n', 'j', actions.next_entry, { desc = 'Bring the cursor to the next file entry' } },
          { 'n', 'k', actions.prev_entry, { desc = 'Bring the cursor to the previous file entry' } },

          { 'n', '<2-LeftMouse>', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          { 'n', '<Cr>', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          { 'n', 'l', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          { 'n', 'h', actions.close_fold, { desc = 'Collapse fold' } },

          { 'n', map.goto_file_c, goto_file_and_close, { desc = 'Open the file in the previous tabpage and close' } },
          { 'n', map.goto_file, actions.goto_file_edit, { desc = 'Open the file in the previous tabpage' } },

          { 'n', 'g.', actions.listing_style, { desc = "Toggle between 'list' and 'tree' views" } },

          { 'n', map.cycle_layout, actions.cycle_layout, { desc = 'Cycle available layouts' } },

          { 'n', map.prev_conflict, actions.prev_conflict, { desc = 'Go to the previous conflict' } },
          { 'n', map.next_conflict, actions.next_conflict, { desc = 'Go to the next conflict' } },

          { 'n', map.choose_ours, actions.conflict_choose_all('ours'), { desc = 'Choose current git conflict' } },
          { 'n', map.choose_theirs, actions.conflict_choose_all('theirs'), { desc = 'Choose merged git conflict' } },
          { 'n', map.choose_both, actions.conflict_choose_all('all'), { desc = 'Choose both git conflicts' } },
          { 'n', map.choose_none, actions.conflict_choose_all('none'), { desc = 'Choose neither of git conflicts' } },

          { 'n', 'za', actions.toggle_fold, { desc = 'Toggle fold' } },
          { 'n', 'zo', actions.open_fold, { desc = 'Expand fold' } },
          { 'n', 'zc', actions.close_fold, { desc = 'Collapse fold' } },
          { 'n', 'zr', actions.open_all_folds, { desc = 'Expand all folds' } },
          { 'n', 'zm', actions.close_all_folds, { desc = 'Collapse all folds' } },

          { 'n', map.select_next_entry, actions.select_next_entry, { desc = 'Open the diff for the next file' } },
          { 'n', map.select_prev_entry, actions.select_prev_entry, { desc = 'Open the diff for the previous file' } },

          { 'n', map.help, actions.help('file_panel'), { desc = 'Open the help panel' } },

          { 'n', '<C-Space>', actions.toggle_files, { desc = 'Toggle the file panel' } },
          { 'n', '<C-h>', '<Nop>' },
          { 'n', '<C-j>', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          { 'n', '<C-k>', actions.close_fold, { desc = 'Collapse fold' } },
          { 'n', '<C-l>', actions.open_commit_log, { desc = 'Open the commit log panel' } },

          {
            'n',
            map.close,
            function()
              close_win('DiffviewClose')
            end,
            { desc = 'Close diffview' },
          },
          { desc = 'Close diffview' },
        },
        file_history_panel = {
          { 'n', map.restore, actions.restore_entry, { desc = 'Restore file to the state from the selected entry' } },

          { 'n', 'gd', actions.open_in_diffview, { desc = 'Open the entry under the cursor in a diffview' } },
          { 'n', 'gy', actions.copy_hash, { desc = 'Copy the commit hash of the entry under the cursor' } },

          { 'n', map.scroll_down, actions.scroll_view(scroll), { desc = 'Scroll the view down' } },
          { 'n', map.scroll_down_s, actions.scroll_view(scroll_s), { desc = 'Scroll the view down slightly' } },
          { 'n', map.scroll_up, actions.scroll_view(-scroll), { desc = 'Scroll the view up' } },
          { 'n', map.scroll_up_s, actions.scroll_view(-scroll_s), { desc = 'Scroll the view up slightly' } },

          { 'n', 'j', actions.next_entry, { desc = 'Bring the cursor to the next file entry' } },
          { 'n', 'k', actions.prev_entry, { desc = 'Bring the cursor to the previous file entry' } },

          { 'n', '<2-LeftMouse>', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          { 'n', '<Cr>', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          { 'n', 'l', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          { 'n', 'h', actions.close_fold, { desc = 'Collapse fold' } },

          { 'n', map.goto_file_c, goto_file_and_close, { desc = 'Open the file in the previous tabpage and close' } },
          { 'n', map.goto_file, actions.goto_file_edit, { desc = 'Open the file in the previous tabpage' } },

          { 'n', 'za', actions.toggle_fold, { desc = 'Toggle fold' } },
          { 'n', 'zo', actions.open_fold, { desc = 'Expand fold' } },
          { 'n', 'zc', actions.close_fold, { desc = 'Collapse fold' } },
          { 'n', 'zr', actions.open_all_folds, { desc = 'Expand all folds' } },
          { 'n', 'zm', actions.close_all_folds, { desc = 'Collapse all folds' } },

          { 'n', map.select_next_entry, actions.select_next_entry, { desc = 'Open the diff for the next file' } },
          { 'n', map.select_prev_entry, actions.select_prev_entry, { desc = 'Open the diff for the previous file' } },

          { 'n', map.cycle_layout, actions.cycle_layout, { desc = 'Cycle available layouts' } },
          { 'n', map.help, actions.help('file_history_panel'), { desc = 'Open the help panel' } },

          { 'n', '<C-Space>', actions.toggle_files, { desc = 'Toggle the file panel' } },
          {
            'n',
            '<C-h>',
            function()
              actions.toggle_files()
              actions.options()
            end,
            { desc = 'Open the option panel' },
          },
          { 'n', '<C-j>', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          { 'n', '<C-k>', actions.close_fold, { desc = 'Collapse fold' } },
          { 'n', '<C-l>', actions.open_commit_log, { desc = 'Open the commit log panel' } },

          {
            'n',
            map.close,
            function()
              close_win('DiffviewClose')
            end,
            { desc = 'Close diffview' },
          },
        },
        option_panel = {
          { 'n', '<CR>', actions.select_entry, { desc = 'Change the current option' } },
          { 'n', map.help, actions.help('option_panel'), { desc = 'Open the help panel' } },

          { 'n', '<C-Space>', '<Nop>' },
          { 'n', '<C-h>', '<Nop>' },
          { 'n', '<C-j>', actions.select_entry, { desc = 'Change the current option' } },
          { 'n', '<C-k>', '<Nop>' },
          { 'n', '<C-l>', actions.open_commit_log, { desc = 'Open the commit log panel' } },

          {
            'n',
            map.close,
            function()
              if vim.v.hlsearch ~= 0 then
                return vim.cmd('nohlsearch')
              end

              close_win(actions.close)
              actions.toggle_files()
            end,
            { desc = 'Close selection menu' },
          },
        },
        help_panel = {
          { 'n', '<C-Space>', '<Nop>' },
          { 'n', '<C-h>', '<Nop>' },
          { 'n', '<C-j>', '<Nop>' },
          { 'n', '<C-k>', '<Nop>' },
          { 'n', '<C-l>', '<Nop>' },

          {
            'n',
            map.close,
            function()
              close_win(actions.close)
            end,
            { desc = 'Close help menu' },
          },
        },
      },
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'DiffviewFileHistory',
      callback = function()
        vim.defer_fn(function()
          vim.cmd('set wrap')
        end, 0)
      end,
    })
  end,
}
