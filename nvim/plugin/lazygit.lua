vim.pack.add({"https://github.com/kdheepak/lazygit.nvim"})
local lazygit = require("lazygit")
vim.keymap.set("n", "<leader>lg", function() lazygit.lazygit() end, { desc = "LazyGit" })
