vim.pack.add({"https://github.com/folke/which-key.nvim"})
local whichkey = require("which-key")
whichkey.setup({
  delay = function(ctx)
    return ctx.plugin and 0 or 500
  end
})
vim.keymap.set("n", "<leader>?", function() whichkey.show({ global = true }) end, { desc = "Buffer keymaps (which-key)" })

