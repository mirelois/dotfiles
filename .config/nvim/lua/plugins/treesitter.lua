return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = "main",
        config = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = '*',
                callback = function()
                    local _ = pcall(vim.treesitter.start)
                end,
            })

            --auto install
            vim.api.nvim_create_autocmd('FileType', {
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match)
                    local available_langs = require('nvim-treesitter').get_available()
                    local is_available = vim.tbl_contains(available_langs, lang)
                    if is_available then
                        local installed_langs = require('nvim-treesitter').get_installed()
                        local installed = vim.tbl_contains(installed_langs, lang)
                        if not installed then
                            require('nvim-treesitter').install(lang):wait()
                        end
                        vim.treesitter.start()
                        require('nvim-treesitter').indentexpr()
                    end
                end,
            })

            require 'nvim-treesitter'.setup {
                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = true,
                },
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["ii"] = "@conditional.inner",
                            ["ai"] = "@conditional.outer",
                            ["il"] = "@loop.inner",
                            ["al"] = "@loop.outer",
                            ["in"] = "@number.inner",
                            ["an"] = "@number.outer",
                            ["ib"] = "@cell.inner",
                            ["ab"] = "@cell.outer",
                            -- You can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                            ["is"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        },
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V',  -- linewise
                            ['@class.outer'] = 'V',     -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true of false
                        include_surrounding_whitespace = false,
                    },

                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a["] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>a]"] = "@parameter.inner",
                        },
                    },

                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["<leader>gf"] = "@function.outer",
                            ["<leader>gc"] = { query = "@class.outer", desc = "Next class start" },
                            --
                            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                            ["<leader>gl"] = "@loop.*",
                            ["<leader>gi"] = "@conditional.*",
                            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                            --
                            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                            -- ["<leader>gs"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                            -- ["<leader>gz"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                        },
                        goto_previous_start = {
                            ["<leader>gF"] = "@function.outer",
                            ["<leader>gC"] = "@class.outer",
                        },
                    },
                }
            }
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
            "nvim-treesitter/nvim-treesitter-textobjects",
            -- 'nvim-treesitter/playground'
        }
    },
}
