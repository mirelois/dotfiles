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

    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use('mbbill/undotree')

    use('tpope/vim-fugitive')

    -- use { 'mirelois/flow.nvim' }

    use {
        'MeanderingProgrammer/markdown.nvim',
        name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
        requires = {
            'nvim-treesitter/nvim-treesitter',
            'ixru/nvim-markdown',
        },
        config = function()
            require('render-markdown').setup({
                file_types = { 'markdown', 'quarto' },
            })
        end,
    }

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
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-calc' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    -- use { 'jdhao/better-escape.vim', event = 'InsertEnter' }
    use { "tpope/vim-surround" }
    use { "tpope/vim-repeat" }
    use { "rebelot/kanagawa.nvim" }
    use { 'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true } }

    use { 'AckslD/nvim-trevJ.lua' }

    use { "lukas-reineke/indent-blankline.nvim" }
    use { "wellle/targets.vim" }

    use { 'nvim-tree/nvim-web-devicons' }

    use { 'vimpostor/vim-tpipeline' }

    use { 'numToStr/Comment.nvim' }

    use { "HiPhish/rainbow-delimiters.nvim" }

    use {
        'kevinhwang91/nvim-fundo', requires = 'kevinhwang91/promise-async',
        run = function() require('fundo').install() end
    }
    use { 'mfussenegger/nvim-dap', requires = { 'nvim-neotest/nvim-nio' } }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use { 'theHamsta/nvim-dap-virtual-text' }
    use { 'jay-babu/mason-nvim-dap.nvim' }

    use { 'mfussenegger/nvim-jdtls' }
    use { 'nvim-telescope/telescope-ui-select.nvim' }

    use { 'norcalli/nvim-colorizer.lua' }

    use { 'tpope/vim-abolish' }

    use { 'chentoast/marks.nvim' }

    use { "RaafatTurki/corn.nvim" }

    use { "ray-x/lsp_signature.nvim" }

    use { "stevearc/oil.nvim" }

    use { "stevearc/conform.nvim" }

    use { "aserowy/tmux.nvim" }

    use { 'michaelb/sniprun',
        run = 'sh ./install.sh 1' }

    use {
        'quarto-dev/quarto-nvim',
        requires = {
            'jmbuhr/otter.nvim'
        }
    }

    use {
        'benlubas/molten-nvim',
        requires = { { '3rd/image.nvim' } }
    }
end)
