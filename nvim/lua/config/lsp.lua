local autocomplete = function(client, bufnr)
  vim.lsp.completion.enable(true, client.id, bufnr, {
    autotrigger = true,
    convert = function(item)
      return { abbr = item.label:gsub("%b()", "") }
    end,
  })
end

vim.diagnostic.config({ virtual_text = true })

vim.lsp.config("lua_ls", {
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
  on_attach = autocomplete
})
vim.lsp.enable("lua_ls")

vim.lsp.config("bashls", { on_attach = autocomplete })
vim.lsp.enable("bashls")

vim.lsp.config("nushell", { on_attach = autocomplete })
vim.lsp.enable("nushell")

vim.lsp.enable("csharp_ls", { on_attach = autocomplete })
vim.lsp.enable("csharp_ls")

vim.lsp.enable("rust_analyzer", { on_attach = autocomplete })
vim.lsp.enable("rust_analyzer")

vim.lsp.enable("clangd", { on_attach = autocomplete })
vim.lsp.enable("clangd")
