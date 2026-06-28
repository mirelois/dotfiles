
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    local ok = pcall(vim.treesitter.start)
  end,
})


vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = { '.git' },
})

-- local opts = { buffer = bufnr, remap = false }
local opts = {}


vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
-- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts) done by conform
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[g", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "]g", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, opts)

vim.lsp.inlay_hint.enable(true)


