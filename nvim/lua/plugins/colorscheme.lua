return {
  -- Add the Gruvbox theme plugin
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to use Gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
