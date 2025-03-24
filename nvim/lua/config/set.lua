-- [[ UI Settings]]
vim.opt.termguicolors = true  -- use terminal colors for gui

vim.opt.nu = true             -- show line nums
vim.opt.relativenumber = true -- show relative line nums
vim.opt.scrolloff = 8         -- scroll when 8 lines away from edge

vim.opt.cursorline = true     -- highlight line where cursor is located
vim.opt.signcolumn = "yes"    -- always enable sign column to left of nums
vim.opt.wrap = false          -- let lines wrap to next line

vim.opt.guicursor = ""        -- disable cursor shape changen in insert/visual

-- [[ Indentation Settings ]]
_G.set_indent = function(width) -- Global set indent function, called by autocmds.lua
  vim.opt.shiftwidth = width    -- number of spaces for auto-indent
  vim.opt.tabstop = width       -- number of spaces that a tab char represents
  vim.opt.softtabstop = width   -- number of spaces used for tab completion
end

vim.opt.expandtab = true   -- expand tabs into spaces

vim.opt.smartindent = true -- enable smart indent
vim.opt.breakindent = true -- enable automatic wrapping of indented lines

-- [[ File Handling ]]
vim.opt.swapfile = false                               -- Disable swap files
vim.opt.backup = false                                 -- Dispable backups
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Set undo dir
vim.opt.undofile = true                                -- Enable persistend undo

-- [[ Seach Settings ]]
vim.opt.hlsearch = false -- disable highlithing of search matches
vim.opt.incsearch = true -- enable incremental search

-- Case-insensitive searching UNLESS \C or 1+ capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- [[ General Settings ]]
vim.opt.mouse = "a"      -- enable mouse mode

vim.opt.showmode = false -- dont show mode, we show it in status line

-- [[ Split Settings ]]
vim.opt.splitright = true
vim.opt.splitbelow = true

-- [[ Whitespace & Display Settings ]]
vim.opt.list = true -- show all whitespacechars
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- change char icons

vim.opt.inccommand = "split" -- preview substitutions live

-- [[ Nerd Font Support ]]
vim.g.have_nerd_font = true -- enable if nerd font installed

-- [[ Time & Performance Settings ]]
vim.opt.updatetime = 50  -- update time for various operations (in ms)
vim.opt.timeoutlen = 300 -- decreased map sequence wait time (in ms)

-- [[ Miscellaneous ]]
vim.opt.isfname:append("@-@") -- ensure file names can contain chars like @-@
