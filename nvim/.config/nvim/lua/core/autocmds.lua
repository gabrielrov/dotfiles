-- highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- configure automatic comment insertion
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove({ 'c', 'o' }) -- 'c', 'r', 'o'
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  callback = function()
    local current_tab = vim.fn.tabpagenr()

    vim.cmd('tabdo wincmd =') -- resize windows of all tabs
    vim.cmd('tabnext ' .. current_tab) -- restores the focus to the original tab
  end,
})

-- preserve last position when opening buffers
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(event)
    local exclude = {
      'gitcommit',
    }
    local buf = event.buf

    -- ignore excluded filetypes or last buffer
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_buf_edited then
      return
    end

    -- avoids attempting to restore position again
    vim.b[buf].last_buf_edited = true

    local mark = vim.api.nvim_buf_get_mark(buf, '"') -- line and column from when buffer was closed
    local lcount = vim.api.nvim_buf_line_count(buf)

    -- only proceed if line still exists
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- when saving a file, if it's inside not yet existent folders, creates them
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  callback = function(event)
    -- acts normally for protcols like http://
    if event.match:match('^%w%w+:[\\/][\\/]') then
      return
    end

    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

local diagnostics_enabled = true

-- diagnostic toggle command
vim.api.nvim_create_user_command('ToggleDiagnostics', function()
  diagnostics_enabled = not diagnostics_enabled

  vim.diagnostic.enable(diagnostics_enabled)

  if diagnostics_enabled then
    vim.notify('DiagnosticHighlights enabled')
  else
    vim.notify('DiagnosticHighlights disabled')
  end
end, {})

-- disable diagnostics on insert mode
vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    if diagnostics_enabled then
      vim.diagnostic.enable(false)
    end
  end,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    if diagnostics_enabled then
      vim.diagnostic.enable(true)
    end
  end,
})

local format_on_save = true

-- format on save toggle command
vim.api.nvim_create_user_command('ToggleFormat', function()
  format_on_save = not format_on_save
  vim.notify('FormatOnSave ' .. (format_on_save and 'enabled' or 'disabled'))
end, {})

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    if format_on_save then
      local format = require('utils.format')
      format()
    end
  end,
})
