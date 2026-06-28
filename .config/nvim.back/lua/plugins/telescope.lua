return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
    config = function()
        require("telescope").load_extension("ui-select")
    end,
    keys = function()
        local builtin = require('telescope.builtin')
        local utils = require('telescope.utils')

        local project_files = function()
            local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
            if ret == 0 then
                builtin.git_files()
            else
                builtin.find_files()
            end
        end

        return {
            { '<leader><leader>/', "<CMD>Telescope lsp_workspace_symbols<CR>" },
            { '<leader>/',         builtin.treesitter },
            { '<leader>pf',        builtin.find_files },
            { '<C-p>',             function() project_files() end },
            { '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end }

        }
    end
}
