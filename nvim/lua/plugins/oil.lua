return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional, for file icons
  config = function()
    require("oil").setup({
      default_file_explorer = true, -- Replace netrw with Oil
      columns = { "icon" }, -- Show icons in Oil
      keymaps = {
        ["q"] = "actions.close",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        [".."] = "actions.parent", -- Go up a directory
        ["_"] = "actions.open_cwd", -- Open current directory
        ["g?"] = "actions.show_help",
      },
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 2,
        max_width = 80,
        border = "rounded",
      },
    })

    -- Global Keymaps for Oil
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil File Explorer" }) -- Press `-` to open Oil
  end,
}

