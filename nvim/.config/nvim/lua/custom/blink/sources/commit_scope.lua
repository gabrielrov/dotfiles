-- adapted from: https://github.com/disrupted/blink-cmp-conventional-commits

local commit_scope = {}

local function make_scope_item(scope)
  return {
    label = scope,
    insertText = scope,
    kind = require('blink.cmp.types').CompletionItemKind.Value,
  }
end

local function discover_scopes(count, callback)
  vim.system(
    { 'git', 'log', '--no-merges', '--oneline', '-' .. count },
    { text = true },
    vim.schedule_wrap(function(result)
      if result.code ~= 0 then
        callback({})
        return
      end

      local seen = {}
      local scopes = {}
      for line in result.stdout:gmatch('[^\n]+') do
        local scope = line:match('^%x+ %w+%((.-)%)')
        if scope then
          scope = scope:match('^%s*(.-)%s*$')
          if scope ~= '' and not seen[scope] then
            seen[scope] = true
            table.insert(scopes, scope)
          end
        end
      end
      callback(scopes)
    end)
  )
end

function commit_scope.new(opts)
  opts = opts or {}
  return setmetatable(opts, { __index = commit_scope })
end

function commit_scope:get_completions(_, callback)
  discover_scopes(self.git_log_count or 200, function(scopes)
    local scope_items = {}

    for _, scope in ipairs(scopes) do
      table.insert(scope_items, make_scope_item(scope))
    end

    if #scope_items < 1 then
      callback({ items = {} })
    else
      callback({
        is_incomplete_forward = false,
        is_incomplete_backward = false,
        items = vim.deepcopy(scope_items),
      })
    end
  end)
end

function commit_scope.enabled()
  return vim.bo.filetype == 'lazygit' and vim.fn.getcmdtype() == '@'
end

return commit_scope
