vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.wrap = true

vim.api.nvim_create_user_command("TexlabBuildOnSave", function()
    vim.api.nvim_create_autocmd("BufWritePost", {

        group = vim.api.nvim_create_augroup("LatexCompile", { clear = true }),
        pattern = "*",
        callback = function()
            vim.api.nvim_command([[TexlabBuild]])
        end,
    })
end, {})

