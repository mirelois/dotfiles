--if vim.g.snippets ~= "luasnip" then
--    return
--end

require("luasnip.loaders.from_vscode").lazy_load() --friendly snippets

local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config {
    history = true,

    updateevents = "TextChanged,TextChangedI"
}



vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expandable() then
        ls.expand()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if ls.jumpable(1) then
        ls.jump(1)
    end
end, {silent = true})

vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

vim.keymap.set("i", "<c-h>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node
local sn = ls.snippet_node
local rep = require("luasnip.extras").rep

ls.add_snippets("all", {
    s("currtime",
        f(
            function()
                return os.date "%D - %H:%M"
            end)),
    s("currdir",
        f(
            function()
                return os.getenv("PWD")
            end
        )),
}
)

ls.add_snippets("lua", {
    s("req", fmt("local {} = require('{}')",
    {f(function(import_name)
        local parts = vim.split(import_name[1][1], ".", true)
        return parts[#parts] or ""
    end, {1}), i(1) })),

    s("use", fmt("use {{ '{}' }}", { i(1) })),

    s("map", fmt([[vim.keymap.set("{}", "{}", "{}")]], {i(1), i(2), i(3)}))
}
)


ls.add_snippets("c", {
    s("fori", fmt([[
    for(int {} = 0; {} < N; {}++){{
        {}
    }}]], { i(1, "i"), rep(1), rep(1), i(2)})),

    s("print",
    fmt(
    [[
    printf({});
    ]]
    , c(1, {fmt([["{}"]], i(1)),
            fmt([["{}", {}]], {i(1), i(2)})
           }
        )
    ))
}
)

ls.add_snippets("cpp", {
    s("fori", fmt([[
    for(int {} = 0; {} < N; {}++){{
        {}
    }}]], { i(1, "i"), rep(1), rep(1), i(2)})),
}
)
