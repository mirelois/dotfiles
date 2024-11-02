return {
    {
        'AckslD/nvim-trevJ.lua',
        opts = {
            containers = {
                java = {
                    formal_parameters = { final_separator = false, final_end_line = false },
                    argument_list = { final_separator = false, final_end_line = false },
                    catch_type = { final_separator = false, final_end_line = false },
                    array_initializer = { final_separator = false, final_end_line = false },
                },
            },

        },
        keys = {
            { '<leader>j', function()
                require('trevj').format_at_cursor()
            end }

        }
    },
    { 'tpope/vim-abolish' },
    { 'chentoast/marks.nvim' },
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },

    {
        "mbbill/undotree",
        init = function()
            vim.g.undotree_SetFocusWhenToggle = true
            vim.g.undotree_WindowLayout = 2
        end,
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle }
        }

    }



}
