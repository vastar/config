vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/j-hui/fidget.nvim",

  "https://github.com/Mofiqul/vscode.nvim",

  "https://github.com/kylechui/nvim-surround",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/NMAC427/guess-indent.nvim",
  "https://github.com/lukas-reineke/indent-blankline.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/esmuellert/codediff.nvim",

  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",

  "https://github.com/nvim-lualine/lualine.nvim",

  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/neovim/nvim-lspconfig",

  "https://github.com/hat0uma/csvview.nvim",
  "https://github.com/rest-nvim/rest.nvim",
  "https://github.com/GustavEikaas/easy-dotnet.nvim",

  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
})

require("vscode").setup({
  transparent = true,
  disable_nvimtree_bg = true,
  terminal_colors = true,
  color_overrides = {
    vscCursorDarkDark = "#333333"
  }
})
vim.cmd.colorscheme("vscode")

require("nvim-autopairs").setup()
require("guess-indent").setup()
require("ibl").setup()
require("which-key").setup({
  delay = function(ctx)
    return ctx.plugin and 0 or 500
  end
})
require("snacks").setup({
  bigfile = {
    enabled = true,
    size = 512 * 1024,
    line_length = 250
  },
  lazygit = {},
})

require("nvim-treesitter").install({
  "bash",
  "c",
  "c_sharp",
  "cmake",
  "cpp",
  "css",
  "dockerfile",
  "dtd",
  "ecma",
  "fsharp",
  "git_config",
  "go",
  "html",
  "http",
  "java",
  "javascript",
  "json",
  "lua",
  "markdown",
  "nu",
  "python",
  "rust",
  "scss",
  "sql",
  "toml",
  "typescript",
  "xml",
  "yaml",
  "zsh",
})

require("csvview").setup({
  view = {
    display_mode = "border"
  }
})

local dotnet = require("easy-dotnet")
dotnet.setup()

require("dapui").setup()

local telescope = require("telescope")
telescope.setup({
  defaults = {
    file_ignore_patterns = { "bin/*", "obj/*", "node_modules/*" },
  }
})
telescope.load_extension("rest")

require("lualine").setup({
  options = {
    theme = "vscode"
  },
  sections = {
    lualine_a = { "mode", dotnet.lualine.jobs },
    lualine_x = { dotnet.lualine.active_project, "rest", "lsp_status", "filetype", "fileformat", "encoding" },
  }
})
