local harpoon = require("harpoon")

local function trim_spaces(str)
    return string.gsub(str, "^%s*(.-)%s*$", "%1")
end

local function get_name(str)
    return string.gsub(str, ".*/(.-)%..*", "%1")
end

local function get_parent_dir(str)
    return string.gsub(str, "(.*/).*", "%1")
end

local function get_file_name(str)
    return string.gsub(str, ".*/(.-)", "%1")
end

local function remove_extention(str)
    return string.gsub(str, "(.-)%..*", "%1")
end

local function default_list_behaviour(list_item, list, options)

    options = options or {}
    if list_item == nil then
        return
    end

    local bufnr = vim.fn.bufnr(list_item.value)
    local set_position = false
    if bufnr == -1 then
        set_position = true
        bufnr = vim.fn.bufnr(list_item.value, true)
    end
    if not vim.api.nvim_buf_is_loaded(bufnr) then
        vim.fn.bufload(bufnr)
        vim.api.nvim_set_option_value("buflisted", true, {
            buf = bufnr,
        })
    end

    if options.vsplit then
        vim.cmd("vsplit")
    elseif options.split then
        vim.cmd("split")
    elseif options.tabedit then
        vim.cmd("tabedit")
    end

    vim.api.nvim_set_current_buf(bufnr)

    if set_position then
        vim.api.nvim_win_set_cursor(0, {
            list_item.context.row or 1,
            list_item.context.col or 0,
        })
    end

end

local show_output = true

local input_cond = false

local last_script = nil

-- REQUIRED
harpoon:setup({
    -- Setting up custom behavior for a list named "cmd"
    scripts = {

        -- This function gets invoked with the options being passed in from
        -- list:select(index, <...options...>)
        -- @param list_item {value: any, context: any}
        -- @param list { ... }
        -- @param option any
        select = function(list_item, list, options)

            if options.edit then
                default_list_behaviour(list_item, list, options)
                return
            end


            local curr_file = vim.api.nvim_buf_get_name(0)

            local curr_file_no_ext = remove_extention(curr_file)

            local cwd = trim_spaces(vim.fn.system("pwd"))

            local file_name = get_file_name(list_item.value)

            local name = get_file_name(curr_file)

            local name_no_ext = get_name(curr_file)

            local script_dir = get_parent_dir(list_item.value)

            local vars = ""

            vars = vars .. string.format("%s='%s' ", "cwd", cwd)
            vars = vars .. string.format("%s='%s' ", "curr_file", curr_file)
            vars = vars .. string.format("%s='%s' ", "curr_file_no_ext", curr_file_no_ext)
            vars = vars .. string.format("%s='%s' ", "curr_file_name", name)
            vars = vars .. string.format("%s='%s' ", "curr_file_name_no_ext", name_no_ext)

            -- command is of format: cd <FILE_PARENT_DIR> && <VARS_DEFINITION> ./<FILE_NAME>

            local input_str

            if input_cond then
                input_str = " " .. vim.fn.input("Input: ")
            else
                input_str = ""
            end

            local command = "cd " .. script_dir .. " && " .. vars .. "./" .. file_name .. input_str
            -- local command = vars .. "./" .. list_item.value

            local output = vim.fn.system(command)

            if show_output then
                local len = string.len(command)

                local s = "\n\n" .. string.rep("-", len) .. "\n\n[Output]\n"

                vim.notify("[Command]\n" .. command .. s .. output)
            end
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

vim.keymap.set("n", "<M-C-h>", function()
    harpoon:list("scripts"):select(1)
    last_script = 1
end)
vim.keymap.set("n", "<M-C-j>", function()
    harpoon:list("scripts"):select(2)
    last_script = 2
end)
vim.keymap.set("n", "<M-C-k>", function()
    harpoon:list("scripts"):select(3)
    last_script = 3
end)
vim.keymap.set("n", "<M-C-l>", function()
    harpoon:list("scripts"):select(4)
    last_script = 4
end)

vim.api.nvim_create_user_command("PrepScript", function()
    vim.api.nvim_command([[%s/\.\.\//$cwd/]])
end, {})

vim.api.nvim_create_user_command("HarpoonToggleShow", function()
    show_output = not show_output
    print("Show outputset to:", show_output)
end, {})

vim.api.nvim_create_user_command("HarpoonToggleInput", function()
    input_cond = not input_cond
    print("Input set to: ", input_cond)
end, {})

vim.api.nvim_create_user_command("HarpoonEditLastCmd", function()
    if last_script ~= nil then
        vim.cmd("split")
        harpoon:list("scripts"):select(last_script)
    else
        vim.notify("No last script")
    end
end, {})

vim.api.nvim_create_user_command("HarpoonRunLastCmd", function()
    if last_script ~= nil then
        harpoon:list("scripts"):select(last_script)
    else
        vim.notify("No last script")
    end
end, {})

vim.api.nvim_create_user_command("HarpoonRunOnSave", function()
    local file_name = vim.api.nvim_buf_get_name(0)

    local script

    if last_script ~= nil then
        script = vim.fn.input "Script(defaults to last used): " or last_script
    else
        script = vim.fn.input "Script(no default): "
    end
    local pattern = vim.fn.input("Pattern(defaults to file name): " or file_name)

    vim.api.nvim_create_autocmd("BufWritePost", {

        group = vim.api.nvim_create_augroup("AutoRun", { clear = true }),
        pattern = pattern,
        callback = function()
            harpoon:list("scripts"):select(tonumber(script))
        end,
    })
end, {})

vim.keymap.set("n", "<leader>ho", function()
    show_output = not show_output
    print("Show outputset to:", show_output)
end)
vim.keymap.set("n", "<leader>hi", function()
    input_cond = not input_cond
    print("Input set to :", input_cond)
end)
vim.keymap.set("n", "<leader>hp", function()
    if last_script ~= nil then
        harpoon:list("scripts"):select(last_script)
    else
        vim.notify("No last script")
    end
end)
vim.keymap.set("n", "<leader>he", function()
    if last_script ~= nil then
        vim.cmd("split")
        harpoon:list("scripts"):select(last_script)
    else
        vim.notify("No last script")
    end
end)

harpoon:extend({
    UI_CREATE = function(cx)
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:select_menu_item({ split = true, edit = true })
        end, { buffer = cx.bufnr })
    end,
})


-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
