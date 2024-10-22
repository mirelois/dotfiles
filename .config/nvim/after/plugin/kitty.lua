vim.g.kitty_navigator_no_mappings = 1

vim.keymap.set("n", "<C-S-l>", ":KittyNavigateRight<CR>")
vim.keymap.set("n", "<C-S-k>", ":KittyNavigateUp<CR>")
vim.keymap.set("n", "<C-S-j>", ":KittyNavigateDown<CR>")
vim.keymap.set("n", "<C-S-h>", ":KittyNavigateLeft<CR>")

-- nnoremap <silent> Ctrl :KittyNavigateLeft<cr>
-- nnoremap <silent> {Down-Mapping} :KittyNavigateDown<cr>
-- nnoremap <silent> {Up-Mapping} :KittyNavigateUp<cr>
-- nnoremap <silent> {Right-Mapping} :KittyNavigateRight<cr>
