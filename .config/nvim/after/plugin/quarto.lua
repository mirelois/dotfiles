require('quarto').setup {
    debug = false,
    closePreviewOnExit = false,
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

vim.keymap.set("n", "<leader>qA", ":QuartoSendAll<CR>")
vim.keymap.set("n", "<leader>qa", ":QuartoSendAbove<CR>")
vim.keymap.set("n", "<leader>qb", ":QuartoSendBelow<CR>")

vim.keymap.set("n", "<leader>qho", ":MoltenHideOutput<CR>",
    { silent = true, desc = "hide output" })
vim.keymap.set("n", "<leader>qe", ":noautocmd MoltenEnterOutput<CR>",
    { silent = true, desc = "show/enter output" })

vim.api.nvim_create_user_command("QuartoToJupyter", function()
    local cmd = "quarto convert " .. vim.api.nvim_buf_get_name(0)
    local out = vim.fn.system(cmd)
    print(out)
end, {})

