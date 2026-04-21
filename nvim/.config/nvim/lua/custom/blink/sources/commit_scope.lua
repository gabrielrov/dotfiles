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

      local typed = {}

      local cmd_words = vim.fn.getcmdline():gmatch('%S+')
      for full_word in cmd_words do
        typed[full_word] = true

        if full_word:find('/') then
          for sub_word in full_word:gmatch('[^/]+') do
            typed[sub_word] = true
          end
        end
      end

      local items = {}
      local seen = {}

      for line in result.stdout:gmatch('[^\n]+') do
        local full_scope = line:match('^%x+ %w+%((.-)%)')
        full_scope = full_scope and vim.trim(full_scope)

        if full_scope and full_scope ~= '' and not seen[full_scope] then
          seen[full_scope] = true

          local include_full_scope = true
          for sub_scope in full_scope:gmatch('[^/]+') do
            if typed[sub_scope] then
              include_full_scope = false
            end

            if not seen[sub_scope] and not typed[sub_scope] then
              seen[sub_scope] = true
              table.insert(items, sub_scope)
            end
          end

          if include_full_scope then
            table.insert(items, full_scope)
          end
        end
      end
      callback(items)
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
