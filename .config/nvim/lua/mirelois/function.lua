vim.api.nvim_create_user_command("W", function()
    vim.cmd('w')
end, {})

vim.api.nvim_create_user_command("Q", function()
    vim.cmd('q')
end, {})

vim.api.nvim_create_user_command("Read", function(tbl)
    local args = tbl.fargs
    local output
    if tbl.bang then
        vim.notify("lmao")
        output = vim.system(args, {text = true}):wait().stdout
    else
        output = vim.api.nvim_exec2(tbl.args, {output = true}).output
    end
    vim.api.nvim_put({output}, "c", true, true)
end, {nargs = '*'})

-- -- Open pdf files
-- vim.api.nvim_create_autocmd("BufReadCmd", {
--   pattern = "*.pdf",
--   callback = function()
--     -- local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
--     local filename = vim.api.nvim_buf_get_name(0)
--     vim.system({'sioyek', filename}, {detach = true})
--     vim.cmd([[:Oil]])
--   end
-- })
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*.pkl",
--   callback = function()
--     -- local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
--     local filename = vim.api.nvim_buf_get_name(0)
--     vim.system({'/home/utilizador/pickle_viewer.py', filename}, {detach = true})
--     vim.cmd([[:Oil]])
--   end
-- })
