-- format once with 'null-ls', fallbacking to the lsp client
return function()
  local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  if #clients <= 0 then
    return
  end

  local null_ls_available = false
  local found_tailwind = false

  for _, client in ipairs(clients) do
    if client.name == 'null-ls' and client.supports_method('textDocument/formatting') then
      null_ls_available = true
    end

    if client.name == 'tailwindcss' then
      found_tailwind = true
    end
  end

  local formatted = false
  vim.lsp.buf.format({
    filter = function(client)
      if formatted then
        return
      end

      if null_ls_available then
        if client.name == 'null-ls' then
          formatted = true
          return true
        end
        return
      end

      if client.supports_method('textDocument/formatting') then
        formatted = true
        return true
      end
    end,
  })

  return { found_tailwind = found_tailwind }
end
