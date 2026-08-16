-- highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- scroll past end of file with scrolloff ('scrolloffpad' was introduced on v0.13.0, but not feeling like updating)
-- vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufEnter' }, {
--   callback = function()
--     local win_h = vim.api.nvim_win_get_height(0)
--     local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
--     local dist = vim.fn.line('$') - vim.fn.line('.')
--     local rem = vim.fn.line('w$') - vim.fn.line('w0') + 1
--     if dist < off and win_h - rem + dist < off then
--       local view = vim.fn.winsaveview()
--       view.topline = view.topline + off - (win_h - rem + dist)
--       vim.fn.winrestview(view)
--     end
--   end,
-- })

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  callback = function()
    local current_tab = vim.fn.tabpagenr()

    vim.cmd('tabdo wincmd =') -- resize windows of all tabs
    vim.cmd('tabnext ' .. current_tab) -- restores the focus to the original tab
  end,
})

-- preserve last position when opening buffers
vim.api.nvim_create_autocmd('FileType', {
  callback = function(event)
    local exclude = {
      gitcommit = true,
    }

    local buf = event.buf
    local ft = vim.bo[buf].filetype

    -- ignore excluded filetypes or last buffer
    if exclude[ft] or vim.b[buf].last_buf_edited then
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
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    if format_on_save then
      local format = require('utils.format')
      format()
    end
  end,
})

-- writes cwd to a file when leaving (can be used to cd to it upon quitting)
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    local file = vim.env.NVIM_CWD_FILE
    if file then
      vim.fn.writefile({ vim.fn.getcwd() }, file)
    end
  end,
})

vim.api.nvim_create_user_command('ToggleFormat', function()
  format_on_save = not format_on_save
  vim.notify('FormatOnSave ' .. (format_on_save and 'enabled' or 'disabled'))
end, {})

vim.api.nvim_create_user_command('ToggleDiagnostics', function()
  diagnostics_enabled = not diagnostics_enabled

  vim.diagnostic.enable(diagnostics_enabled)

  if diagnostics_enabled then
    vim.notify('DiagnosticHighlights enabled')
  else
    vim.notify('DiagnosticHighlights disabled')
  end
end, {})

vim.api.nvim_create_user_command('ClearSwaps', function()
  local swapdir = vim.fn.expand(vim.opt.directory:get()[1])

  local deleted = 0
  for name, type in vim.fs.dir(swapdir) do
    if type == 'file' then
      if vim.fn.delete(vim.fs.joinpath(swapdir, name)) == 0 then
        deleted = deleted + 1
      end
    end
  end

  vim.notify(('Deleted %d swap file(s)'):format(deleted))
end, {})
