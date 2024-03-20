local attach_to_buffer = function(pattern, command)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("AutoRun", { clear = true }),
        pattern = pattern,
        callback = function()
            vim.cmd { cmd = 'FlowRunCustomCmd', args = { command } }
        end,
    })
end

vim.api.nvim_create_user_command("AutoRun", function()
    local pattern = vim.fn.input "Pattern: "
    local command = vim.fn.input "Command: "
    attach_to_buffer(pattern, command)
end, {})



