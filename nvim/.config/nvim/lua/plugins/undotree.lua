return {
  'mbbill/undotree',
  keys = {
    { '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Undotree' },
  },
  config = function()
    require('utils.ft').clear_c_hjkl('undotree', { bind_c_j = true })

    vim.g.undotree_WindowLayout = 3
    vim.g.undotree_SplitWidth = 44
    vim.g.undotree_DiffAutoOpen = 0 -- 0, 1
    vim.g.undotree_SetFocusWhenToggle = 0
    vim.g.undotree_ShortIndicators = 0 -- s, h, m, etc
    vim.g.undotree_HighlightChangedText = 0
    vim.g.undotree_HelpLine = 0

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'undotree',
      callback = function()
        vim.keymap.set('n', 'g-', '<plug>UndotreePreviousState', { buffer = true })
        vim.keymap.set('n', 'g+', '<plug>UndotreeNextState', { buffer = true })

        vim.keymap.set('n', require('utils.bindings').timeline_undo, '<plug>UndotreePreviousState', { buffer = true })
        vim.keymap.set('n', require('utils.bindings').timeline_redo, '<plug>UndotreeNextState', { buffer = true })

        vim.keymap.set('n', '<Esc>', function()
          require('utils.close_win')('UndotreeHide')
        end, { buffer = true })
      end,
    })
  end,
}
