require('telescope').setup{ 
    defaults = { 
        layout_strategy = 'vertical',
        layout_config = { 
            height = 0.95, 
            width = 0.95 
        }, 
    extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
    }, 
}


-- Enable Telescope extensions 
require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')


-- Keymaps for Builtins
local builtin = require('telescope.builtin')    -- see h: telescope.builtin

vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "[F]ind [F]iles"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "[F]ind [G]rep"})
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind [W]ord under cursor" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = "[F]ind [B]uffers"})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = "[F]ind [H]elp"})
vim.keymap.set("n", "<leader>fa", builtin.resume, { desc = "[F]ind [A]gain (Resumes the previous search" })
vim.keymap.set("n", "<leader>ft", builtin.builtin, { desc = "[F]ind [T]elescope Builtin options" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = '[Find] [R]ecently Opened Files' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })

vim.keymap.set("n", "<leader>/", function()
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        previewer = false,
    }))
        end, { desc = "[/] Fuzzily search in current buffer" })

--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>fo", function()
    builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
    })
end, { desc = "[F]ind in [O]pen Files" })

-- Function to find file under cursor (handling wiki-style links)
local function find_file_under_cursor()
  -- Get the word under the cursor, handling wiki-style links
  local word = vim.fn.expand('<cWORD>')
  -- Remove surrounding [[ and ]] if they exist
  word = word:gsub('^%[%[', ''):gsub('%]%]$', '')
  -- Call Telescope's find_files with the word as the default text
  require('telescope.builtin').find_files({ default_text = word })
end

vim.keymap.set('n', '<leader>fl', find_file_under_cursor, { desc = '[f]ind [l]inked file under cursor' })



