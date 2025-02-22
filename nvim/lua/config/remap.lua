vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ split panes ]]
vim.keymap.set("n", "<leader>|", "<cmd>vs<CR>") -- vertical split
vim.keymap.set("n", "<leader>-", "<cmd>sp<CR>") -- horizontal split


-- [[ navigation ]]
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")         -- shift J to move line down in visual
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")         -- shift K to move line down in visual
vim.keymap.set("n", "J", "mzJ`z")                    -- Join current line with next, preserve cursor position
vim.keymap.set("n", "<C-d>", "<C-d>zz")              -- Jump down page
vim.keymap.set("n", "<C-u>", "<C-u>zz")              -- Jump up page
vim.keymap.set("n", "n", "nzzzv")                    -- n behavior with centering and visual store
vim.keymap.set("n", "N", "Nzzzv")                    -- N behavior with centering and visual store
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")     -- Jump to next item in quick fix list
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")     -- Jump to prev item in quick fix list
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz") -- Jump to prev item in location list
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz") -- Jump to prev item in location list

-- [[ clipboard and editing ]]
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- Yank to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])          -- Yank line to system clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])         -- Paste without overriding clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')   -- Delete without affecting clipboard
vim.keymap.set("i", "<C-c>", "<Esc>")              -- Maps Ctrl+C to also do ESC function
vim.keymap.set("n", "Q", "<nop>")                  -- unbind macro record button

-- [[ search and replace ]] (one of my favorites)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- search and replace

-- [[ file management ]]
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/<CR>")            -- edit nvim config
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- mod current file with execute permissions
-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/<CR>") -- edit dotfiles nvim config

-- [[ Go-Lang error handling and logging ]]
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")                                -- if err != nil { return err }
vim.keymap.set("n", "<leader>ea", 'oassert.NoError(err, "")<Esc>F";a')                                         -- assert.NoError(err, "")
vim.keymap.set("n", "<leader>ef", 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj') -- if err != nil { log.Fatalf("error: %s\n", err.Error()) }
vim.keymap.set("n", "<leader>el", 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i')  -- if err != nil { .logger.Error("error", "error", err) }

-- [[ LSP and formatting ]]
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format) -- format file

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
