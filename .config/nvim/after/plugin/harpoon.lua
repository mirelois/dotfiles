local harpoon = require("harpoon")

local function trim_spaces(str)
    return string.gsub(str, "^%s*(.-)%s*$", "%1")
end

local function get_class_name(str)
    return string.gsub(str, ".-/(.-)%..*" , "%1")
end

-- REQUIRED
harpoon:setup({
    -- Setting up custom behavior for a list named "cmd"
    scripts = {

        -- This function gets invoked with the options being passed in from
        -- list:select(index, <...options...>)
        -- @param list_item {value: any, context: any}
        -- @param list { ... }
        -- @param option any
        select = function(list_item, list, option)
            local curr_file = vim.api.nvim_buf_get_name(0)

            local cwd = trim_spaces(vim.fn.system("pwd"))

            local class_name = get_class_name(list_item.value)

            local vars = ""

            vars = vars .. string.format("%s='%s' ", "cwd", cwd)
            vars = vars .. string.format("%s='%s' ", "curr_file", curr_file)
            vars = vars .. string.format("%s='%s' ", "class_name", class_name)

            local command = vars .. "./" .. list_item.value
            
            local output =  vim.fn.system(command)

            print(output)
        end

    }
})

vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<leader>hc", function() harpoon:list("scripts"):append() end)
vim.keymap.set("n", "<M-C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list("scripts")) end)

vim.keymap.set("n", "<M-C-h>", function() harpoon:list("scripts"):select(1) end)
vim.keymap.set("n", "<M-C-j>", function() harpoon:list("scripts"):select(2) end)
vim.keymap.set("n", "<M-C-k>", function() harpoon:list("scripts"):select(3) end)
vim.keymap.set("n", "<M-C-l>", function() harpoon:list("scripts"):select(4) end)


-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
