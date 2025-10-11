vim.diagnostic.config({ virtual_text = true })

local cmp = require('cmp_nvim_lsp')
if cmp then
  local capabilities = cmp.default_capabilities()
  vim.lsp.config("lua_ls", {
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    capabilities = capabilities
  })
  vim.lsp.config("bashls", { capabilities = capabilities })
  vim.lsp.config("nushell", { capabilities = capabilities })
  vim.lsp.config("csharp_ls", { capabilities = capabilities })
  vim.lsp.config("rust_analyzer", { capabilities = capabilities })
  vim.lsp.config("clangd", { capabilities = capabilities })
else
  local autocomplete = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = true,
      convert = function(item)
        return { abbr = item.label:gsub("%b()", "") }
      end,
    })
  end
  vim.lsp.config("lua_ls", {
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    on_attach = autocomplete
  })
  vim.lsp.config("bashls", { on_attach = autocomplete })
  vim.lsp.config("nushell", { on_attach = autocomplete })
  vim.lsp.config("csharp_ls", { on_attach = autocomplete })
  vim.lsp.config("rust_analyzer", { on_attach = autocomplete })
  vim.lsp.config("clangd", { on_attach = autocomplete })
end

vim.lsp.enable("lua_ls")
vim.lsp.enable("bashls")
vim.lsp.enable("nushell")
vim.lsp.enable("csharp_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("clangd")
