-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Remove LazyVim default mappings
vim.api.nvim_del_keymap("n", "<C-h>")
vim.api.nvim_del_keymap("n", "<C-j>")
vim.api.nvim_del_keymap("n", "<C-k>")
vim.api.nvim_del_keymap("n", "<C-l>")

-- Add vim-tmux-navigator keybindings
map("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
map("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", { silent = true })
