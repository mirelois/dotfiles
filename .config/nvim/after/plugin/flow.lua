require('flow').setup {
    output = {
        buffer = false,
        split_cmd = '80vsplit',
    },
}

local function flow_buffer(flag, cmd)
    if cmd=="" then
        cmd = '80vsplit'
    end
    require('flow').setup {
        output = {
            buffer = flag,
            split_cmd = cmd,
        }
    }
end

vim.api.nvim_create_user_command("FlowBuff", function()
    local buffer = vim.fn.input "Buffer: "
    local cmd = vim.fn.input "Split command(leave blank for default): "
    flow_buffer(buffer, cmd)
end, {})


-- require('flow.vars').add_vars({
--   str = "test-val-2",
--   num = 3,
--   bool = true,
--   var_with_func = function()
--     -- the value of this var is computed by running this function at runtime
--     return "test-val"
--   end
-- })


vim.keymap.set('v', '<leader>r', ':FlowRunSelected<CR>', {})
vim.keymap.set('n', '<leader>rr', ':FlowRunFile<CR>', {})
vim.keymap.set('n', '<C-f>', ':FlowLauncher<CR>', {})

-- set custom commands
vim.keymap.set('n', '<leader>R1', ':FlowSetCustomCmd 1<CR>', {})
vim.keymap.set('n', '<leader>R2', ':FlowSetCustomCmd 2<CR>', {})
vim.keymap.set('n', '<leader>R3', ':FlowSetCustomCmd 3<CR>', {})

-- run custom commands
vim.keymap.set('n', '<leader>r1', ':FlowRunCustomCmd 1<CR>', {})
vim.keymap.set('n', '<leader>r2', ':FlowRunCustomCmd 2<CR>', {})
vim.keymap.set('n', '<leader>r3', ':FlowRunCustomCmd 3<CR>', {})
vim.keymap.set('n', '<leader>rp', ':FlowRunLastCmd<CR>', {})
vim.keymap.set('n', '<leader>ro', ':FlowLastOutput<CR>', {})


--custum vars
-- $pwd 	the directory where vim/nvim was launched
-- $curr_file 	the path of the current file you are editing










