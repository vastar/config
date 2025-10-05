vim.keymap.set('i', 'jk', '<Esc><right>', { noremap = true, silent = true })
vim.keymap.set('i', '<c-space>', vim.lsp.completion.get, { desc = "trigger autocompletion" })
