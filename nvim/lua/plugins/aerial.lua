return {
  "stevearc/aerial.nvim",
  config = function()
    require("aerial").setup({
      disable_max_lines = math.huge,
      disable_max_size = math.huge,
      layout = { max_width = 40 },
      show_guides = true,
      filter_kind = false, -- Show all symbol types
    })
    vim.keymap.set("n", "<leader>pa", ":AerialToggle<CR>", { silent = true, desc = "Toggle Code Outline" })
  end
}
