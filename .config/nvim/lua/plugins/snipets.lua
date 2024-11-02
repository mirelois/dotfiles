
return {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    lazy = false,

    keys = function()
        local ls = require("luasnip")
        local types = require("luasnip.util.types")

        local keys = {
            {
                "<c-j>",
                function()
                    if ls.jumpable(-1) then
                        ls.jump(-1)
                    end
                end,
                mode = { "i", "s" }
            },
            {
                "<c-k>",
                function()
                    if ls.expand_or_jumpable() then
                        ls.expand_or_jump()
                    end
                end,
                mode = { "i", "s" }
            },
            {
                "<c-l>",
                function()
                    if ls.choice_active() then
                        ls.change_choice(1)
                    end
                end,
                mode = "i"
            }
        }
        return keys
    end,

    config = function()
        require("luasnip.loaders.from_vscode").lazy_load() --friendly snippets

        local ls = require("luasnip")
        local types = require("luasnip.util.types")

        local s = ls.snippet
        local fmt = require("luasnip.extras.fmt").fmt
        local f = ls.function_node
        local i = ls.insert_node
        local c = ls.choice_node
        local t = ls.text_node
        local sn = ls.snippet_node
        local rep = require("luasnip.extras").rep


        ls.config.set_config {
            history = true,

            updateevents = "TextChanged,TextChangedI",

            enable_autosnippets = true,

            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { "󰌑", "Error" } }
                    }
                }
            }
        }

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
            s("currfile",
                f(
                    function()
                        return vim.api.nvim_buf_get_name(0)
                    end
                )),
        })
        ls.add_snippets("erlang", {
            s("spawnfun", fmt([[spawn(fun() -> {} end,)]], i(1)))
        })

        ls.add_snippets("python", {
            s("print", fmt([[print({})]], c(1, {
                i(1),
                fmt([["{}"]], i(1))
            }
            )))
        })

        ls.add_snippets("quarto", {
            s("header", fmt([[
    ---
    title: "{}"
    format:
      html:
        code-fold: true
    jupyter: python3
    ---
    ]], i(1))),

            s("cell", fmt(
                [[
    ```{{python}}

    {}

    ```
    ]], i(1)))
        })

        ls.add_snippets("lua", {
            s("req", fmt("local {} = require('{}')",
                { f(function(import_name)
                    local parts = vim.split(import_name[1][1], ".", true)
                    return parts[#parts] or ""
                end, { 1 }), i(1) })),

            s("use", fmt("use {{ '{}' }}", { i(1) })),

            s("map", fmt([[vim.keymap.set("{}", "{}", "{}")]], { i(1), i(2), i(3) }))
        }
        )


        ls.add_snippets("c", {
            s("fori", fmt([[
    for(int {} = 0; {} < N; {}++){{
        {}
    }}]], { i(1, "i"), rep(1), rep(1), i(2) })),

            s("print",
                fmt(
                    [[
    printf({});
    ]]
                    , c(1, { fmt([["{}"]], i(1)),
                        fmt([["{}", {}]], { i(1), i(2) })
                    }
                    )
                ))
        }
        )

        ls.add_snippets("cpp", {
            s("fori", fmt([[
    for(int {} = 0; {} < N; {}++){{
        {}
    }}]], { i(1, "i"), rep(1), rep(1), i(2) })),
        }
        )

        ls.add_snippets("sh", {

            s("shebang", t("#!/bin/bash")),

            s("firefox", fmt([[firefox --no-remote -P float --class "Float" {}]], i(1))),

            s("tmuxsplitw", fmt([[PANE_ID=$(tmux split-window -d -P -F "#{{pane_id}}" -l {} {}{})]], {
                i(1, "10"),
                c(2, {
                    sn(nil, fmt("-c $DIR/{} ", i(1))),
                    t(),
                }),
                c(3, { t("$CMD"), sn(nil, fmt([["{}"]], i(1))) })
            })),

            s("tmuxtile", t("tmux select-layout tiled")),

            s("tmuxkillp", t("tmux kill-pane -a -t 0")),

            s("tmuxonexit", t("tmux setw remain-on-exit on")),

            s("DIR", fmt([[DIR={}]], f(function() return os.getenv("PWD") end))),

            s("javac", fmt([[javac {}{}]], {
                c(1, {
                    t("-d $DIR/classes/ "),
                    t(),
                }),
                c(2, {
                    sn(nil, fmt("$DIR/code/{}", i(1))),
                    t(),
                })
            })),

            s("mvnexec", fmt([[mvn exec:java -Dexec.mainClass={}.{} -q]], { i(1), c(2, { t("$class_name"), i() }) })),

            s("tmuxsetup", fmt([[
        #!/usr/bin/env bash

        DIR={}
        CMD="{}"

        tmux kill-pane -a -t 0
        tmux setw remain-on-exit on

        PANE_ID=$(tmux split-window -d -P -F "#{{pane_id}}" -l 10 -c $DIR/ "$CMD")

        tmux select-layout tiled

        # enviroment variables
        # $curr_file             : current file path
        # $curr_file_no_ext      : current file path without extention
        # $cwd                   : current working directory
        # $curr_file_name        : name from current file
        # $curr_file_name_no_ext : name from current file with no extention
    ]], { f(function()
                return os.getenv('PWD')
            end), i(1) })),

            s("tmuxsend", fmt([[tmux send-keys -t {} {} ]], {
                c(1, {
                    t("$PANE_ID"),
                    i(1),
                }),
                c(2, {
                    fmt([[{} Enter]], i(1)),
                    fmt([[{} Enter \
                {} Enter \ ]], { i(1), i(2) }),
                })
            })),

            s("envvars", t({
                "# enviroment variables",
                "# $curr_file             : current file path",
                "# $curr_file_no_ext      : current file path without extention",
                "# $cwd                   : current working directory",
                "# $curr_file_name        : name from current file",
                "# $curr_file_name_no_ext : name from current file with no extention",
            }))

        })
    end

}
