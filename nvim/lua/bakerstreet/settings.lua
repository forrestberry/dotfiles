-- Editor layout and visual settings
vim.cmd.colorscheme('darkblue')
-- tweak colorscheme (use h: highlight to see all groups)
vim.cmd [[
  highlight ColorColumn ctermbg=235
  highlight directory ctermfg=123
  highlight NonText ctermfg=9
  highlight cursorline ctermbg=235
  highlight Title cterm=underlinebold ctermfg=14
  highlight htmlH2 cterm=underline ctermfg=14
  highlight htmlH3 cterm=none ctermfg=14
]]

vim.opt.cursorline = true       -- highlight current line
vim.opt.signcolumn = "yes"      -- Keep signcolumn on by default
vim.opt.number = true           -- show line numbers
vim.opt.relativenumber = true   -- show relative line numbers
vim.opt.colorcolumn = '80'      -- highlight for PEP8 column


vim.opt.sidescroll = 12         -- sidescroll for long lines moves 12 charac--ters
vim.opt.scrolloff = 12          -- keeps 12 lines visible when scrolling

-- Indentation
--vim.opt.wrap = false          -- long lines do not wrap
vim.opt.breakindent = true      -- indents wrapped lines to preserve visual structure
vim.opt.linebreak = true        -- wrap long lines at characters in 'breakat'
vim.opt.showbreak = " └-"        -- visiual indicator for wrapped lines

vim.opt.tabstop = 4             -- number of spaces a tab counts for
vim.opt.softtabstop = 4         -- number of spaces to use for tab
vim.opt.shiftwidth = 4          -- number of spaces to use for autoindent
vim.opt.expandtab = true        -- converts tabs to spaces
vim.opt.smartindent = true      -- tries to be smart about autoindenting

-- Mouse
--vim.opt.mouse = ''              -- disable mouse in all modes
--vim.opt.mouse = "a"             -- enable mouse in all modes

-- Search
vim.opt.ignorecase = true       -- remove case specific search
vim.opt.smartcase = true        -- override ignore case when capitals present
vim.opt.hlsearch = true        -- highlight search results, clear on <Esc>

-- Clipboard
vim.opt.clipboard = "unnamedplus"  -- sync with system clipboard
-- vim.keymap.set({'n', 'x'}, '<leader>c', ''+y', {desc = 'Copy to OS Clipboard'})



-- Experimental from kickstart.nvim

vim.opt.undofile = true
-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = tru  
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }


-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Highlight when yanking text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

