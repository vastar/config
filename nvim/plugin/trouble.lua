vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/folke/trouble.nvim"
})
local trouble = require("trouble")
vim.keymap.set("n", "<leader>xx", function() trouble.toggle("diagnostics") end, { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", function() trouble.toggle({ mode = "diagnostics", filter = { buf = 0 } }) end, { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cs", function() trouble.toggle({ mode = "symbols", focus = false }) end, { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>cl", function() trouble.toggle({ mode = "lsp", focus = false, win = { position = "right" }}) end, { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>xL", function() trouble.toggle("loclist") end, { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", function() trouble.toggle("qflist") end, { desc = "Quickfix List (Trouble)" })
