vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
})
local dotnet = require("easy-dotnet")
require("lualine").setup({
  options = {
    theme = "vscode"
  },
  sections = {
    lualine_a = { "mode", dotnet.lualine.jobs },
    lualine_x = { "rest", dotnet.lualine.active_project },
  }
})
