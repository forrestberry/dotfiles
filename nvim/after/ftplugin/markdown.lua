vim.opt.colorcolumn = ''  -- disable colorcolumn

-- Insert wiki link with custom link title

-- Actions for inserting wiki links
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

-- Function to sanitize the filename for new files
local function sanitize_filename(filename)
  -- Convert to lowercase
  filename = filename:lower()
  -- Replace spaces and consecutive spaces with single dash
  filename = filename:gsub('%s+', '-')
  return filename
end


local function insert_wiki_link()
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

        -- Prepare the wiki link syntax
        local wiki_link = string.format('[%s](%s)', link_title, filename)

        -- Get current cursor position
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))

        -- Adjust columns to zero-based indexing
        local start_col = math.max(col - 3, 0)  -- Subtract 3 to account for the length of '[['
        local end_col = col - 1  -- Subtract 1 to convert to zero-based indexing

        -- Remove the '[[', insert the wiki link
        vim.api.nvim_buf_set_text(0, row - 1, start_col, row - 1, end_col, {wiki_link})

        -- Return to insert mode
        vim.cmd('startinsert')
      end

      -- Map <CR> to insert_link function
      actions.select_default:replace(insert_link)

      return true
    end,
  })
end

-- Map '[[` in insert mode to trigger insert_wiki_link function
vim.api.nvim_set_keymap('i', '[[', '', {
  noremap = true,
  callback = insert_wiki_link
})

-- === End Custom Functionality for wiki Links ===



