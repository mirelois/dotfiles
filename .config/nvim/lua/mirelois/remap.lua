vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", ":Ex<CR>")
vim.keymap.set("n", "-", ":Oil<CR>")

vim.keymap.set("n", "<leader><leader>h", ":Telescope help_tags<CR>")

vim.keymap.set('n', '<leader><CR>', 'm`o<Esc>``')
vim.keymap.set('n', '<leader><S-CR>', 'm`O<Esc>``')

vim.keymap.set('n', '<C-w>-', ':split<CR>')
vim.keymap.set('n', '<C-w>|', ':vsplit<CR>')

--allowes moving selected code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--keep selection with > and <
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.opt.formatoptions:remove { "c", "r", "o" }

--change to regular C-d, C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
--search terms stay in middle search with /
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
-- deletes selected text without changing buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- yanks sttuf to clipboard instead of buffer
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>") --disables Q
vim.keymap.set("n", "<C-f>", ":silent !tmux neww tmux-sessionizer<CR>")

--quickfix navigation ????
vim.keymap.set("n", "<Tab>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<S-Tab>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


--start to replace word you are on
vim.keymap.set("n", "<leader>*", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("v", "<leader>*", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--start search for current word
vim.keymap.set("n", "<leader>+", [[yiw:/<C-r>"<CR>]])
--makes code executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
--changing words cycling
vim.keymap.set("n", "<leader><Tab>", "ncw")

--splits
vim.keymap.set("n", "<leader>-", ':split<CR>')
vim.keymap.set("n", "<leader>|", ':vsplit<CR>')

--Keymaps for surround
--vim.keymap.set("v", [[<leader>(]], [[c(<C-r>")<Esc>]])
--vim.keymap.set("v", [[<leader>{]], [[c{<C-r>"}<Esc>]])
--vim.keymap.set("v", [[<leader>[]], [[c[<C-r>"]<Esc>]])
--vim.keymap.set("v", [[<leader>"]], [[c"<C-r>""<Esc>]])
--vim.keymap.set("v", [[<leader>']], [[c'<C-r>"'<Esc>]])

vim.keymap.set("i", "{<CR>", "{<CR>}<Esc>ko")

--vim.keymap.set("x", "<C-v>", "C-V")
