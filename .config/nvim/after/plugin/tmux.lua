require('tmux').setup({
     navigation = {
        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = false,
    },
})

vim.keymap.set("n", "<C-S-h>", [[<cmd>lua require("tmux").move_left()<cr>]])
vim.keymap.set("n", "<C-S-j>", [[<cmd>lua require("tmux").move_bottom()<cr>]])
vim.keymap.set("n", "<C-S-k>", [[<cmd>lua require("tmux").move_top()<cr>]])
vim.keymap.set("n", "<C-S-l>", [[<cmd>lua require("tmux").move_right()<cr>]])
