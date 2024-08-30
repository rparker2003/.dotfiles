return {
  -- BUG need to make this transparent for transparent themes
  "folke/drop.nvim",
  event = "VimEnter",
  config = function()
    require("drop").setup({
      max = 100,
      screensaver = false,
    })
  end,
}
