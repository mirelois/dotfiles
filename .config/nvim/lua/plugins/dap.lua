return {
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "mason.nvim"
        },
        opts = {
            handlers = {
                function(config)
                    -- all sources with no handler get passed here
                    -- Keep original functionality
                    require('mason-nvim-dap').default_setup(config)
                end,
                -- cpp = function (config)
                --     config.adapters = {
                --         environment = {
                --             LD_PRELOAD = "/home/mirelois/Documents/HasLab/PhD/caju/build/libcaju.so",
                --         }
                --     }
                -- end,
                codelldb = function(config)
                    table.insert(config.configurations,
                        {
                            name = 'LLDB: Launch LD_PRELOAD',
                            type = 'codelldb',
                            request = 'launch',
                            program = function()
                                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                            end,
                            cwd = '${workspaceFolder}',
                            stopOnEntry = false,
                            args = {},
                            console = 'integratedTerminal',
                            env = function()
                                local variables = {
                                    LD_PRELOAD = "/home/mirelois/Documents/HasLab/PhD/caju/build/libcaju.so"
                                }
                                for k, v in pairs(vim.fn.environ()) do
                                    variables[k] = v
                                end
                                print(vim.inspect(variables))
                                return variables
                            end,
                        })
                    require('mason-nvim-dap').default_setup(config) -- don't forget this!
                end,
                python = function(config)
                    config.adapters = {
                        type = "executable",
                        command = "/usr/bin/python3",
                        args = {
                            "-m",
                            "debugpy.adapter",
                        },
                    }
                    require('mason-nvim-dap').default_setup(config) -- don't forget this!
                end,
            },
        }
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            require('dapui').setup()
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                -- dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                -- dapui.close()
            end
        end,
    },
    {
        "mfussenegger/nvim-dap",

        keys = {
            { '<F5>',        function() require('dap').continue() end },
            { '<F10>',       function() require('dap').step_over() end },
            { "<leader>de",  function() require("dap").run_to_cursor() end,                                              "Run to cursor", "dap" },
            { "<leader>di",  function() require("dap").step_into() end,                                                  "Step into",     "dap" },
            { "<leader>do",  function() require("dap").step_out() end,                                                   "Step out",      "dap" },
            { "<leader>dr",  function() require("dap").restart() end,                                                    "Pause",         "dap" },
            { "<leader>ds",  function() require("dap").pause() end,                                                      "Pause",         "dap" },
            { '<Leader>b',   function() require('dap').toggle_breakpoint() end },
            { '<Leader>B',   function() require('dap').set_breakpoint() end },
            { '<Leader>lp',  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
            { '<Leader>drp', function() require('dap').repl.open() end },
            { '<Leader>dl',  function() require('dap').run_last() end },
            { "<leader>dt",  function() require("dap").terminate() end,                                                  "Continue",      "dap" },
            { "<leader>df",  function() require("dap").focus_frame() end,                                                "Continue",      "dap" },
            {
                '<Leader>dh',
                function()
                    require('dap.ui.widgets').hover()
                end,
                mode = { 'n', 'v' }
            },
            {
                '<Leader>dp',
                function()
                    require('dap.ui.widgets').preview()
                end,
                mode = { 'n', 'v' }
            },
            { '<Leader>df',
                function()
                    local widgets = require('dap.ui.widgets')
                    widgets.centered_float(widgets.frames)
                end
            },
            { '<Leader>ds',
                function()
                    local widgets = require('dap.ui.widgets')
                    widgets.centered_float(widgets.scopes)
                end }
        },
    }
}
