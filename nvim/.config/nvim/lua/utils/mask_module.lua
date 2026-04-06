--- @param module string
--- @param setup function
-- prevent module from being required by plugin, usefull for lazy loading
return function(module, setup)
  -- save the original module references
  local orig_loaded = package.loaded[module]
  local orig_preload = package.preload[module]

  -- mask module
  package.loaded[module] = nil
  package.preload[module] = function()
    error('module is disabled during setup')
  end

  -- call the plugin's setup (it will think module is not installed)
  setup()

  -- restore module
  package.loaded['telescope'] = orig_loaded
  package.preload['telescope'] = orig_preload
end
