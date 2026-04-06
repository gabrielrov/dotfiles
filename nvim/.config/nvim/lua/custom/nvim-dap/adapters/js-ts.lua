local dap = require('dap')

for _, adapterType in ipairs({ 'node', 'chrome', 'msedge' }) do
  local pwaType = 'pwa-' .. adapterType

  dap.adapters[pwaType] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = {
        vim.fs.normalize(vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'),
        '${port}',
      },
    },
  }

  -- handle local configurations which specify type whithout 'pwa-' as prefix
  dap.adapters[adapterType] = function(cb, config)
    local nativeAdapter = dap.adapters[pwaType]

    config.type = pwaType

    if type(nativeAdapter) == 'function' then
      nativeAdapter(cb, config)
    else
      cb(nativeAdapter)
    end
  end
end

local pick_dap_port = require('custom.nvim-dap.pick_dap_port')
local pick_browser_url = require('custom.nvim-dap.pick_browser_url')
local get_executable = require('custom.nvim-dap.get_executable')

dap.configurations['javascript'] = {
  {
    name = 'Attach to process',
    request = 'attach',
    type = 'pwa-node',
    port = function()
      return pick_dap_port('9229')
    end,
    cwd = '${workspaceFolder}',
    restart = true, -- restart when saving while active instead of disconnecting
  },
  {
    name = 'Run with node',
    request = 'launch',
    type = 'pwa-node',
    program = '${file}', -- initializes on current file
    runtimeArgs = { '--inspect', '--watch' },
    cwd = '${workspaceFolder}',
  },
  {
    name = 'Launch Chrome',
    request = 'launch',
    type = 'pwa-chrome',
    url = pick_browser_url,
    webRoot = '${workspaceFolder}',
    sourceMaps = true,
  },
}

dap.configurations['typescript'] = {
  {
    name = 'Attach to process',
    request = 'attach',
    type = 'pwa-node',
    port = function()
      return pick_dap_port('9229')
    end,
    cwd = '${workspaceFolder}',
    restart = true,
  },
  {
    name = 'Run with tsx',
    request = 'launch',
    type = 'pwa-node',
    program = '${file}',
    runtimeExecutable = function()
      return get_executable({ vim.fn.getcwd() .. '/node_modules/.bin/tsx', 'tsx' })
    end,
    runtimeArgs = { '--inspect', '--watch' },
    skipFiles = {
      '<node_internals>/**',
      '${workspaceFolder}/node_modules/**',
    },
  },
  {
    name = 'Launch Chrome',
    request = 'launch',
    type = 'pwa-chrome',
    url = pick_browser_url,
    webRoot = '${workspaceFolder}',
    sourceMaps = true,
  },
}

for _, language in ipairs({ 'javascriptreact', 'typescriptreact' }) do
  dap.configurations[language] = {
    {
      name = 'Launch Chrome',
      request = 'launch',
      type = 'pwa-chrome',
      url = pick_browser_url,
      webRoot = '${workspaceFolder}',
      sourceMaps = true,
    },
  }
end
