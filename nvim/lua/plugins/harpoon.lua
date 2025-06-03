return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add current file to Harpoon list" })
    vim.keymap.set("n", "<C-m>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Toggle Harpoon quick menu" })

    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(1) end, { desc = "Select 1st Harpoon list item" })
    vim.keymap.set("n", "<C-e>", function() harpoon:list():select(2) end, { desc = "Select 2nd Harpoon list item" })
    vim.keymap.set("n", "<C-i>", function() harpoon:list():select(3) end, { desc = "Select 3rd Harpoon list item" })
    vim.keymap.set("n", "<C-o>", function() harpoon:list():select(4) end, { desc = "Select 4th Harpoon list item" })
  end,
}
