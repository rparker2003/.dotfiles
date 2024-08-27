return {
  "zaldih/themery.nvim",
  config = function()
    require("themery").setup({
      themes = { "gruvbox", "bamboo", "catppuccin", "flow" },
      livePreview = true,
    })
  end,
}
