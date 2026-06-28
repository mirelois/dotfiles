vim.opt.signcolumn = 'yes'

return {
    {
        'SleepySwords/change-function.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-treesitter/nvim-treesitter-textobjects', -- Not required, however provides fallback `textobjects.scm`
        }
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-calc",
            "f3fora/cmp-spell",
        },

        opts = function(Spec, opts)
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            opts.mapping = {
                ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<c-k>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = nil,
                ['<Right>'] = nil,
                ['<Left>'] = nil,
                ['<Up>'] = nil,
                ['<Down>'] = nil,
            }
            opts.sources = {
                { name = 'calc' },
                { name = 'otter' },
                { name = "spell" },
                { name = "luasnip" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "path" },
                { name = "buffer" },
            }
            opts.snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            }
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = {},
    },
    {
        "RaafatTurki/corn.nvim",
        event = "BufWinEnter",
        init = function() vim.diagnostic.config { virtual_text = false } end,
        opts = {
            item_preprocess_func = function(item)
                return item
            end,

        }
    },
    {
        "stevearc/conform.nvim",
        event = "BufWinEnter",
        keys = {
            { "<leader>f", function()
                require('conform').format({
                    lsp_fallback = true
                })
            end }
        },
        opts = {
            will_fallback_lsp = true,
            formatters_by_ft = {
                -- lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                -- python = { "isort" },
                -- Use a sub-list to run only the first available formatter
                -- javascript = { { "prettierd", "prettier" } },

                java = { 'uncrustify' },

                cpp = { 'uncrustify' }
            },
            formatters = {

                uncrustify = {
                    command = '/home/utilizador/uncrustify/build/uncrustify',
                    env = {
                        UNCRUSTIFY_CONFIG = "/home/mirelois/.config/uncrustify/custom.cfg",
                    }

                },

                astyle = {
                    command = "/usr/bin/astyle",
                    args = {
                        "--style=google",
                        "--align-pointer=type",
                        "--align-reference=type",
                        "--keep-one-line-statements",
                        "--max-code-length=200",
                        "--break-blocks",
                        "--pad-comma",
                        -- "--squeeze-lines=3",
                        "--max-continuation-indent=120",
                    }

                }

            }

        }
    },

}
