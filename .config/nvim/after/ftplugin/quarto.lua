vim.keymap.set("n", "<C-CR>", ":QuartoSend<CR>")
vim.keymap.set("n", "<S-CR>", ":QuartoSend<CR>")

vim.opt_local.foldmarker = "```{,```"

function _G.myFoldText()
    local number_of_lines = vim.v.foldend - vim.v.foldstart + 1
    local top_line = vim.fn.getline(vim.v.foldstart):gsub("^%s*", "")
    local text_line = vim.fn.getline(vim.v.foldstart + 1):gsub("^%s*", "")
    return "-- " .. number_of_lines .. " lines: -- " .. text_line
end

vim.opt.foldtext = 'v:lua.myFoldText()'


local function remove_extention(str)
    return string.gsub(str, "(.-)%..*", "%1")
end


