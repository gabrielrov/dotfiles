return function()
  local storage = require('utils.storage')
  local default_url = storage.get_field('dap_browser_port') or ''

  local co = coroutine.running()
  return coroutine.create(function()
    vim.ui.input({ prompt = 'Launch on port: ', default = default_url }, function(port)
      if port == nil or port == '' then
        return
      end

      storage.set_field('dap_browser_port', port)
      coroutine.resume(co, 'http://localhost:' .. port)
    end)
  end)
end
