vim.pack.add({
  "https://github.com/rest-nvim/rest.nvim",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/j-hui/fidget.nvim",
})
vim.keymap.set("n", "<leader>rr", function() vim.cmd("Rest run") end, { desc = "Run request under the cursor" })
