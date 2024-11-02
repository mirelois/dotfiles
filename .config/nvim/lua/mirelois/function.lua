vim.api.nvim_create_user_command("W", function()
    vim.cmd('w')
end, {})



-- Open binary files
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function()
    -- local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
    local filename = vim.api.nvim_buf_get_name(0)
    vim.system({'sioyek', filename}, {detach = true})
    vim.cmd([[:Oil]])
  end
})
