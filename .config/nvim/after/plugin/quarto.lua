require('quarto').setup {
    debug = false,
    closePreviewOnExit = true,
    lspFeatures = {
        enabled = true,
        chunks = "curly",
        languages = { "r", "python", "julia", "bash", "html" },
        diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
        },
        completion = {
            enabled = true,
        },
    },
    codeRunner = {
        enabled = true,
        default_method = 'slime', -- 'molten' or 'slime'
        ft_runners = {},    -- filetype to runner, ie. `{ python = "molten" }`.
        -- Takes precedence over `default_method`
        never_run = { "yaml" }, -- filetypes which are never sent to a code runner
    },
}

vim.keymap.set("n", "<c-cr>", ":QuartoSend<CR>")
vim.keymap.set("n", "<s-cr>", ":QuartoSend<CR>")
