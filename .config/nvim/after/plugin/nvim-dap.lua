vim.keymap.set("n", "<C-F4>", ":lua require'dap'.terminate()<CR>")
vim.keymap.set("n", "<C-F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<C-F6>", ":lua require'dap'.restart()<CR>")
vim.keymap.set("n", "<C-F10>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<C-F11>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<C-F12>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoitn condition: '))<CR>")
vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ))<CR>")
-- vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl_open()<CR>")

require("nvim-dap-virtual-text").setup()

require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            return '/usr/bin/python3'
        end,
        args = function()
            local args_string = vim.fn.input("Input arguments: ")
            return vim.split(args_string, " ")
        end
    },
}

-- dap.configurations.java = {
--   {
--      -- You need to extend the classPath to list your dependencies.
--      -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
--
--     -- If using multi-module projects, remove otherwise.
--     -- projectName = "yourProjectName",
--
--     javaExec = "/usr/bin/java",
--     mainClass = "main",
--
--     -- If using the JDK9+ module system, this needs to be extended
--     -- `nvim-jdtls` would automatically populate this property
--     name = "Launch YourClassName",
--     request = "launch",
--     type = "java"
--   },
-- }





