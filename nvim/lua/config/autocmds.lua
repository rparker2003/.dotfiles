-- Create helper functions for autogroups and autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

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

-- Set up file type specific configs
autocmd("FileType", {
  group = format_group,
  pattern = "*",
  callback = function()
    local ext = vim.bo.filetype

    -- Disable trim trailing whitespace for C++ files (AMPS)
    if vim.b.trim_whitespace == nil then
      if ext == "cpp" or ext == "hpp" then
        vim.b.trim_whitespace = false
      else
        vim.b.trim_whitespace = true
      end
    end

    -- Auto set indentation for filetypes
    if ext == "python" then
      set_indent(4) -- call to set_indent in set.lua
    else
      set_indent(2)
    end
  end
})

-- Trim trailing whitespace before saving a file
autocmd({ "BufWritePre" }, {
  group = format_group,
  pattern = "*",
  callback = function()
    if vim.b.trim_whitespace then
      vim.cmd([[%s/\s\+$//e]])
    end
  end
})

-- Toggle trimming for current buffer
usercmd("TrimToggle", function()
  vim.b.trim_whitespace = not vim.b.trim_whitespace
  print("Trim trailing whitespace for this buffer: " .. (vim.b.trim_whitespace and "ON" or "OFF"))
end, {})

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
