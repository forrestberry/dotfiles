vim.g.copilot_filetypes = {
    --['*'] = false,
    ['markdown'] = false,
    ['text'] = false,

}

vim.g.copilot_no_tab_map = true -- Disable the tab for Copilot

vim.keymap.set('i', '<C-y>', 'copilot#Accept()', {
  expr = true,
  replace_keycodes = false,
  desc = "[A]ccept Copilot Suggestion"
})

vim.keymap.set('i', '<C-r>', '<plug>(copilot-dismiss)', { desc = "[R]eject copilot suggestion" })

vim.keymap.set('i', '<C-n>', '<plug>(copilot-next)', { desc = "Cycle to [n]ext copilot suggestion" })

vim.keymap.set('i', '<C-p>', '<plug>(copilot-previous)', { desc = "Cycle to previous[N] copilot suggestion" })

vim.keymap.set('i', '<C-w>', '<plug>(copilot-accept-word)', { desc = "Copilot: Accept [W]ord" })

vim.keymap.set('i', '<C-l>', '<plug>(copilot-accept-line)', { desc = "Copilot: Accept [L]ine" })
