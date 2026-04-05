local emmet_on_element = require('custom.blink.completions.utils.emmet_on_element')

return {
  filter = {
    lsp = function(_, item)
      return emmet_on_element(item)
    end,
  },
}
