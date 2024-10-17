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
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })

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
  -- Get the current line and cursor position
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.') -- cursor column (1-based)

  local function get_word_at_pos(line, pos)
    local s = pos
    local e = pos
    -- Expand to the left
    while s > 1 and line:sub(s - 1, s - 1):match('[%w_-]') do
      s = s - 1
    end
    -- Expand to the right
    while e <= #line and line:sub(e, e):match('[%w_-]') do
      e = e + 1
    end
    -- Extract the word
    return line:sub(s, e - 1)
  end

  local word = get_word_at_pos(line, col)
  -- Call Telescope's find_files with the word as the default text
  require('telescope.builtin').find_files({ default_text = word })
end


vim.keymap.set('n', '<leader>fl', find_file_under_cursor, { desc = '[f]ind [l]inked file under cursor' })



