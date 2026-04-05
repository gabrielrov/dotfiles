local M = {}
local completions = require('custom.blink.completion_init')

---@param source string
M.filter = function(source)
  return function(ctx, items)
    local ft_config = completions.config and completions.config[vim.bo.filetype]
    local filter = ft_config and ft_config.filter and ft_config.filter[source]

    if filter then
      return vim.tbl_filter(function(item)
        return filter(ctx, item)
      end, items)
    end

    return items
  end
end

---@param default table
M.sorts = function(default)
  -- Obs: Sorts that include custom functions use the slower lua implementation for sorting instead of rust
  return function()
    local ft_config = completions.config and completions.config[vim.bo.filetype]
    local sorts = ft_config and ft_config.sorts

    if sorts then
      return sorts
    end

    return default
  end
end

return M
