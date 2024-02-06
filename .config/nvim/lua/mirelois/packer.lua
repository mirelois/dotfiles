-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-context')
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        requires = "nvim-treesitter/nvim-treesitter",
    })

    use('nvim-treesitter/playground')

    use('ThePrimeagen/harpoon')

    use('mbbill/undotree')

    use('tpope/vim-fugitive')

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    -- use { 'jdhao/better-escape.vim', event = 'InsertEnter' }
    use { "tpope/vim-surround" }
    use { "tpope/vim-repeat" }
    use { 'rockerBOO/boo-colorscheme-nvim' }
    use { 'folke/tokyonight.nvim' }
    use { "EdenEast/nightfox.nvim" }
    use { "catppuccin/nvim", as = "catppuccin" }
    use { "dracula/vim" }
    use { "rebelot/kanagawa.nvim" }
    use { 'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true } }
    use { 'echasnovski/mini.nvim', branch = 'stable' }
    use { 'cesaralvarod/tokyogogh.nvim' }
    use { "akinsho/toggleterm.nvim", tag = '*' }
    use { "lukas-reineke/indent-blankline.nvim" }
    use { "wellle/targets.vim" }
    use { 'nvim-tree/nvim-web-devicons' }
    use { 'vimpostor/vim-tpipeline' }
    use { 'arjunmahishi/flow.nvim' }

    use { 'numToStr/Comment.nvim' }
    use { 'folke/twilight.nvim' }

    use { "HiPhish/rainbow-delimiters.nvim" }

    use {
        'kevinhwang91/nvim-fundo', requires = 'kevinhwang91/promise-async',
        run = function() require('fundo').install() end
    }
    use { 'mfussenegger/nvim-dap' }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use { 'theHamsta/nvim-dap-virtual-text' }
    use { 'jay-babu/mason-nvim-dap.nvim' }

    use { 'mfussenegger/nvim-jdtls' }
    use { 'nvim-telescope/telescope-ui-select.nvim' }

    use { 'norcalli/nvim-colorizer.lua' }

    use { 'tpope/vim-abolish' }

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = {
                "markdown" }
        end,
        ft = { "markdown" },
    })

    use({
        'mikesmithgh/kitty-scrollback.nvim',
        disable = false,
        opt = true,
        cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
        event = { 'User KittyScrollbackLaunch' },
        -- tag = '*', -- latest stable version, may have breaking changes if major version changed
        -- tag = 'v2.0.0', -- pin specific tag
        config = function()
            require('kitty-scrollback').setup()
        end,
    })

    use { "RaafatTurki/corn.nvim" }

    use { "ray-x/lsp_signature.nvim" }

    use { "stevearc/oil.nvim" }

    use { "stevearc/conform.nvim" }

    use { "aserowy/tmux.nvim" }

    use { 'kovetskiy/sxhkd-vim' }

    -- use { "ggandor/leap.nvim" }

    -- use { "monaqa/dial.nvim" }
end)
