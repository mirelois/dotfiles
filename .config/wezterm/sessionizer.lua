-- ~.config/wezterm/sessionizer.lua
local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

local fd = "/home/utilizador/.local/bin/fd"

local insertArgs = function(tbl, command, stdout, stderr, success)
    if not success then
        wezterm.log_error("Failed to run: " .. command .. " " .. stderr)
        return
    end

    for line in stdout:gmatch("([^\n]*)\n?") do
        local project = line:gsub("/.git.*$", "")
        local label = project
        local id = project:gsub(".*/", "")
        table.insert(tbl, { label = tostring(label), id = tostring(id) })
    end

end

M.toggle = function(window, pane)
    local projects = {}

    local success, stdout, stderr = wezterm.run_child_process({
        fd,
        "-HI",
        ".",
        "--max-depth=4",
        "--prune",
        os.getenv("HOME") .. "/find",
        os.getenv("HOME") .. "/Documents",
        os.getenv("HOME") .. "/Documents/HasLab",
        os.getenv("HOME") .. "/dotfiles/.config",
        os.getenv("HOME") .. "/dotfiles",
    })

    insertArgs(projects, "fd", stdout, stderr, success)

    local success, stdout, stderr = wezterm.run_child_process({
        "zoxide",
        "query",
        "-l",
    })

    insertArgs(projects, "zoxide", stdout, stderr, success)

    window:perform_action(
        act.InputSelector({
            action = wezterm.action_callback(function(win, _, id, label)
                if not id and not label then
                    wezterm.log_info("Cancelled")
                else
                    wezterm.log_info("Selected " .. label)
                    win:perform_action(
                        act.SwitchToWorkspace({ name = id, spawn = { cwd = label } }),
                        pane
                    )
                end
            end),
            fuzzy = true,
            title = "Select project",
            choices = projects,
        }),
        pane
    )
end

return M