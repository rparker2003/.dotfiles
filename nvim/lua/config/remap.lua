vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ panes ]]
vim.keymap.set("n", "<leader>|", "<cmd>vs<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>-", "<cmd>sp<CR>", { desc = "Horizontal split" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left pane" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right pane" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower pane" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper pane" })

-- [[ navigation ]]
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })
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

-- [[ search and replace ]] (one of my favorites, { desc = ""})
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Serach and replace word under cursor" })

-- [[ file management ]]
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/<CR>", { desc = "Edit neovim config" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }, { desc = "Make file executable" })

-- [[ Go-Lang error handling and logging ]]
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "Insert Go error check" })
vim.keymap.set("n", "<leader>ea", 'oassert.NoError(err, "")<Esc>F";a', { desc = "Insert Go assert.NoError" })
vim.keymap.set("n", "<leader>ef", 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj',
  { desc = "Insert Go fatal error log" })
vim.keymap.set("n", "<leader>el", 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i',
  { desc = "Insert Go structured error log" })

-- [[ LSP and formatting ]]
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format file with LSP" })

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = "Source current file" })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
