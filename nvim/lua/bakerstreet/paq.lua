local paqs = {
    "savq/paq-nvim",            -- Let Paq manage itself

    "github/copilot.vim",       -- Copilot

    "ThePrimeagen/harpoon",     -- Quick Buffer Switcher

    -- Telescope
    { "nvim-telescope/telescope.nvim", branch='0.1.x' },
    {"nvim-telescope/telescope-fzf-native.nvim", build = 'make'},
    "nvim-telescope/telescope-ui-select.nvim",

    "nvim-lua/plenary.nvim",    -- Dependency for some packages

    -- Lazy loading setup for plugins
    { "folke/lazydev.nvim", opt = true, ft = "lua" },
    { "Bilal2453/luvit-meta", opt = true },

    -- Main LSP Configuration
    "neovim/nvim-lspconfig",

    -- LSP dependencies and configuration helpers
    { "williamboman/mason.nvim", config = function() require("mason").setup() end },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Status updates for LSP
    { "j-hui/fidget.nvim", config = function() require("fidget").setup {} end },

    -- Autocomplete capability extension for LSP
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",

    {
        "L3MON4D3/LuaSnip",
        build = function()
            if vim.fn.has("win32") == 0 and vim.fn.executable("make") == 1 then
                vim.cmd("!make install_jsregexp")
            end
        end,
    },
    { "saadparwaiz1/cmp_luasnip", opt = true },

    -- Additional Completion Sources for nvim-cmp
    { "hrsh7th/cmp-path", opt = true },
}

require "paq"(paqs)

-- Install Paq and packages if not already installed
-- h: paq-bootstrapping
local function clone_paq()
local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
if not is_installed then
  vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path }
  return true
end
end

local function bootstrap_paq(packages)
local first_install = clone_paq()
vim.cmd.packadd("paq-nvim")
local paq = require("paq")
if first_install then
  vim.notify("Installing plugins... If prompted, hit Enter to continue.")
  paq(packages)
  paq.clean()
  paq.update()
  paq.install()
end

end

-- Call helper function
bootstrap_paq(paqs)

