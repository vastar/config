vim.o.keymap = "russian-jcukenwin"
vim.o.iminsert = 0
vim.o.imsearch = 0
vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<esc><right>", { noremap = true, silent = true, desc = "Normal mode" })
vim.keymap.set({"i", "c"}, "<A-Space>", "<C-^>", { desc = "Toggle the use of typing language characters" })

vim.keymap.set("i", "<C-Space>", function() return vim.fn.pumvisible() == 1 and "<C-n>" or vim.fn.pumvisible() == 0 and "<C-x><C-o>" end, { expr = true, desc = "Trigger completion or select next match" })
vim.keymap.set("i", "<Tab>", function() return vim.fn.pumvisible() == 1 and "<C-y>" or "<Tab>" end, { expr = true, desc = "Accept selected match and stop completion" })

vim.keymap.set("n", "<Leader>t", ":split<bar>below<bar>resize 10<bar>term<CR>", { desc = "Open terminal" })
local term_group = vim.api.nvim_create_augroup("Terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "startinsert", group = term_group })
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "setlocal nonumber norelativenumber nospell", group = term_group })

vim.keymap.set("n", "<leader>?", ":WhichKey", { desc = "Buffer keymaps (which-key)" })

vim.keymap.set("n", "<Leader>xx", ":Trouble diagnostics", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<Leader>xX", ":Trouble diagnostics filter.buf=0", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<Leader>cs", ":Trouble symbols focus=false", { desc = "Symbols (Trouble)" })

vim.keymap.set("n", "<Leader>ff", ":Telescope find_files hidden=true", { desc = "Telescope find files" })
vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep hidden=true", { desc = "Telescope live grep" })
vim.keymap.set("n", "<Leader>fr", ":Telescope lsp_references", { desc = "Telescope lsp references" })
vim.keymap.set("n", "<Leader>fb", ":Telescope buffers", { desc = "Telescope buffers" })
vim.keymap.set("n", "<Leader>fh", ":Telescope help_tags", { desc = "Telescope help tags" })
vim.keymap.set("n", "<Leader>fd", ":Telescope diagnostics", { desc = "Telescope diagnostics" })

vim.keymap.set("n", "<Leader>re", ":Telescope rest select_env", { desc = "Select REST environment" })
vim.keymap.set("n", "<Leader>rr", ":Rest run", { desc = "Run request under the cursor" })

vim.keymap.set("n", "<leader>dq", ":DapTerminate", { desc = "Terminate" })
vim.keymap.set("n", "<F5>", ":DapContinue", { desc = "Start/continue debugging" })
vim.keymap.set("n", "<F10>", ":DapStepOver", { desc = "Step over" })
vim.keymap.set("n", "<F11>", ":DapStepInto", { desc = "Step into" })
vim.keymap.set("n", "<F12>", ":DapStepOut", { desc = "Step out" })
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint", { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", require("dap").run_to_cursor, { desc = "Run to cursor" })
vim.keymap.set("n", "<leader>dr", ":DapToggleRepl", { desc = "Toggle DAP REPL" })
vim.keymap.set("n", "<leader>dj", require("dap").down, { desc = "Go down stack frame" })
vim.keymap.set("n", "<leader>dk", require("dap").up, { desc = "Go up stack frame" })
vim.keymap.set("n", "<leader>du", require("dapui").toggle, { desc = "Toggle debug user interface" })
