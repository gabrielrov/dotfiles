return function(default)
  default = default or ''

  local co = coroutine.running()
  return coroutine.create(function()
    vim.ui.input({ prompt = 'Attach on port: ', default = default }, function(port)
      if port == nil or port == '' then
        return
      end

      coroutine.resume(co, port)
    end)
  end)
end
