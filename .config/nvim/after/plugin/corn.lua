-- ensure virtual_text diags are disabled
vim.diagnostic.config { virtual_text = false }

-- toggle virtual_text diags when corn is toggled
require 'corn'.setup {
    item_preprocess_func = function(item)
        return item
    end,
}

require('corn').toggle("on")
