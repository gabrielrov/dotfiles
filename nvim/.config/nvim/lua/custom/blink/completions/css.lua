return {
  filter = {
    lsp = function(_, item)
      local is_emmet = item.client_name == 'emmet_ls'
      if not is_emmet then
        return true
      end

      local success, node = pcall(vim.treesitter.get_node)
      if not (success and node) then
        return true
      end

      -- Shows emmet completion only on empty part of block
      local current = node
      while current:parent() do
        if current:type() == 'declaration' then
          return false
        end
        if current:type() == 'block' then
          return true
        end
        current = current:parent()
      end

      return false
    end,
  },
  sorts = {
    function(a, b)
      local a_emmet = a.client_name == 'emmet_ls'
      local b_emmet = b.client_name == 'emmet_ls'

      -- Deprioritize emmet_ls compared to other sources
      if a_emmet == b_emmet then
        return
      end

      return b_emmet
    end,
    'score',
    'sort_text',
  },
}
