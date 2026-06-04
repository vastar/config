vim.pack.add({
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/nvim-neotest/nvim-nio",
})
local dapui = require("dapui")
dapui.setup()
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle debug user interface" })
