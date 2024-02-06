require('mini.move').setup({
    mappings = {
        left  = 'H',
        right = 'L',
        down  = 'J',
        up    = 'K',
    }
})

--require('mini.pairs').setup({})

--require('mini.jump').setup({})

require('mini.splitjoin').setup({
    mappings = {
        toggle = 'gS',
        split = '',
        join = '',
  }
})

--require('mini.surround').setup({
--    respect_selection_type = true,
--    n_lines = 10000,
--})

--require('mini.ai').setup({
--    n_lines = 10000
--})

