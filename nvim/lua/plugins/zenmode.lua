return {
  "folke/zen-mode.nvim",
  config = function()
    -- fullscreen current pane
    vim.keymap.set("n", "<leader>zz", function()
      require("zen-mode").setup {
        window = {
          width = 1.0,
          options = {}
        },
      }
      require("zen-mode").toggle()
      vim.wo.wrap = false
      vim.wo.number = true
      vim.wo.rnu = true
      ColorMyPencils()
    end, { desc = "Toggle Zen Mode (max width, line numbers)" })


    vim.keymap.set("n", "<leader>zZ", function()
      require("zen-mode").setup {
        window = {
          width = 0.5,
          options = {}
        },
      }
      require("zen-mode").toggle()
      vim.wo.wrap = false
      vim.wo.number = true
      vim.wo.rnu = true
      ColorMyPencils()
    end, { desc = "Toggle Zen Mode (50% width)" })
  end
}
