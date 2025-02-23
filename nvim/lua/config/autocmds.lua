-- Create helper functions for autogroups and autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Define custom autogroups
local yank_group = augroup("HighlightYank", {})
local restore_group = augroup("RestoreCursor", {})
local format_group = augroup("CodeFormatting", {})
local lsp_group = augroup("LspConfig", {})

-- Function to reload plenary
function R(name)
  require("plenary.reload").reload_module(name)
end

-- Highlight text when yanking
autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- Trim trailing whitespace before saving a file
autocmd({ "BufWritePre" }, {
  group = format_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Set up keymaps when LSP atatches to a buffer
autocmd("LspAttach", {
  group = lsp_group,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>vws", function()
      vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
      vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "<leader>vca", function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>vrr", function()
      vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>vrn", function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_prev()
    end, opts)
  end,
})

-- Restore cursor position when reopening a file
autocmd("BufReadPost", {
  group = restore_group,
  callback = function()
    local last_line = vim.fn.line("'\"")
    local total_lines = vim.fn.line("$")
    if last_line > 1 and last_line <= total_lines then
      vim.cmd("normal! g`\"")
      vim.fn.timer_start(1, function() vim.cmd("normal! zz") end)
    end
  end,
})
