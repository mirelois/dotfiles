-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local jdtls = require "jdtls"

local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;


local root_markers = { ".gradle", "gradlew", ".git", "pom.xml" }
local root_dir = jdtls.setup.find_root(root_markers)
local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

local api = vim.api

local function add_commands(client, bufnr, opts)
    local function create_cmd(name, command, cmdopts)
        api.nvim_buf_create_user_command(bufnr, name, command, cmdopts or {})
    end
    create_cmd("JdtCompile", "lua require('jdtls').compile(<f-args>)", {
        nargs = "?",
        complete = "custom,v:lua.require'jdtls'._complete_compile"
    })
    create_cmd("JdtSetRuntime", "lua require('jdtls').set_runtime(<f-args>)", {
        nargs = "?",
        complete = "custom,v:lua.require'jdtls'._complete_set_runtime"
    })
    create_cmd("JdtUpdateConfig", function(args)
        require("jdtls").update_projects_config(args.bang and { select_mode = "all" } or {})
    end, {
        bang = true
    })
    create_cmd("JdtJol", "lua require('jdtls').jol(<f-args>)", {
        nargs = "*"
    })
    create_cmd("JdtBytecode", "lua require('jdtls').javap()")
    create_cmd("JdtJshell", "lua require('jdtls').jshell()")
    create_cmd("JdtRestart", "lua require('jdtls.setup').restart()")
    local ok, dap = pcall(require, 'dap')
    if ok then
        local command_provider = client.server_capabilities.executeCommandProvider or {}
        local commands = command_provider.commands or {}

        if not vim.tbl_contains(commands, "vscode.java.startDebugSession") then
            return
        end
        require("jdtls.dap").setup_dap({})
        api.nvim_command("command! -buffer JdtUpdateDebugConfig lua require('jdtls.dap').setup_dap_main_class_configs({ verbose = true })")
        local redefine_classes = function()
            local session = dap.session()
            if not session then
                vim.notify('No active debug session')
            else
                vim.notify('Applying code changes')
                session:request('redefineClasses', nil, function(err)
                    assert(not err, vim.inspect(err))
                end)
            end
        end
        api.nvim_create_user_command('JdtUpdateHotcode', redefine_classes, {
            desc = "Trigger reload of changed classes for current debug session",
        })
    end
end

-- local function create_commands()
--     local key = {
--
--         JdtCompile = jdtls.compile(),
--         JdtSetRuntime = jdtls.set_runtime(),
--         JdtUpdateConfig = jdtls.update_project_config(),
--         JdtUpdateConfigs = jdtls.update_projects_config(),
--         JdtDapSetup = jdtls.dap.setup_dap_main_class_configs(),
--         JdtJol = jdtls.jol(),
--         JdtJshell = jdtls.jshell(),
--     }
--
--     for string, value in pairs(key) do
--         vim.api.nvim_create_user_command(string, value())
--     end
-- end

local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.level=ALL',
        '-Xmx1G',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        '/home/utilizador/jdtls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar',
        '-configuration',
        '/home/utilizador/jdtls/org.eclipse.jdt.ls.product/target/repository/config_linux',

        -- jdtls_bin,
        "-data",
        workspace_dir,
    },

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml' }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            signatureHelp = { enabled = true },
            completion = {
                favoriteStaticMembers = {},
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
            },
            configuration = {
                runtimes = {
                    -- {
                    --     name = "JavaSE-1.8",
                    --     path = "/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home",
                    --     default = true,
                    -- },
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17-openjdk-amd64/",
                    },
                    {
                        name = "JavaSE-21",
                        path = "/usr/lib/jvm/java-21-openjdk-amd64/",
                    },
                    -- {
                    --     name = "JavaSE-19",
                    --     path = "/Library/Java/JavaVirtualMachines/jdk-19.jdk/Contents/Home",
                    -- },
                },
            },
        }
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        extendedClientCapabilities = extendedClientCapabilities,
        bundles = {
            vim.fn.glob(
                "/home/utilizador/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.51.1.jar",
                1)
        },
    },

    on_attach = function(client, bufnr)
        -- if you setup DAP according to https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration you can uncomment below
        jdtls.setup_dap({ hotcodereplace = "auto" })

        add_commands(client, bufnr)
        --this line does not work, do it manualy
        -- jdtls.setup.add_commands() important to ensure you can update configs when build is updated
        -- jdtls.dap.setup_dap_main_class_configs()

        --keymaps
        vim.keymap.set("n", "<leader>oi", require 'jdtls'.organize_imports())
        vim.keymap.set("n", "<leader>ev", require('jdtls').extract_variable())
        vim.keymap.set("n", "<leader>tev", require('jdtls').extract_variable(true))
        vim.keymap.set("n", "<leader>ec", require('jdtls').extract_constant())
        vim.keymap.set("n", "<leader>tec", require('jdtls').extract_constant(true))
        vim.keymap.set("n", "<leader>em", require('jdtls').extract_method(true))
        -- you may want to also run your generic on_attach() function used by your LSP config
        -- vim.lsp.client.on_attach()
    end,

    capabilities = vim.lsp.protocol.make_client_capabilities()
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
