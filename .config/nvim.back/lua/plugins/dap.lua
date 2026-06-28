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
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
    {
        "mfussenegger/nvim-dap",

        keys = {
            { '<F5>',       function() require('dap').continue() end },
            { '<F10>',      function() require('dap').step_over() end },
            { '<F11>',      function() require('dap').step_into() end },
            { '<F12>',      function() require('dap').step_out() end },
            { '<Leader>b',  function() require('dap').toggle_breakpoint() end },
            { '<Leader>B',  function() require('dap').set_breakpoint() end },
            { '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
            { '<Leader>dr', function() require('dap').repl.open() end },
            { '<Leader>dl', function() require('dap').run_last() end },
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
