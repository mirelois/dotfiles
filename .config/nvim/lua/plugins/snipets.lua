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
        local fmta = require("luasnip.extras.fmt").fmta
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
            s("lorem", fmt([[ Lorem ipsum dolor sit amet, consectetur
            adipiscing elit. Praesent lobortis nec tortor vitae rhoncus.
            Vestibulum ante ipsum primis in faucibus orci luctus et ultrices
            posuere cubilia curae; Praesent in nisi malesuada, tincidunt dui
            vel, ultricies odio. Nulla facilisi. Fusce maximus purus sem, at
            rhoncus eros dictum a. In a nisi egestas, scelerisque metus id,
            dignissim tellus. In posuere maximus massa non ultricies. Donec
            consequat eros lectus. Aenean non neque venenatis, tincidunt augue
            vitae, tincidunt diam. Mauris convallis arcu at sapien fermentum
            tristique. Fusce est felis, posuere ac arcu a, lacinia cursus
            neque. Etiam rhoncus, ligula in euismod sagittis, ipsum elit ornare
            quam, nec dictum lectus eros porttitor ipsum. Maecenas id eleifend
            turpis. In sapien quam, tristique ac nunc id, porta ultrices elit.
            Integer vitae mi sit amet dui elementum malesuada sit amet vitae
            quam. Pellentesque fermentum augue in tellus tempor, ac viverra
            lectus pharetra.

            Morbi neque tortor, cursus vitae nunc id, semper dapibus eros. Sed pellentesque
            velit dui, eu hendrerit dolor egestas vitae. Nulla eleifend metus non dui
            fermentum, quis aliquam ante dignissim. Integer sit amet mauris viverra lorem
            pretium bibendum vel ac tellus. Cras porttitor fringilla condimentum. Donec eu
            euismod magna, sed tincidunt dolor. Vivamus ac dictum mi. Sed viverra risus
            diam, sit amet molestie enim pharetra vel. Curabitur vestibulum molestie
            hendrerit. Donec eu viverra erat. Curabitur at arcu aliquet, condimentum diam
            eget, aliquet nunc.

            Quisque gravida nec sapien auctor ultricies. Praesent eu metus nec est
            imperdiet placerat ac non ante. Vivamus a purus condimentum arcu rhoncus
            laoreet. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi
            venenatis, est id vestibulum feugiat, lorem ante elementum arcu, non porta
            lectus nisi sit amet dolor. Phasellus nec facilisis diam. Phasellus efficitur
            lorem vel ante sodales auctor. Mauris imperdiet magna facilisis elit posuere
            laoreet. In hac habitasse platea dictumst. Sed fermentum, nibh id scelerisque
            laoreet, est ipsum ultricies nisl, eget congue eros urna sed augue. Nunc cursus
            id lectus et ullamcorper. Cras dictum ante quis ex mattis, at maximus elit
            viverra. Nullam nec luctus magna. Vestibulum eros tellus, fermentum non neque
            ac, interdum dictum augue.

            Phasellus eget gravida quam. Ut diam leo, bibendum quis lorem ac, placerat
            commodo tortor. In tincidunt dictum dictum. Morbi tempus auctor sapien, et
            fringilla felis interdum eget. Duis vel varius ante. Aliquam erat volutpat.
            Donec ultricies varius elementum. Proin id accumsan dolor, viverra tincidunt
            nunc. Pellentesque ultricies tincidunt mi non pellentesque. Nulla tempus felis
            id orci ullamcorper tempus. Vivamus consequat sit amet dui sit amet
            pellentesque. Ut feugiat ex vitae lectus tincidunt suscipit. Pellentesque justo
            urna, tempus at nulla sit amet, vulputate facilisis odio. Mauris pretium in
            nisl sit amet aliquam.

            Praesent vehicula dictum eleifend. Vestibulum sollicitudin auctor eros quis
            tempus. Etiam laoreet posuere condimentum. Quisque ut pretium libero. Sed
            fringilla felis metus, et tincidunt mauris porttitor et. Maecenas laoreet, dui
            ac pretium vestibulum, velit massa pretium quam, vel tincidunt nisi enim non
            magna. Aenean viverra varius ante condimentum euismod.]], {})),
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
    ]], i(1))),
            s("break", t({ '```', '', '```{python}' })),
        })

        ls.add_snippets("lua", {
            s("req", fmt("local {} = require('{}')",
                { f(function(import_name)
                    local parts = vim.split(import_name[1][1], ".", true)
                    return parts[#parts] or ""
                end, { 1 }), i(1) })),

            s("use", fmt("use {{ '{}' }}", { i(1) })),

            s("map", fmt([[vim.keymap.set("{}", "{}", "{}")]], { i(1), i(2), i(3) })),

            s("key", fmt([[awful.key({{modkey}}, "{}", {})]], { i(1), i(2) }))
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
            s("cout", fmt([[std::cout << "{}" << std::endl;]], i(1))),
            s("guard", fmt([[
            #ifndef {}
            #define {}
            #endif //{}
            ]], { i(1), rep(1), rep(1) })),

            s("logger", fmt([[
            #if SPDLOG_ACTIVE_LEVEL != SPDLOG_LEVEL_OFF
                static std::shared_ptr<spdlog::logger>& get_logger() {{
                    static auto logger = Logger::getInstance().make_logger("{}");
                    return logger;
                }}
            #endif
            ]], {
                c(1, {
                    f(function()
                        local file_name = vim.api.nvim_buf_get_name(0)
                        return string.gsub(file_name, ".*/(.-)%..*", "%1")
                    end),
                    i(1)
                })
            })),
            s("file-logger", fmt([[
            #ifdef LOG_BYTES
                static std::shared_ptr<spdlog::logger>& get_file_logger() {{
                    static auto logger = ByteLogger::getInstance().make_logger("{}");
                    return logger;
                }}
            #endif
            ]], {
                c(1, {
                    f(function()
                        local file_name = vim.api.nvim_buf_get_name(0)
                        return "bytes_" .. string.gsub(file_name, ".*/(.-)%..*", "%1")
                    end),
                    i(1)
                })
            })),
            s("logc", fmt([[
            #if SPDLOG_ACTIVE_LEVEL != SPDLOG_LEVEL_OFF
                {}
            #endif //SPDLOG_ACTIVE_LEVEL != SPDLOG_LEVEL_OFF
            ]], {
                i(1)
            })),
            s("log", fmt([[SPDLOG_LOGGER_TRACE(get_logger(), {});]],
                {
                    c(1, {
                        fmt([["{}", {}]], { i(1), i(2) }),
                        fmt([["{}"]], i(1))
                    })
                })),
            s("logbyte", fmt([[
            #ifdef LOG_BYTES
                get_file_logger()->info("{} {{}}", {});
            #endif

            ]],
                {i(1), i(2)})),
            s("fori", fmt([[
            for(int {} = 0; {} < {}; {}++){{
                {}
            }}]], { i(1, "i"), rep(1), i(2), rep(1), i(3) })),
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

        ls.add_snippets("tex", {


            s("acr", fmt([[\newacronym{{{}}}{{{}}}{{{}}}]], {
                f(function(acronym)
                    local parts = vim.split(acronym[1][1], " ", true)

                    local result = ""

                    for _, part in ipairs(parts) do
                        result = result .. part:sub(1, 1)
                    end

                    return result:lower()
                end, { 1 }),
                f(function(acronym)
                    local parts = vim.split(acronym[1][1], " ", true)

                    local result = ""

                    for _, part in ipairs(parts) do
                        result = result .. part:sub(1, 1)
                    end

                    return result:upper()
                end, { 1 }),
                i(1),
            })
            )
        }
        )
    end

}
