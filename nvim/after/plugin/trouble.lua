-- Setup Trouble with default options
require("trouble").setup{
  modes = {
    test = {
      mode = "diagnostics",
      preview = {
        type = "split",
        relative = "win",
        position = "right",
        size = 0.3,
      },
    },
  },
}

-- Define keybindings
vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { noremap = true, silent = true, desc = 'Diagnostics (Trouble)' })

-- Keybinding to show diagnostics in a floating window for the current line
vim.api.nvim_set_keymap(
  'n',
  '<leader>ee',  -- Use <leader>ee to show error preview
  '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line" })<CR>', 
  { noremap = true, silent = true, desc = 'Show error preview for current line' }
)

