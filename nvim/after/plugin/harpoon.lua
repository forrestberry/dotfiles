vim.keymap.set('n', '<leader>hh', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', { desc = "Show Harpoon" })
vim.keymap.set('n', '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<CR>', { desc = "Add current buffer to Harpoon" })
vim.keymap.set('n', '<leader>hn', '<cmd>lua require("harpoon.ui").nav_next()<CR>', { desc = "Go to next to Harpoon buffer" })
vim.keymap.set('n', '<leader>hp', '<cmd>lua require("harpoon.ui").nav_prev()<CR>', { desc = "Go to previous Harpoon buffer" })
