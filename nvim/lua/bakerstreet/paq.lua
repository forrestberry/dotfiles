local paqs = {
    "savq/paq-nvim",            -- Let Paq manage itself

    "github/copilot.vim",       -- Copilot

    "ThePrimeagen/harpoon",     -- Quick Buffer Switcher

    -- Telescope
    { "nvim-telescope/telescope.nvim", branch='0.1.x' },
    {"nvim-telescope/telescope-fzf-native.nvim", build = 'make'},
    "nvim-telescope/telescope-ui-select.nvim",

    -- LSP configs
    -- 'neovim/nvim-lspconfig',
    -- "williamboman/mason.nvim", -- note: must be loaded before dependants
    -- "williamboman/mason-lspconfig.nvim",
    -- "hrsh7th/nvim-cmp",
    -- "saadparwaiz1/cmp_luasnip",
    -- "hrsh7th/cmp-nvim-lsp",
    -- "hrsh7th/cmp-path",
    -- "nvim-treesitter/nvim-treesitter",

    "nvim-lua/plenary.nvim",    -- Dependency for some packages
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

