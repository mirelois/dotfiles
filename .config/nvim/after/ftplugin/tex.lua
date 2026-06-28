vim.opt.spell = true
vim.opt.wrap = true
vim.opt_local.spelllang = {"en_us", "pt"}

vim.api.nvim_create_user_command("LSPTexlabBuildOnSave", function()
    vim.api.nvim_create_autocmd("BufWritePost", {

        group = vim.api.nvim_create_augroup("LatexCompile", { clear = true }),
        pattern = "*",
        callback = function()
            vim.api.nvim_command([[LspTexlabBuild]])
        end,
    })
end, {})

vim.keymap.set("n", "<S-CR>", function() vim.cmd([[LspTexlabForward]]) end)
vim.keymap.set("n", "<C-CR>", function() vim.cmd([[LspTexlabForward]]) end)


--
-- vim.keymap.set("n", "<leader><leader>t", function ()
--     local client = assert(vim.lsp.get_clients()[1])
--     print(vim.inspect(client:request('textDocument/build')))
-- end)


