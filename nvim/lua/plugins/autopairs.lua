return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true,                  -- Use treesitter for smarter pairing
      enable_check_bracket_line = true, -- Don't add a pair if it’s already closed
      map_cr = true,                    -- Auto-wrap `{}` and `[]` properly on Enter
      fast_wrap = {},
    })
  end,
}
