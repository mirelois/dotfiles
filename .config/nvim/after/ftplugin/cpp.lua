
vim.keymap.set("n", "<C-w>h", function ()
    local file_name = vim.api.nvim_buf_get_name(0)
    local name_no_ext = string.gsub(file_name, "(.-)%..*", "%1")
    vim.cmd("vsplit " .. name_no_ext .. ".h")
end)
