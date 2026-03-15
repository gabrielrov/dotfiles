return {
  -- Warning when editing a file opened on another instance
  {
    filter = {
      warning = true,
      find = '^W325: Ignoring swapfile from Nvim process %d+$',
    },
    opts = { skip = true },
  },
  {
    filter = {
      event = 'msg_show',
      find = 'written$',
    },
    opts = { skip = true },
  },
  -- Undos
  {
    filter = {
      event = 'msg_show',
      find = '(%d+)%s.-;%s.-%s#(%d+)%s%s',
    },
    opts = { skip = true },
  },
  -- No previous buffer
  {
    filter = {
      event = 'msg_show',
      find = 'E23: No alternate file',
    },
    opts = { skip = true },
  },
  -- Change list
  {
    filter = {
      event = 'msg_show',
      find = 'E662: At start of changelist',
    },
    opts = { skip = true },
  },
  {
    filter = {
      event = 'msg_show',
      find = 'E663: At end of changelist',
    },
    opts = { skip = true },
  },
  {
    filter = {
      event = 'msg_show',
      find = 'E19: Mark has invalid line number',
    },
    opts = { skip = true },
  },
  -- Using "*" or "#" on visual mode
  {
    filter = {
      event = 'msg_show',
      find = '^%s*W?%s?%[%d+/%d+%]$',
    },
    opts = { skip = true },
  },
  -- cnext/cprev throws errors when reaching last item, annoying call stack with repeatable movements
  {
    filter = {
      event = 'msg_show',
      find = 'E553: No more items',
    },
    opts = { skip = true },
  },
  -- Warning when avancing steps outside of main buffer on dap
  {
    filter = {
      warning = true,
      find = 'Adapter reported a frame in .* but: Cursor position outside buffer%. Ensure executable is up2date and if using a source mapping ensure it is correct',
    },
    opts = { skip = true },
  },
  -- Closing dap config selection
  {
    filter = {
      find = 'No configuration selected',
    },
    opts = { skip = true },
  },
  -- NOTE: telescope deprection warnings
  {
    filter = {
      warning = true,
      find = 'position_encoding param is required in vim%.lsp%.util%.make_position_params%. Defaulting to position encoding of the first client%.',
    },
    opts = { skip = true },
  },
  {
    event = 'notify',
    filter = {
      find = 'vim%.lsp%.util%.jump_to_location is deprecated',
    },
    opts = { skip = true },
  },
  {
    event = 'notify',
    filter = {
      find = 'symbols_to_items must be called with valid position encoding',
    },
    opts = { skip = true },
  },
  {
    event = 'notify',
    filter = {
      find = 'Error handling LSP Incoming Calls: Unhandled method callHierarchy/incomingCalls',
    },
    opts = { skip = true },
  },
  {
    event = 'notify',
    filter = {
      find = 'Error handling LSP Outgoing Calls: Unhandled method callHierarchy/outgoingCalls',
    },
    opts = { skip = true },
  },
  -----
  {
    event = 'notify',
    filter = {
      find = '%[LSP%] Format request failed, no matching language servers%.',
    },
    opts = { skip = true },
  },
  -- NOTE: neotree deprection warnings
  {
    event = 'notify',
    filter = {
      find = 'vim%.lsp%.get_active_clients%(%) is deprecated%. Run ":checkhealth vim%.deprecated" for more',
    },
    opts = { skip = true },
  },
  -----
  { -- When closing sidekick window too early
    event = 'notify',
    filter = {
      find = "Invalid 'window'.*in function 'nvim_win_get_cursor'.*sidekick.nvim",
    },
    opts = { skip = true },
  },
}
