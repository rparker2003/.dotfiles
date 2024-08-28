return {
  "NStefan002/donut.nvim",
  version = "*",
  lazy = false,
  config = function()
    require("donut").setup({
      timeout = 60,
      sync_donuts = false,
    })
  end,
}
