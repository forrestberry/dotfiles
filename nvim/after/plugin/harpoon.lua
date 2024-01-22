-- Remappings

vim.keymap.set('n', '<leader>hh', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>')
vim.keymap.set('n', '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<CR>')
vim.keymap.set('n', '<leader>hn', '<cmd>lua require("harpoon.ui").nav_next()<CR>')
vim.keymap.set('n', '<leader>hp', '<cmd>lua require("harpoon.ui").nav_prev()<CR>')
