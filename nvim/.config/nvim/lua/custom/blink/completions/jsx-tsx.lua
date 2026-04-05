return {
  filter = {
    lsp = function(_, item)
      if item.client_name == 'emmet_ls' then
        local success, node = pcall(vim.treesitter.get_node)
        if success and node and node:type() ~= 'jsx_text' then
          return false
        end
      end

      return true
    end,
    snippets = function()
      local success, node = pcall(vim.treesitter.get_node)
      if not success and node then
        return true
      end

      if
        node:type() == 'jsx_opening_element'
        or node:type() == 'jsx_closing_element'
        or node:type() == 'jsx_self_closing_element'
        or node:type() == 'jsx_attribute'
        or node:type() == 'jsx_element'
      then
        return false
      end

      if not node:parent() then
        return true
      end

      if
        (node:parent():type() == 'jsx_opening_element' and node:type() == 'identifier')
        or (node:parent():type() == 'jsx_self_closing_element')
        or (node:parent():type() == 'jsx_attribute' and node:type() == 'identifier')
        or (node:parent():type() == 'jsx_attribute' and node:type() == 'property_identifier')
      then
        return false
      end

      return true
    end,
  },
}
