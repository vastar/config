vim.o.colorcolumn = "120" -- Highlight column 120
vim.o.termguicolors = true -- Enable true colors
vim.o.ignorecase = true -- Ignore case in search patterns
vim.o.smartcase = true -- Override the "ignorecase" option if the search pattern contains upper case characters
vim.o.swapfile = false -- Disable swap files
vim.o.autoindent = true -- Enable auto indentation
vim.o.smartindent = true -- Do smart autoindenting when starting a new line
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.tabstop = 2 -- Number of spaces for a tab
vim.o.softtabstop = 2 -- Number of spaces for a tab when editing
vim.o.shiftwidth = 2 -- Number of spaces for autoindent
vim.o.shiftround = true -- Round indent to multiple of shiftwidth
vim.o.list = true -- Show whitespace characters
vim.o.listchars = "multispace:·,lead:·,trail:·,tab:> ,nbsp:+" -- Characters to show for tabs, spaces, and end of line
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Show relative line numbers
vim.o.numberwidth = 2 -- Width of the line number column
vim.o.wrap = false -- Disable line wrapping
vim.o.cursorline = true -- Highlight the current line
vim.o.scrolloff = 8 -- Keep 8 lines above and below the cursor
vim.o.inccommand = "nosplit" -- Shows the effects of a command incrementally in the buffer
vim.o.completeopt = "menuone,popup,noinsert,fuzzy" -- Options for completion menu
vim.o.splitright = true -- Open vertical split right
vim.o.splitbelow = true -- Open horizontal split below
vim.o.pumborder = "single" -- Popup border
vim.o.winborder = "single" -- Floating windows border
vim.g.mapleader = " " -- Special character for advanced commands
vim.g.netrw_banner = 0 -- Hide banner with help
vim.g.netrw_liststyle = 3 -- Use tree style view
vim.g.netrw_preview = 1 -- Split preview vertically
vim.g.netrw_alto = 0 -- Show preview vertical split on the right
vim.g.netrw_winsize = 15 -- Use 15% for listing window after opening preview

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
  end,
})

vim.keymap.set("n", "<leader>t", ":split<bar>below<bar>resize 10<bar>term<CR>")
local term_group = vim.api.nvim_create_augroup("Terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "startinsert", group = term_group })
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "setlocal nonumber norelativenumber nospell", group = term_group })

-- Add borders to completion documentation window
-- Issue: https://github.com/neovim/neovim/issues/38248
local orig_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "single"
  return orig_open_floating_preview(contents, syntax, opts, ...)
end
local function set_popup_border(winid)
  if winid and winid >= 0 and vim.api.nvim_win_is_valid(winid) then
    pcall(vim.api.nvim_win_set_config, winid, { border = "single" })
  end
end
vim.api.nvim_create_autocmd("CompleteChanged", {
  group = vim.api.nvim_create_augroup("CompletionPopupBorder", { clear = true }),
  callback = function()
    vim.schedule(function()
      local info = vim.fn.complete_info({"selected"})
      set_popup_border(info.preview_winid)
    end)
  end,
})
if vim.api.nvim__complete_set then
  local orig = vim.api.nvim__complete_set
---@diagnostic disable-next-line: duplicate-set-field
  vim.api.nvim__complete_set = function(index, opts)
    local windata = orig(index, opts)
    set_popup_border(windata and windata.winid)
    return windata
  end
end

vim.keymap.set("i", "jk", "<esc><right>", { noremap = true, silent = true, desc = "Normal mode" })
vim.keymap.set("i", "<c-space>", function()
  return vim.fn.pumvisible() == 1 and "<c-n>" or vim.fn.pumvisible() == 0 and "<c-x><c-o>"
end, { expr = true })
vim.keymap.set("i", "<tab>", function() return vim.fn.pumvisible() == 1 and "<c-y>" or "<tab>" end, { expr = true })

vim.diagnostic.config({ virtual_text = true })

local lsps = {
  { "bashls" },
  { "clangd" },
  { "cmake" },
  { "docker_language_server" },
  { "eslint" },
  { "html" },
  { "httpls" },
  { "jsonls" },
  { "lemminx" },
  { "lua_ls" },
  { "marksman" },
  { "nushell" },
  { "postgres_lsp" },
  { "rust_analyzer" },
  { "systemd_lsp" },
  { "tombi" },
  { "yamlls" },
}

local autocomplete = function(client, bufnr)
  vim.lsp.completion.enable(true, client.id, bufnr, {
    autotrigger = true,
    -- convert = function(item)
    --   return { abbr = item.label:gsub("%b()", "") }
    -- end,
  })
end

for _, lsp in pairs(lsps) do
  local name, config = lsp[1], lsp[2]
  vim.lsp.enable(name)
  vim.lsp.config(name, { on_attach = autocomplete })
  if config then
    vim.lsp.config(name, config)
  end
end
