return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    require('telescope').setup({})

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Find Files" })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Git Files" })
    vim.keymap.set('n', '<leader>pws', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end, { desc = "Grep Current Word" })
    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end, { desc = "Grep Current WORD" })
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "Grep Custom String" })
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "View Help Tags" })

    vim.keymap.set("n", "<leader>pl", ":Telescope lsp_document_symbols<CR>", { desc = "List LSP symbols in file" })
    vim.keymap.set("n", "<leader>pL", ":Telescope lsp_workspace_symbols<CR>", { desc = "List LSP symbols in workspace" })

    vim.keymap.set("n", "<leader>pci", function()
      require('telescope.builtin').lsp_incoming_calls()
    end, { desc = "Show incoming calls (who calls this function)" })

        vim.keymap.set("n", "<leader>pco", function()
      require('telescope.builtin').lsp_outgoing_calls()
    end, { desc = "Show outgoing calls (functions this calls)" })
  end
}
