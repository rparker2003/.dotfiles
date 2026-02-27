return {
  -- when lsp is null, this bypasses it and passed in the formatter
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },

  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Python
        require("none-ls.formatting.autopep8"),
      },
    })
  end
}
