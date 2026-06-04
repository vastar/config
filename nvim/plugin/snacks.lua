vim.pack.add({"https://github.com/folke/snacks.nvim"})
require("snacks").setup({
  bigfile = {
    enabled = true,
    size = 512 * 1024,
    line_length = 250
  }
})
