-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/utilizador/.cache/nvim/packer_hererocks/2.1.1713484068/share/lua/5.1/?.lua;/home/utilizador/.cache/nvim/packer_hererocks/2.1.1713484068/share/lua/5.1/?/init.lua;/home/utilizador/.cache/nvim/packer_hererocks/2.1.1713484068/lib/luarocks/rocks-5.1/?.lua;/home/utilizador/.cache/nvim/packer_hererocks/2.1.1713484068/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/utilizador/.cache/nvim/packer_hererocks/2.1.1713484068/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-calc"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/cmp-calc",
    url = "https://github.com/hrsh7th/cmp-calc"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["conform.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/conform.nvim",
    url = "https://github.com/stevearc/conform.nvim"
  },
  ["corn.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/corn.nvim",
    url = "https://github.com/RaafatTurki/corn.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  harpoon = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["image.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/image.nvim",
    url = "https://github.com/3rd/image.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["jupytext.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/jupytext.nvim",
    url = "https://github.com/GCBallesteros/jupytext.nvim"
  },
  ["kanagawa.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["kitty-scrollback.nvim"] = {
    commands = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21kitty-scrollback\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/opt/kitty-scrollback.nvim",
    url = "https://github.com/mikesmithgh/kitty-scrollback.nvim"
  },
  ["lsp-zero.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/lsp-zero.nvim",
    url = "https://github.com/VonHeikemen/lsp-zero.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown.nvim"] = {
    config = { "\27LJ\2\nw\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\15file_types\1\0\1\15file_types\0\1\3\0\0\rmarkdown\vquarto\nsetup\20render-markdown\frequire\0" },
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/markdown.nvim",
    url = "https://github.com/MeanderingProgrammer/markdown.nvim"
  },
  ["marks.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/marks.nvim",
    url = "https://github.com/chentoast/marks.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-markdown"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/nvim-markdown",
    url = "https://github.com/ixru/nvim-markdown"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-trevJ.lua"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/nvim-trevJ.lua",
    url = "https://github.com/AckslD/nvim-trevJ.lua"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["oil.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/oil.nvim",
    url = "https://github.com/stevearc/oil.nvim"
  },
  ["otter.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/otter.nvim",
    url = "https://github.com/jmbuhr/otter.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["quarto-nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/quarto-nvim",
    url = "https://github.com/quarto-dev/quarto-nvim"
  },
  ["rainbow-delimiters.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/rainbow-delimiters.nvim",
    url = "https://github.com/HiPhish/rainbow-delimiters.nvim"
  },
  ["smart-splits.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/smart-splits.nvim",
    url = "https://github.com/mrjones2014/smart-splits.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  undotree = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-kitty-navigator"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/vim-kitty-navigator",
    url = "https://github.com/knubie/vim-kitty-navigator"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-slime"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/vim-slime",
    url = "https://github.com/jpalardy/vim-slime"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/utilizador/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: markdown.nvim
time([[Config for markdown.nvim]], true)
try_loadstring("\27LJ\2\nw\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\15file_types\1\0\1\15file_types\0\1\3\0\0\rmarkdown\vquarto\nsetup\20render-markdown\frequire\0", "config", "markdown.nvim")
time([[Config for markdown.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'KittyScrollbackGenerateKittens', function(cmdargs)
          require('packer.load')({'kitty-scrollback.nvim'}, { cmd = 'KittyScrollbackGenerateKittens', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'kitty-scrollback.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('KittyScrollbackGenerateKittens ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'KittyScrollbackCheckHealth', function(cmdargs)
          require('packer.load')({'kitty-scrollback.nvim'}, { cmd = 'KittyScrollbackCheckHealth', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'kitty-scrollback.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('KittyScrollbackCheckHealth ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au User KittyScrollbackLaunch ++once lua require("packer.load")({'kitty-scrollback.nvim'}, { event = "User KittyScrollbackLaunch" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
