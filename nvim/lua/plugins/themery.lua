return {
  "zaldih/themery.nvim",
  config = function()
    -- local themes = vim.fn.getcompletion("", "color")
    local themes = {
      "gruvbox",
      "bamboo",
      "catppuccin",
      "flow",
      "cyberdream",
      "tokyonight",
    }

    require("themery").setup({
      themes = themes,
      livePreview = true,
    })
  end,
}
