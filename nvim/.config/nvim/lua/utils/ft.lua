local M = {}

--- @param ft string | table
--- @param action string | function
M.bind_close_win = function(ft, action)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = ft,
    callback = function()
      local close_win = require('utils.close_win')

      vim.keymap.set('n', '<Esc>', function()
        close_win(action)
      end, { buffer = true })
    end,
  })
end

--- @param ft string | table
--- @param opts? { bind_c_j?: boolean }
M.clear_c_hjkl = function(ft, opts)
  opts = opts or {}

  vim.api.nvim_create_autocmd('FileType', {
    pattern = ft,
    callback = function()
      vim.keymap.set('n', '<C-h>', '<Nop>', { buffer = true })
      vim.keymap.set('n', '<C-k>', '<Nop>', { buffer = true })
      vim.keymap.set('n', '<C-l>', '<Nop>', { buffer = true })
      vim.keymap.set('n', '<C-space>', '<Nop>', { buffer = true })

      if opts.bind_c_j then
        vim.keymap.set('n', '<C-j>', '<CR>', { buffer = true, remap = true })
      else
        vim.keymap.set('n', '<C-j>', '<Nop>', { buffer = true })
      end
    end,
  })
end

--- @param ft string | table
--- @param mode? string | table
M.bind_tmux_nav = function(ft)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = ft,
    callback = function()
      local modes = { 'n', 'i', 'x', 's', 'o', 't', 'c' }

      vim.keymap.set(modes, '<M-h>', '<cmd>silent! !tmux select-pane -L<CR>', { buffer = true })
      vim.keymap.set(modes, '<M-j>', '<cmd>silent! !tmux select-pane -D<CR>', { buffer = true })
      vim.keymap.set(modes, '<M-k>', '<cmd>silent! !tmux select-pane -U<CR>', { buffer = true })
      vim.keymap.set(modes, '<M-l>', '<cmd>silent! !tmux select-pane -R<CR>', { buffer = true })
    end,
  })
end

return M
