return {
  -- swap file spam
  {
    filter = {
      event = 'msg_show',
      find = 'Found a swap file by the name "~/.local/state/nvim/swap',
    },
    opts = { skip = true },
  },
  {
    filter = {
      warning = true,
      find = '^W325: Ignoring swapfile from Nvim process %d+$',
    },
    opts = { skip = true },
  },
  { -- harpoon swap file error
    filter = {
      event = 'msg_show',
      find = 'E5108: Error executing lua: Vim:E325: ATTENTION',
    },
    opts = { skip = true },
  },
  -- written file
  {
    filter = {
      event = 'msg_show',
      find = 'written$',
    },
    opts = { skip = true },
  },
  -- undos
  {
    filter = {
      event = 'msg_show',
      find = '(%d+)%s.-;%s.-%s#(%d+)%s%s',
    },
    opts = { skip = true },
  },
  -- no previous buffer
  {
    filter = {
      event = 'msg_show',
      find = 'E23: No alternate file',
    },
    opts = { skip = true },
  },
  -- change list
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
  -- using "*" or "#" on visual mode
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
  -- warning when avancing steps outside of main buffer on dap
  {
    filter = {
      warning = true,
      find = 'Adapter reported a frame in .* but: Cursor position outside buffer%. Ensure executable is up2date and if using a source mapping ensure it is correct',
    },
    opts = { skip = true },
  },
  -- closing dap config selection
  {
    filter = {
      find = 'No configuration selected',
    },
    opts = { skip = true },
  },
  -- telescope
  {
    filter = { -- gr on single instances
      find = '%[telescope%.builtin%.lsp%_references%]%: No LSP References found',
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
  -- neotree deprection warnings
  {
    event = 'notify',
    filter = {
      find = 'vim%.lsp%.get_active_clients%(%) is deprecated%. Run ":checkhealth vim%.deprecated" for more',
    },
    opts = { skip = true },
  },
  -----
  -- when closing diffview window too soon
  {
    event = 'notify',
    filter = {
      find = 'diffview.*The coroutine failed with this message',
    },
    opts = { skip = true },
  },
  {
    event = 'notify',
    filter = {
      find = "diffview.*bad argument #1 to 'ipairs'",
    },
    opts = { skip = true },
  },
  {
    event = 'notify',
    filter = {
      find = 'Failed to create diff buffer',
    },
    opts = { skip = true },
  },
  { -- when closing sidekick window too soon
    event = 'notify',
    filter = {
      find = "Invalid 'window'.*in function 'nvim_win_get_cursor'.*sidekick.nvim",
    },
    opts = { skip = true },
  },
}
