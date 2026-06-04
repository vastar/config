vim.pack.add({
  "https://github.com/rest-nvim/rest.nvim",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/j-hui/fidget.nvim",
})
local rest = require("rest-nvim.request")
vim.keymap.set("n", "<leader>rr", rest.run, { desc = "Run request under the cursor" })
