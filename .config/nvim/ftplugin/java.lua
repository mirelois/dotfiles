local opts = {
    cmd = {},
    settings = {
        java = {
            signatureHelp = { enabled = true },
            completion = {
                favoriteStaticMembers = {},
                filteredTypes = {
                    -- "com.sun.*",
                    -- "io.micrometer.shaded.*",
                    -- "java.awt.*",
                    -- "jdk.*",
                    -- "sun.*",
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
                    -- {
                    --     name = "JavaSE-17",
                    --     path = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home",
                    -- },
                    -- {
                    --     name = "JavaSE-19",
                    --     path = "/Library/Java/JavaVirtualMachines/jdk-19.jdk/Contents/Home",
                    -- },
                },
            },
        },
    },
}

local function setup()
    local pkg_status, jdtls = pcall(require, "jdtls")
    if not pkg_status then
        vim.notify("unable to load nvim-jdtls", "error")
        return {}
    end

    -- local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
    local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"

    local root_markers = { ".gradle", "gradlew", ".git" }
    local root_dir = jdtls.setup.find_root(root_markers)
    local home = os.getenv("HOME")
    local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
    local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

    opts.cmd = {
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

    }
    opts.init_options = {
        bundles = {
            vim.fn.glob(
            "/home/utilizador/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.51.0.jar", 1)
        },
    }


    local on_attach = function(client, bufnr)
        jdtls.setup.add_commands() -- important to ensure you can update configs when build is updated
        -- if you setup DAP according to https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration you can uncomment below
        jdtls.setup_dap({ hotcodereplace = "auto" })
        -- jdtls.dap.setup_dap_main_class_configs()

        -- you may want to also run your generic on_attach() function used by your LSP config
    end

    opts.on_attach = on_attach
    opts.capabilities = vim.lsp.protocol.make_client_capabilities()

    return opts
end


local jdtls_config = setup()
local pkg_status, jdtls = pcall(require, "jdtls")
if not pkg_status then
    vim.notify("unable to load nvim-jdtls", "error")
    return
end
jdtls.start_or_attach(jdtls_config)
