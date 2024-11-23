require("conform").setup({
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
})

vim.keymap.set("n", "<leader>f", function()
    require('conform').format({
        lsp_fallback = true
    })
end
) --does formating
