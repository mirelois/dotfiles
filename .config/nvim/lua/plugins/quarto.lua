return {
    {
        "GCBallesteros/jupytext.nvim",
        opts = {
            custom_language_formatting = {
                python = {
                    extension = 'qmd',
                    style = 'quarto',
                    force_ft = 'quarto',
                },
                r = {
                    extension = 'qmd',
                    style = 'quarto',
                    force_ft = 'quarto',
                },
            },

        }
    },

    {
        'MeanderingProgrammer/markdown.nvim',
        ft = { "markdown", "quarto"},
        init = function()
            vim.g.mkdp_auto_start = 0
        end,
        name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'ixru/nvim-markdown',
        },
        opts = {
            file_types = { 'markdown', 'quarto' },
            heading = {
                -- Replaces '#+' of 'atx_h._marker'
                -- The number of '#' in the heading determines the 'level'
                -- The 'level' is used to index into the array using a cycle
                icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
            },
            bullet = {
                -- Turn on / off list bullet rendering
                enabled = true,
                -- Replaces '-'|'+'|'*' of 'list_item'
                -- How deeply nested the list is determines the 'level'
                -- The 'level' is used to index into the array using a cycle
                -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
                icons = { '●', '○', '◆', '◇' },
                -- Padding to add to the left of bullet point
                left_pad = 0,
                -- Padding to add to the right of bullet point
                right_pad = 0,
                -- Highlight for the bullet icon
                highlight = 'RenderMarkdownBullet',
            },
            code = {
                -- Turn on / off code block & inline code rendering
                enabled = true,
                -- Turn on / off any sign column related rendering
                sign = true,
                -- Determines how code blocks & inline code are rendered:
                --  none:     disables all rendering
                --  normal:   adds highlight group to code blocks & inline code, adds padding to code blocks
                --  language: adds language icon to sign column if enabled and icon + name above code blocks
                --  full:     normal + language
                style = 'full',
                -- Determines where language icon is rendered:
                --  right: right side of code block
                --  left:  left side of code block
                position = 'left',
                -- Amount of padding to add around the language
                language_pad = 0,
                -- An array of language names for which background highlighting will be disabled
                -- Likely because that language has background highlights itself
                disable_background = { 'diff' },
                -- Width of the code block background:
                --  block: width of the code block
                --  full:  full width of the window
                width = 'full',
                -- Amount of padding to add to the left of code blocks
                left_pad = 0,
                -- Amount of padding to add to the right of code blocks when width is 'block'
                right_pad = 0,
                -- Minimum width to use for code blocks when width is 'block'
                min_width = 0,
                -- Determins how the top / bottom of code block are rendered:
                --  thick: use the same highlight as the code body
                --  thin:  when lines are empty overlay the above & below icons
                border = 'thin',
                -- Used above code blocks for thin border
                above = '▄',
                -- Used below code blocks for thin border
                below = '▀',
                -- Highlight for code blocks
                highlight = 'RenderMarkdownCode',
                -- Highlight for inline code
                highlight_inline = 'RenderMarkdownCodeInline',
            },
            pipe_table = {
                -- Turn on / off pipe table rendering
                enabled = true,
                -- Pre configured settings largely for setting table border easier
                --  heavy:  use thicker border characters
                --  double: use double line border characters
                --  round:  use round border corners
                --  none:   does nothing
                preset = 'round',
                -- Determines how the table as a whole is rendered:
                --  none:   disables all rendering
                --  normal: applies the 'cell' style rendering to each row of the table
                --  full:   normal + a top & bottom line that fill out the table when lengths match
                style = 'full',
                -- Determines how individual cells of a table are rendered:
                --  overlay: writes completely over the table, removing conceal behavior and highlights
                --  raw:     replaces only the '|' characters in each row, leaving the cells unmodified
                --  padded:  raw + cells are padded to maximum visual width for each column
                --  trimmed: padded except empty space is subtracted from visual width calculation
                cell = 'trimmed',
                -- Minimum column width to use for padded or trimmed cell
                min_width = 0,
                -- Characters used to replace table border
                -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal
                -- stylua: ignore
                border = {
                    '┌', '┬', '┐',
                    '├', '┼', '┤',
                    '└', '┴', '┘',
                    '│', '─',
                },
                -- Gets placed in delimiter row for each column, position is based on alignmnet
                alignment_indicator = '━',
                -- Highlight for table heading, delimiter, and the line above
                head = 'RenderMarkdownTableHead',
                -- Highlight for everything else, main table rows and the line below
                row = 'RenderMarkdownTableRow',
                -- Highlight for inline padding used to add back concealed space
                filler = 'RenderMarkdownTableFill',
            },
        }
    },

    {
        'quarto-dev/quarto-nvim',
        ft = "quarto",
        dependencies = { 'jmbuhr/otter.nvim' },
        opts = {
            debug = true,
            closePreviewOnExit = false,
            lspFeatures = {
                enabled = true,
                chunks = "curly",
                languages = { "r", "python", "julia", "bash", "html" },
                diagnostics = {
                    enabled = true,
                    triggers = { "BufWritePost" },
                },
                completion = {
                    enabled = true,
                },
            },
            codeRunner = {
                enabled = true,
                default_method = 'slime', -- 'molten' or 'slime'
                ft_runners = {},          -- filetype to runner, ie. `{ python = "molten" }`.
                -- Takes precedence over `default_method`
                never_run = { "yaml" },   -- filetypes which are never sent to a code runner
            },

        },
        keys = {
            { "<c-cr>",     ":QuartoSend<CR>" },
            { "<s-cr>",     ":QuartoSend<CR>" },

            { "<leader>Q",  ":QuartoSendAll<CR>" },
            { "<leader>qa", ":QuartoSendAbove<CR>" },
            { "<leader>qb", ":QuartoSendBelow<CR>" },
            { "<leader>qq", ":QuartoSendLine<CR>" },
        },

        config = function(Specs, opts)
            vim.api.nvim_create_user_command("QuartoToJupyter", function()
                local cmd = "quarto convert " .. vim.api.nvim_buf_get_name(0)
                local out = vim.fn.system(cmd)
                print(out)
            end, {})

            vim.api.nvim_create_user_command("QuartoInit", function()
                local cmd = "kitty @launch --keep-focus --cwd=current ipython"
                vim.fn.system(cmd)
            end, {})

            local api = vim.api
            local ts = vim.treesitter

            vim.b.slime_cell_delimiter = '```'
            vim.b['quarto_is_r_mode'] = nil
            vim.b['reticulate_running'] = false

            -- wrap text, but by word no character
            -- indent the wrappped line
            vim.wo.wrap = false
            vim.wo.linebreak = true
            vim.wo.breakindent = true
            vim.wo.showbreak = '|'

            -- don't run vim ftplugin on top
            vim.api.nvim_buf_set_var(0, 'did_ftplugin', true)

            -- markdown vs. quarto hacks
            local ns = vim.api.nvim_create_namespace 'QuartoHighlight'
            vim.api.nvim_set_hl(ns, '@markup.strikethrough', { strikethrough = false })
            vim.api.nvim_set_hl(ns, '@markup.doublestrikethrough', { strikethrough = true })
            vim.api.nvim_win_set_hl_ns(0, ns)

            -- ts based code chunk highlighting uses a change
            -- only availabl in nvim >= 0.10
            if vim.fn.has 'nvim-0.10.0' == 0 then
                return
            end

            -- highlight code cells similar to
            -- 'lukas-reineke/headlines.nvim'
            -- (disabled in lua/plugins/ui.lua)
            local buf = api.nvim_get_current_buf()

            local parsername = 'markdown'
            local parser = ts.get_parser(buf, parsername)
            local tsquery = '(fenced_code_block)@codecell'

            -- vim.api.nvim_set_hl(0, '@markup.codecell', { bg = 'NONE' })
            vim.api.nvim_set_hl(0, '@markup.codecell', {
                link = 'RenderMarkdownCode',
            })

            local function clear_all()
                local all = api.nvim_buf_get_extmarks(buf, ns, 0, -1, {})
                for _, mark in ipairs(all) do
                    vim.api.nvim_buf_del_extmark(buf, ns, mark[1])
                end
            end

            local function highlight_range(from, to)
                for i = from, to do
                    vim.api.nvim_buf_set_extmark(buf, ns, i, 0, {
                        hl_eol = true,
                        line_hl_group = '@markup.codecell',
                    })
                end
            end

            local function highlight_cells()
                clear_all()

                local query = ts.query.parse(parsername, tsquery)
                local tree = parser:parse()
                local root = tree[1]:root()
                for _, match, _ in query:iter_matches(root, buf, 0, -1, { all = true }) do
                    for _, nodes in pairs(match) do
                        for _, node in ipairs(nodes) do
                            local start_line, _, end_line, _ = node:range()
                            pcall(highlight_range, start_line, end_line - 1)
                        end
                    end
                end
            end

            highlight_cells()

            vim.api.nvim_create_autocmd({ 'ModeChanged', 'BufWrite' }, {
                group = vim.api.nvim_create_augroup('QuartoCellHighlight', { clear = true }),
                buffer = buf,
                callback = highlight_cells,
            })
            
            require('quarto').setup(opts)
        end
    },

    {
        'jpalardy/vim-slime',
        ft = "quarto",
        dependencies = {
            '3rd/image.nvim',
            ft = "quarto",
            opts = {
                backend = "kitty",                        -- Kitty will provide the best experience, but you need a compatible terminal
                integrations = {},                        -- do whatever you want with image.nvim's integrations
                max_width = 1000,                         -- tweak to preference
                max_height = 12000,                       -- ^
                max_height_window_percentage = math.huge, -- this is necessary for a good experience
                max_width_window_percentage = math.huge,
                window_overlap_clear_enabled = true,
                window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },

            }
        },
        init = function()
            vim.b['quarto_is_python_chunk'] = false
            vim.g.slime_no_mappings = true
            vim.g.slime_target = "kitty"
            vim.g.slime_bracketed_paste = 0
            vim.g.slime_python_ipython = 1
        end,
        config = function()
            Quarto_is_in_python_chunk = function()
                require('otter.tools.functions').is_otter_language_context 'python'
            end

            vim.cmd [[
                      let g:slime_dispatch_ipython_pause = 100
                      function SlimeOverride_EscapeText_quarto(text)
                      call v:lua.Quarto_is_in_python_chunk()
                      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
                      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
                      else
                      if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
                      return [a:text, "\n"]
                      else
                      return [a:text]
                      end
                      end
                      endfunction
                      ]]
        end
    }


}
