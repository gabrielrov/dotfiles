local toggle_binding = '<leader>o'

return {
  'leath-dub/snipe.nvim',
  keys = {
    {
      toggle_binding,
      function()
        require('snipe').open_buffer_menu()
        vim.cmd('norm! gg0')
      end,
      desc = 'Show oldfiles for buffers',
    },
  },
  config = function()
    local dictionary = '-qwertyuiop'

    require('utils.ft').clear_c_hjkl('snipe-menu', { bind_c_j = true })
    require('utils.ft').bind_close_win('snipe-menu', 'close')

    require('snipe').setup({
      hints = {
        dictionary = dictionary,
      },
      ui = {
        position = 'center',
        max_height = #dictionary,
      },
      navigate = {
        close_buffer = 'D',
        next_page = 'J',
        prev_page = 'K',
        cancel_snipe = { toggle_binding },
      },
      sort = 'last', -- last / default
    })
  end,
}
