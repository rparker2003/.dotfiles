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

-- Set up file type specific configs
autocmd("FileType", {
  group = format_group,
  pattern = "*",
  callback = function()
    local ft = vim.bo.filetype

    local ft_excludes = {
      cpp = true,
      hpp = true,
      gitcommit = true,
      gitrebase = true,
      gitconfig = true,
      markdown = true,  -- trailing spaces can be meaningful
      text = true,      -- trailing spaces can be meaningful
    }

    -- Disable trim trailing whitespace for C++ files (AMPS)
    if vim.b.trim_whitespace == nil then
      vim.b.trim_whitespace = not ft_excludes[ft]
    end

    -- Auto set indentation for filetypes
    if ft == "python" then
      set_indent(4) -- call to set_indent in set.lua
    else
      set_indent(2)
    end

    -- Treesitter
    local lang = vim.treesitter.language.get_lang(ft)
    if not lang or lang == "html" then
      return
    end

    local max_filesize = 100 * 1024
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > max_filesize then
      vim.notify(
        "File larger than 100KB treesitter disabled for performance",
        vim.log.levels.WARN,
        { title = "Treesitter" }
      )
      return
    end

    pcall(vim.treesitter.start)
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

-- Set up keymaps when LSP atatches to a buffer
autocmd("LspAttach", {
  group = lsp_group,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_prev()
    end, { buffer = e.buf, desc = "GoTo Prev Diagnostic"})
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_next()
    end, { buffer = e.buf, desc = "GoTo Next Diagnostic"})
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

-- Set inactive buffer color
autocmd({ "WinEnter", "WinLeave", "BufEnter" }, {
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_get_current_win() == win then
        vim.api.nvim_win_set_option(win, 'winhighlight', 'Normal:Normal')
      else
        vim.api.nvim_set_hl(0, 'NormalNC', { bg = "#0e0e12" })
      end
    end
  end,
})
