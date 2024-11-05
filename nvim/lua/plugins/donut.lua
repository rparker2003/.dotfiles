return {
  "NStefan002/donut.nvim",
  version = "*",
  lazy = false,
  config = function()
    require("donut").setup({
      timeout = 600, -- 10 minutes
      sync_donuts = false,
    })
  end,
}
