return {
    "lervag/vimtex",
    -- ft = "tex",
    lazy = false,
    -- tag = "v2.15", -- uncomment to pin to a specific release
    keys = {
        { "<leader>c", "<cmd>VimtexCompile<CR>" },
        { "<leader>t", "<cmd>VimtexTocToggle<CR>" },
        { "<leader>v", "<cmd>VimtexView<CR>" },
    },
    init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = 'sioyek'
    end,
    config = function()
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
            pattern = "*.tex",
            callback = function()
                vim.opt.spell = true
                vim.opt.spelllang = "en_us"
                vim.opt.wrap = true
            end
        })
    end
}
