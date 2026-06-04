vim.pack.add({"https://github.com/Mofiqul/vscode.nvim"})
require("vscode").setup({
  transparent = true,
  disable_nvimtree_bg = true,
  terminal_colors = true,
  color_overrides = {
    vscCursorDarkDark = "#333333"
  }
})
vim.cmd.colorscheme("vscode")
vim.api.nvim_set_hl(0, "Normal", { bg = "None", ctermbg = "None" })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "None" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "None" })
