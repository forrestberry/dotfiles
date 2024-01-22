vim.g.mapleader = ' '

vim.keymap.set('i', 'jk', '<esc>')

vim.keymap.set('n', '<leader>w', vim.cmd.w)
vim.keymap.set('n', '<leader>q', vim.cmd.q)
vim.keymap.set('n', '<leader>j', vim.cmd.Vex)
vim.keymap.set('n', '<leader>k', vim.cmd.Hex)
vim.keymap.set('n', '<leader>nh', vim.cmd.nohl)
vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

vim.keymap.set({'n', 'x'}, '<leader>c', '"+y', {desc = 'leader c to copy out of vim'})

vim.keymap.set('i', '<C-x><C-Space>', '<C-x><C-o>', {desc = 'omnifunc mapping'})

-- removes need for ctrl w before ctrl j,k,l,h to jump windows

vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
vim.keymap.set('n', '<leader>=', '<C-W>=', {desc = 'equalizes buffers in window'})

