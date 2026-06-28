require("config.lazy")

-- vim.lsp.config('*', {
--     root_dir = function() return vim.fn.getcwd() end
-- }
-- )
-- -- Next, you can provide a dedicated handler for specific servers.
-- -- For example, a handler override for the `rust_analyzer`:
-- vim.lsp.config('luals', {
--     on_init = function(client)
--         require("lsp-zero").nvim_lua_settings(client, {})
--     end,
--     settings = {
--         Lua = {
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = { 'vim' },
--             },
--         },
--     },
-- })
vim.lsp.enable('texlab')
