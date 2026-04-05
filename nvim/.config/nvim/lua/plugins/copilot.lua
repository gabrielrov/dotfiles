return {
  enabled = false,
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    local auto_trigger = true

    require('copilot').setup({
      suggestion = {
        trigger_on_accept = false,
        auto_trigger = auto_trigger,
        keymap = {
          accept = '<Tab>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
    })

    vim.keymap.set('n', '<leader><Tab>', function()
      require('copilot.suggestion').toggle_auto_trigger()
      auto_trigger = not auto_trigger
      vim.notify('Copilot ' .. (auto_trigger and 'enabled' or 'disabled'))
    end)
  end,
}
