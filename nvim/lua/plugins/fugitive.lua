return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })

    local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
      group = ThePrimeagen_Fugitive,
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<leader>p", function()
          vim.cmd.Git('push')
        end, opts, { desc = "Git Push" })

        -- rebase always
        vim.keymap.set("n", "<leader>P", function()
          vim.cmd.Git({ 'pull', '--rebase' })
        end, opts, { desc = "Git Pull (Rebase)" })

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts, { desc = "Git Set Push Branch" });
      end,
    })


    vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", { desc = "Git Diff Left" })
    vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { desc = "Git Diff Right" })

    vim.keymap.set("n", "<leader>gf", function()
      vim.cmd("vertical Git log --stat -- " .. vim.fn.expand("%:p"))
    end, { desc = "Git Log Stats on File" })
  end
}
