return {
  "Mofiqul/vscode.nvim",
  opts = {
    transparent = true,
    disable_nvimtree_bg = true,
    terminal_colors = true,
    color_overrides = {
      vscCursorDarkDark = "#333333",
    },
  },
  config = function(_, opts)
    require("vscode").setup(opts)
    vim.cmd.colorscheme("vscode")
    vim.api.nvim_set_hl(0, "Normal", { bg = "None", ctermbg = "None" })
  end,
}
