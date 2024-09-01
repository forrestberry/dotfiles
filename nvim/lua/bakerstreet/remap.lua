-- Set space as leader keyjj
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })

vim.keymap.set('n', '<leader>q', vim.cmd.q, { noremap = true }) 
vim.keymap.set('n', '<leader>w', vim.cmd.w, { noremap = true }) 

vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Open file explorer' })
vim.keymap.set('n', '<leader>j', vim.cmd.Vex, { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>k', vim.cmd.Hex, { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>nh', vim.cmd.nohl, { desc = 'Clear highlights' })



-- removes need for ctrl w before ctrl j,k,l,h to jump windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>=', '<C-W>=', {desc = 'Equalize window sizes'})

