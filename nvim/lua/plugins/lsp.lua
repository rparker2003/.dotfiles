return {
  "neovim/nvim-lspconfig",
  --------------------------------------------------------------------
  -- DEPENDENCIES
  -- Each plugin here fills a very specific role in the editor stack:
  --------------------------------------------------------------------
  dependencies = {
    -- Installs external tools (LSP servers, formatters, linters)
    "williamboman/mason.nvim",

    -- Formatting engine (we explicitly control formatting here)
    "stevearc/conform.nvim",

    -- Completion system (autocomplete UI)
    "hrsh7th/nvim-cmp",

    -- Bridges LSP → completion engine
    "hrsh7th/cmp-nvim-lsp",

    -- Snippet engine (expands code templates)
    "L3MON4D3/LuaSnip",

    -- Bridges snippets → completion engine
    "saadparwaiz1/cmp_luasnip",

    -- Shows LSP status (progress, indexing, etc.)
    "j-hui/fidget.nvim",

    -- Completion for words in Buffer
    "hrsh7th/cmp-buffer",
  },

  config = function()
    ------------------------------------------------------------------
    -- CORE
    ------------------------------------------------------------------
    require("mason").setup()
    require("fidget").setup()

    local conform = require("conform")
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")

    -- This tells LSP servers that we support cmp capabilities
    -- (so autocomplete works correctly with LSP suggestions)
    local capabilities = cmp_lsp.default_capabilities()

    ------------------------------------------------------------------
    -- FORMATTING LAYER (CONFORM)
    --
    -- Important design choice:
    -- We do NOT rely on LSP formatting because it is inconsistent
    -- across languages and servers.
    --
    -- Instead:
    -- - Python → autopep8 via conform
    -- - C/C++ → handled manually or by ccls if needed
    ------------------------------------------------------------------
    ------------------------------------------------------------------
    conform.setup({
      formatters_by_ft = {
        python = { "autopep8" }, -- your preference preserved

        -- Explicitly disable auto-formatting for C/C++
        -- (prevents unexpected full-file rewrites)
        -- TODO: Implement allman google style formatting
        cpp = {},
        c = {},
      },
      formatters = {
        ["clang-format"] = {
          -- append_args = { "--style={BasedOnStyle: Google, BreakBeforeBraces: Allman}" },
          append_args = {
            "--style={BasedOnStyle: LLVM, IndentWidth: 2, UseTab: Never, BreakBeforeBraces: Allman, PointerAlignment: Left, AllowShortIfStatementsOnASingleLine: false, AllowShortFunctionsOnASingleLine: None, AllowShortLoopsOnASingleLine: false, AllowShortBlocksOnASingleLine: Never}",
          },
        },
      },

      -- We disable format-on-save to prevent:
      -- - large unexpected rewrites
      -- - conflicts between formatters
      -- - disruption during small edits
      format_on_save = false
    })

    ------------------------------------------------------------------
    -- LSP CONFIGURATION (MODERN API)
    --
    -- Each LSP provides:
    -- - diagnostics (errors/warnings)
    -- - autocomplete suggestions
    -- - go-to-definition
    ------------------------------------------------------------------

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }, -- avoid false "vim is undefined"
          },
        },
      },
    })

    vim.lsp.config("ruff", {
      capabilities = capabilities,
    })

    vim.lsp.config("bashls", {
      capabilities = capabilities,
    })

    vim.lsp.config("biome", {
      capabilities = capabilities,
    })

    ------------------------------------------------------------------
    -- C / C++ LANGUAGE SERVER (ccls)
    --
    -- NOTE:
    -- ccls provides:
    -- - code navigation
    -- - diagnostics
    -- - indexing
    --
    -- Alternative is clangd (more modern, more widely used)
    ------------------------------------------------------------------
    vim.lsp.config("ccls", {
      capabilities = capabilities,
      init_options = {
        cache = { directory = ".ccls-cache" },
        highlight = { lsRanges = true },
        compilationDatabaseDirectory = "build",
      },
    })

    ------------------------------------------------------------------
    -- ENABLE LSP SERVERS
    ------------------------------------------------------------------
    vim.lsp.enable({
      "lua_ls",
      "ruff",
      "bashls",
      "biome",
      "ccls",
    })

    ------------------------------------------------------------------
    -- AUTOCOMPLETION (CMP)
    --
    -- This is your IntelliSense system:
    -- It collects suggestions from:
    -- - LSP servers
    -- - snippets
    -- - buffer text
    ------------------------------------------------------------------
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = {
        { name = "nvim_lsp" }, -- LSP suggestions
        { name = "luasnip" },  -- snippet suggestions
        { name = "buffer" },   -- words from open files
      },
    })

    ------------------------------------------------------------------
    -- DIAGNOSTICS UI
    ------------------------------------------------------------------
    vim.diagnostic.config({
      float = {
        border = "rounded",
        source = "always",
      },
    })
  end,
}
