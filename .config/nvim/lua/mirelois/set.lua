-- vim.opt.list           = true
-- vim.opt.listchars      = {
--     eol = "󰌑"
-- }

vim.opt_local.spelllang = "en_us"

vim.opt.cmdheight       = 0

--line numbers
vim.opt.nu              = true
vim.opt.relativenumber  = true
vim.opt.tabstop         = 4
vim.opt.softtabstop     = 4
vim.opt.shiftwidth      = 4
vim.opt.expandtab       = true

vim.opt.foldmethod      = "marker"

--splits
vim.opt.splitright      = true
vim.opt.splitbelow      = true
vim.opt.equalalways     = false

vim.opt.wrap            = false

vim.opt.swapfile        = false
vim.opt.backup          = false
vim.opt.undodir         = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile        = true

vim.opt.hlsearch        = false
vim.opt.incsearch       = true

vim.opt.termguicolors   = false

vim.opt.scrolloff       = 8
vim.opt.signcolumn      = "yes" --
vim.opt.isfname:append("@-@")  --

vim.opt.updatetime = 50

vim.opt.colorcolumn = "0"

vim.g.mapleader = " "

vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

if vim.fn.has("termguicolors") then
    vim.opt.termguicolors = true
end
