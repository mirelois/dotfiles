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


vim.keymap.set('n', '<leader>/', builtin.treesitter, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', function() project_files() end, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- This is your opts table
require("telescope").setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
                --   [kind] = {
                    --     make_indexed = function(items) -> indexed_items, width,
                        --     make_displayer = function(widths) -> displayer
                            --     make_display = function(displayer) -> function(e)
                                --     make_ordinal = function(e) -> string
                                    --   },
                                    --   -- for example to disable the custom builtin "codeactions" display
                                    --      do the following
                                    --   codeactions = false,
                                    -- }
                                }
                            }
                        }
                        -- To get ui-select loaded and working with telescope, you need to call
                        -- load_extension, somewhere after setup function:
                        require("telescope").load_extension("ui-select")

