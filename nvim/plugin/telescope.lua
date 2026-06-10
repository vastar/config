vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/nvim-telescope/telescope.nvim"
})

local telescope = require("telescope")
telescope.setup({
  defaults = {
    file_ignore_patterns = { "bin/*", "obj/*", "node_modules/*" },
  }
})
telescope.load_extension("rest")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", function() builtin.find_files({ hidden = true }) end, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", function() builtin.live_grep({ hidden = true }) end, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>ft", builtin.lsp_references, { desc = "Telescope lsp references" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics" })

local rest = telescope.extensions.rest
vim.keymap.set("n", "<leader>re", rest.select_env, { desc = "Select REST environment" })
