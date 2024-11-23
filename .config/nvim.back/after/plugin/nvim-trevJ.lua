require('trevj').setup({
    containers = {
        java = {
            formal_parameters = { final_separator = false, final_end_line = false },
            argument_list = { final_separator = false, final_end_line = false },
            catch_type = { final_separator = false, final_end_line = false },
            array_initializer = { final_separator = false, final_end_line = false },
        },
    },
})

vim.keymap.set('n', '<leader>j', function()
    require('trevj').format_at_cursor()
end)
