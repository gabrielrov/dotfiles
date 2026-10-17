-- This is a patched implementation not available in blink v1 (wich requires nvim 0.12)
-- As it stands, blink.show will not work properly when passing custom providers
return function(opts)
  opts = opts or {}

  if require('blink.cmp.completion.windows.menu').win:is_open() then
    return false
  end

  require('blink.cmp.completion.windows.menu').force_auto_show()

  require('blink.cmp.completion.trigger').show({
    force = true,
    providers = opts and opts.providers,
    trigger_kind = 'manual',
    initial_selected_item_idx = opts.initial_selected_item_idx,
  })
  return true
end
