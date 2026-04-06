-- only shows emmet suggestions on root or inside of elements
return function(item)
  if item.client_name ~= 'emmet_ls' then
    return true
  end

  local success, node = pcall(vim.treesitter.get_node)
  if not (success and node) then
    return true
  end

  if vim.tbl_contains({ 'element', 'document', 'ERROR' }, node:type()) then
    return true
  end

  return false
end
