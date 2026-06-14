vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.colorcolumn = "120"
vim.o.list = true
vim.o.listchars = "multispace:·,lead:·,trail:·,tab:--,nbsp:+"
vim.o.pumborder = "single"
vim.o.winborder = "single"

vim.api.nvim_set_hl(0, "Normal", { bg = "None", ctermbg = "None" })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "None" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "None" })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
  end,
})

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
