return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter-context" },
  build = ":TSUpdate",
  lazy = false,
  config = function()
      local parsers = {
        "vimdoc",
        "javascript",
        "typescript",
        "c",
        "cpp",
        "python",
        "java",
        "lua",
        "json",
        "markdown",
        "bash",
      }

    require("nvim-treesitter").install(parsers)

    -- Toggle treesitter context on and off
    vim.keymap.set("n", "<leader>tc", function()
      require("treesitter-context").toggle()
    end, { silent = true, desc = "Toggle Treesitter Context" })
  end,
}
