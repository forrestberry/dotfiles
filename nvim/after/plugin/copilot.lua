vim.g.copilot_filetypes = {
    ['*'] = false,
}

-- ctrl [ and ] to cycle thru completions, ctrl \ for dismiss
vim.keymap.set('i', '<C-[>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-]>', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-dismiss)')
vim.keymap.set('i', '<C-Space>', '<Plug>(copilot-suggest)')
