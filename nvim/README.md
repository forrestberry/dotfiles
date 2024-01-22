# TODO

- review undotree (https://github.com/mbbill/undotree)
- review LSP config (https://github.com/neovim/nvim-lspconfig)
- smart wrapping for .md files
- linting (do I really need/want)?
- autocomplete? copilot enough?
- folding based on treesitter

# Helpful documentation

- helpful documentation: :h lua-guide
- https://the-net-blog.netlify.app/post/configuring-neovim-with-lua-what-you-should-know/
- https://www.reddit.com/r/neovim/comments/x3zp6t/usage_of_afterftplugin_directory_for/
- https://github.com/echasnovski/nvim/tree/master/lua

# Packages/Plugins

I am using paq because it is a lightweight package manager.

*Can be useful fo know that the default place for install is:
.local/share/nvim/site/pack/plugins/start
:help packages*

# Plugins Currently Used

- Paq (https://github.com/savq/paq-nvim)
    - install first. The rest are added via PaqInstall
- Github Copilot (https://github.com/github/copilot.vim)
    - must have node installed
    - command Copilot setup to start working
    - command: Copilot tab to see options
    - help: Copilot help
- Treesitter (https://github.com/nvim-treesitter/nvim-treesitter)
    - command: TS tab to see options
    - added treesitter.lua for settings
- Harpoon (https://github.com/ThePrimeagen/harpoon)
    - shortcuts for Harpoon listed in remap.lua (all leader-h_)
- Plenary (https://github.com/nvim-lua/plenary.nvim)
    - dependency for Harpoon and Telescope
- Gruvbox (https://github.com/ellisonleao/gruvbox.nvim)
    - Color theme of choice
    - altered light background to color of solarized light theme
    - change theme by changing in terminal (light, dark)
    - added color.lua for settings
- LSP Config (https://github.com/neovim/nvim-lspconfig)
    - command: Lsp<tab>
    - simpler config for built-in LSP client
    - use for completions, linter, etc.
    - LSP Clients:
        - pyright 
            - https://github.com/microsoft/pyright
            - brew install pyright
- Telescope (https://github.com/nvim-telescope/telescope.nvim)
    - fuzzy finder for files
    - shortcuts for Telescope listed in remap.lua (all leader-f_)
    - brew install ripgrep for livegrep feature
- Undo Tree (https://github.com/mbbill/undotree)
    - visualize undo
    - command: leader u


