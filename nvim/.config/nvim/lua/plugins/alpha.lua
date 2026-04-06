return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  config = function()
    local startify = require('alpha.themes.startify')

    startify.file_icons.provider = 'devicons'

    startify.section.header.val = {
      [[                                   __                ]],
      [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    }

    require('alpha').setup(startify.config)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'alpha',
      once = true,
      callback = function()
        -- automatically opens most recent file on dir
        if vim.fn.argc() ~= 0 then
          return
        end
        pcall(function()
          startify.mru(0, vim.fn.getcwd()).val[1].on_press()
        end)
      end,
    })
  end,
}
