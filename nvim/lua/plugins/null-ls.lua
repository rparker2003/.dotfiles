return {
  -- when lsp is null, this bypasses it and passed in the formatter
  "jose-elias-alvarez/null-ls.nvim",

  config = function ()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.autopep8,
      },
    })
  end
}
