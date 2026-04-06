-- defaults to interpret trailing '  ' as \t (tab)
return function(str, format, obj)
  local ext_fmt = require('luasnip.extras.fmt').fmt
  local opts = vim.tbl_deep_extend('force', { indent_string = '  ' }, obj or {})

  return ext_fmt(str, format, opts)
end
