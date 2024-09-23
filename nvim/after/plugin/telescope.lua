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

-- Actions for inserting hugo links
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

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



-- Insert Hugo link with custom link title

-- Function to sanitize the filename for new files
local function sanitize_filename(filename)
  -- Convert to lowercase
  filename = filename:lower()
  -- Replace spaces and consecutive spaces with single dash
  filename = filename:gsub('%s+', '-')
  return filename
end


local function insert_hugo_link()
  local dir = vim.fn.expand('%:p:h') -- vim.fn.getcwd() Use for current directory when opening vim
  local opts = {
    prompt_title = 'Select a file to link',
    cwd = dir,
    previewer = true,
  }

  
  require('telescope.builtin').find_files({
    prompt_title = opts.prompt_title,
    cwd = opts.cwd,
    previewer = opts.previewer,
    attach_mappings = function(prompt_bufnr, map)
      local function insert_link()
        local picker = action_state.get_current_picker(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        local filename

        if entry == nil then
          -- If no entry is selected, use the prompt value
          filename = picker:_get_prompt()
        else
          filename = entry[1]
        end

        -- Close Telescope
        actions.close(prompt_bufnr)

        -- Ensure filename is not empty
        if filename == '' then
          vim.notify('No filename provided.', vim.log.levels.ERROR)
          return
        end

        filename = sanitize_filename(filename)

        -- Ensure the filename ends with '.md'
        if not filename:match('%.md$') then
          filename = filename .. '.md'
        end

        -- Construct the full file path
        local filepath = vim.fn.fnamemodify(opts.cwd .. '/' .. filename, ':p')

        -- Create any missing directories
        vim.fn.mkdir(vim.fn.fnamemodify(filepath, ':h'), 'p')

        -- Check if file exists, create if it doesn't
        if vim.fn.filereadable(filepath) == 0 then
          -- Create the file
          local file = io.open(filepath, 'w')
          if file then
            file:close()
            vim.notify('Created new file: ' .. filepath, vim.log.levels.INFO)
          else
            vim.notify('Error creating file: ' .. filepath, vim.log.levels.ERROR)
            return  -- Exit if file creation failed
          end
        end

        -- Prompt for custom link title
        local link_title = vim.fn.input('Enter link title: ', '')
        
        -- Handle empty link title
        if link_title == '' then
          link_title = filename
        end

        -- Prepare the Hugo link syntax
        local hugo_link = string.format('[%s]({{< ref "%s" >}})', link_title, filename)

        -- Get current cursor position
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))

        -- Adjust columns to zero-based indexing
        local start_col = math.max(col - 3, 0)  -- Subtract 3 to account for the length of '[['
        local end_col = col - 1  -- Subtract 1 to convert to zero-based indexing

        -- Remove the '[[', insert the Hugo link
        vim.api.nvim_buf_set_text(0, row - 1, start_col, row - 1, end_col, {hugo_link})

        -- Return to insert mode
        vim.cmd('startinsert')
      end

      -- Map <CR> to insert_link function
      actions.select_default:replace(insert_link)

      return true
    end,
  })
end

-- Map '[[` in insert mode to trigger insert_hugo_link function
vim.api.nvim_set_keymap('i', '[[', '', {
  noremap = true,
  callback = insert_hugo_link
})

-- === End Custom Functionality for Hugo Links ===


