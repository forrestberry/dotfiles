--[[
require('telekasten').setup({
  -- See settings at :h telekasten.configuration
  home = vim.fn.expand("/Users/forrest/Documents/notes"),
  bible = vim.fn.expand("/Users/forrest/Documents/notes/bible"),
  templates = vim.fn.expand("/Users/forrest/Documents/notes/templates"),
  template_new_note = vim.fn.expand("/Users/forrest/Documents/notes/templates/template.md"),
  image_subdir = vim.fn.expand("/Users/forrest/Documents/notes/attachments"),
  tag_notation = "yaml-bare",
  media_previewer = "viu",

})

-- Keymaps
vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")
vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_templated_note<CR>")
vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_freinds<CR>")
vim.keymap.set("n", "<leader>zi", "<cmd>Telekasten paste_img_and_link<CR>")
vim.keymap.set("n", "<leader>zp", "<cmd>Telekasten preview_img<CR>")
vim.keymap.set("n", "<leader>zy", "<cmd>Telekasten yank_notelink<CR>")

vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")
]]--

--[[
 nnoremap <leader>zi :lua require('telekasten').paste_img_and_link()<CR>
 nnoremap <leader>zb :lua require('telekasten').show_backlinks()<CR>
 nnoremap <leader>zI :lua require('telekasten').insert_img_link({ i=true })<CR>
 nnoremap <leader>zp :lua require('telekasten').preview_img()<CR>
 nnoremap <leader># :lua require('telekasten').show_tags()<CR>

 ]]--
