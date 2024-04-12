local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<c-k>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
--cmp_mappings['<S-Tab>'] = nil
cmp_mappings["<CR>"] = nil
cmp_mappings['<Right>'] = nil
cmp_mappings['<Left>'] = nil
cmp_mappings['<Up>'] = nil
cmp_mappings['<Down>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    sources = {
        { name = 'otter' },
        { name = 'calc' },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "buffer" },
    }
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- use when nvim version 0.10
    -- if client.server_capabilities.inlayHintProvider then
    --     vim.lsp.buf.inlay_hint(bufnr, true)
    -- end

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[g", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]g", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)


lsp.setup()

require 'lspconfig'.ccls.setup {
    single_file_support = true,
    filetypes = { "cuda" },
    init_options = {
        compilationDatabaseDirectory = "build",
        index = {
            threads = 0,
        },
        clang = {
            excludeArgs = { "-frounding-math" },
        },
    }
}

require 'lspconfig'.pyright.setup {
    root_dir = function() return vim.fn.getcwd() end
}


require 'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            -- hint = {
            --     enable = true
            -- },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        },
    },
}

-- require("inlay-hints").setup({
--     only_current_line = true,
-- })
