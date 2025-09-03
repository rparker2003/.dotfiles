vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ panes ]]
vim.keymap.set("n", "<leader>|", "<cmd>vs<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>-", "<cmd>sp<CR>", { desc = "Horizontal split" })

-- [[ navigation ]]
vim.keymap.set("v", "J", ":move '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected line down" })
vim.keymap.set("v", "K", ":move '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected line up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result" })
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<CR>zz", { desc = "Quickfix next" })
vim.keymap.set("n", "<leader>qp", "<cmd>cprev<CR>zz", { desc = "Quickfix prev" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Location list next" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Location list prev" })

-- [[ clipboard and editing ]]
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without affecting register" })
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Ctrl+C as Esc in insert mode" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex Mode" })

vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true, desc = "Outdent and stay in visual mode" })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true, desc = "Indent and stay in visual mode" })

-- inc/dec remap in normal/v-block modes
vim.api.nvim_set_keymap('n', '<C-i>', '<C-a>', { noremap = true, silent = true }) -- C-a conflicts with tmux
vim.api.nvim_set_keymap('x', '<C-i>', '<C-a>', { noremap = true, silent = true }) -- C-a conflicts with tmux
vim.api.nvim_set_keymap('n', '<C-x>', '<C-x>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<C-x>', '<C-x>', { noremap = true, silent = true })

-- [[ search and replace ]] (one of my favorites, { desc = ""})
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace word under cursor" })

-- [[ file management ]]
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/<CR>", { desc = "Edit neovim config" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- [[ AMPS Logging ]]
vim.keymap.set("n", "<leader>la", function()
  local indent = string.rep(" ", vim.fn.indent("."))
  local logger = {
    indent .. 'amps_logger::LOG("%d %s",',
    indent .. '                 __LINE__,',
    indent .. '                 __func__);',
  }
  vim.fn.append(vim.fn.line("."), logger)
  vim.cmd("normal! j==") -- move cursor to first line of log and auto-indent
end, { desc = "Insert formatted AMPS logger" })
vim.keymap.set("n", "<leader>lA",
  'oamps_logger::LOG("%d %s - %s", __LINE__, __func__, strrchr(__FILE__, \'/\') + 1);<Esc>',
  { desc = "Insert AMPS Logger (DETAILED)" })

-- [[ LSP and formatting ]]
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format file with LSP" })
vim.keymap.set("v", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format selected content with LSP" })

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = "Source current file" })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Switch between .hpp and .cpp file counterparts
vim.keymap.set("n", "<leader>h", function()
  local current_file = vim.fn.expand('%:p') -- Get the full path of the current file
  local switch_file

  -- Check if we're in a .cpp or .hpp file and toggle accordingly
  if current_file:match("%.cpp$") then
    switch_file = current_file:gsub("%.cpp$", ".hpp")
  elseif current_file:match("%.hpp$") then
    switch_file = current_file:gsub("%.hpp$", ".cpp")
  else
    print("Not a .cpp or .hpp file!")
    return
  end

  -- Check if the corresponding file exists
  if vim.fn.filereadable(switch_file) == 1 then
    vim.cmd("e " .. switch_file)
  else
    print("No corresponding file found!")
  end
end, { desc = "Toggle between .cpp and .hpp files" })


-- Build Keymap, looks towards root from current file for 'build' dir and runs make install in it
vim.keymap.set('n', '<C-g>', function()
  -- Check if the current buffer has unsaved changes
  if vim.bo.modified then
    print('Error: Save your changes before running the build command.')
    return
  end

  -- Look up from cwd
  local function find_build_dir()
    local cwd = vim.fn.getcwd()
    local path = cwd
    while path ~= '/' do
      local build_path = path .. '/build'
      if vim.fn.isdirectory(build_path) == 1 then
        return build_path
      end
      path = vim.fn.fnamemodify(path, ':h')
    end
    return nil
  end

  local build_dir = find_build_dir()
  if not build_dir then
    print('No build directory found')
    return
  end

  -- Save current window before opening the terminal
  local original_win = vim.api.nvim_get_current_win()

  local cmd = 'make -j $(nproc) install'
  vim.cmd('botright split | resize 10 | terminal')

  -- Get terminal buffer and window
  local term_win = vim.api.nvim_get_current_win()

  -- Function to auto-scroll without inserting
  local function auto_scroll()
    if vim.api.nvim_win_is_valid(term_win) then
      vim.api.nvim_win_call(term_win, function()
        vim.cmd('normal! G') -- Scroll to bottom
      end)
    end
  end

  -- Run the make command
  vim.fn.chansend(vim.b.terminal_job_id,
    'cd ' .. build_dir .. ' && ' .. cmd .. ' && exit || read -p "Press enter to continue..."\n')

  -- Switch back to the original window
  vim.api.nvim_set_current_win(original_win)

  -- Periodically scroll without switching focus
  vim.defer_fn(function()
    auto_scroll()
  end, 100)
end, { noremap = true, silent = true })

-- Toggle relative lines on or off
vim.keymap.set("n", "<leader>rl", function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle relative line nums." })

-- AMPS Client Code snippets
local snippets = require("config.snippets")

vim.keymap.set("n", "<leader>Sa", function()
  vim.api.nvim_put(snippets['amps_config'], "l", true, true)
end, { desc = "AMPS Config Snippet" })

vim.keymap.set("n", "<leader>Sc", function()
  vim.api.nvim_put(snippets['cpp'], "l", true, true)
end, { desc = "C++ AMPS Snippet" })

vim.keymap.set("n", "<leader>Sp", function()
  vim.api.nvim_put(snippets['python'], "l", true, true)
end, { desc = "Python AMPS Snippet" })
