vim.opt.signcolumn = 'yes'

return {
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
                -- { name = 'otter' },
                { name = 'calc' },
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
        "VonHeikemen/lsp-zero.nvim",
        config = function()
            local lsp_zero = require('lsp-zero')

            vim.diagnostic.config({
                underline = false
            })


            lsp_zero.set_sign_icons({
                error = '>>',
                warn  = '>>',
                hint  = '>>',
                info  = '>>'
            })


            lsp_zero.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end


                if client.name == "eslint" then
                    vim.cmd.LspStop('eslint')
                    return
                end


                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts) done by conform
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[g", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "]g", vim.diagnostic.goto_prev, opts)
            end)
        end
    },
    {
        'williamboman/mason.nvim',
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "rust_analyzer", "bashls", "pyright" },
        },
        -- see :h mason-lspconfig.setup_handlers()
        -- config = function()
        --     require("mason-lspconfig").setup_handlers {
        --         -- The first entry (without a key) will be the default handler
        --         -- and will be called for each installed server that doesn't have
        --         -- a dedicated handler.
        --         function(server_name) -- default handler (optional)
        --             require("lspconfig")[server_name].setup {}
        --         end,
        --         -- Next, you can provide a dedicated handler for specific servers.
        --         -- For example, a handler override for the `rust_analyzer`:
        --         ["lua_ls"] = function()
        --             require("rust-tools").setup {}
        --         end
        --     }
        -- end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            local lspconfig_defaults = require('lspconfig').util.default_config

            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )
            require 'lspconfig'.pyright.setup {
                root_dir = function() return vim.fn.getcwd() end
            }

            require('lspconfig').lua_ls.setup({

                on_init = function(client)
                    require("lsp-zero").nvim_lua_settings(client, {})
                end,

                settings = {
                    Lua = {
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                    },
                },

            })
        end
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
                        UNCRUSTIFY_CONFIG = "/home/utilizador/.config/uncrustify/custom.cfg",
                    }

                },

                astyle = {
                    command = "/usr/bin/astyle",
                    args = {
                        "--style=google",
                        "--align-pointer=type",
                        "--align-reference=type",
                        -- "--keep-one-line-statements",
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
