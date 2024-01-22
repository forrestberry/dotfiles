-- nuts and bolts
vim.opt.nu = true               -- adds line numbers
vim.opt.rnu = true              -- adds visual line numbers
vim.opt.cursorline = true	    -- adds full length line for cursor
vim.opt.wrap = false            -- long lines do not wrap
vim.opt.colorcolumn = '80'      -- highlight for PEP8 column
vim.opt.sidescroll = 12         -- sidescroll for long lines moves 12 characters
vim.opt.scrolloff = 12          -- keeps 12 lines visible when scrolling
vim.opt.mouse = ''              -- disable mouse in all modes

vim.opt.termguicolors = true


--search
vim.opt.ignorecase = true       -- remove case specific search
vim.opt.smartcase = true        -- override ignore case when capitals present

-- tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true        -- converts tabs to spaces
vim.opt.smartindent = true      -- tries to be smart about autoindenting

-- code folding                 -- turning off for now to see if I like it.
-- vim.opt.foldmethod = 'syntax'   -- allows folding based on code syntax
-- vim.opt.foldlevel = 99          -- opens all folds (up to level 99)
-- vim.g.markdown_folding = 1      -- allows markdown foldingkk
