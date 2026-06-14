vim.o.completeopt = "fuzzy,menuone,noinsert,popup" -- Options for Insert mode completion

vim.diagnostic.config({ virtual_text = true }) -- Use virtual text for diagnostics

local lsps = {
  { "bashls" },
  { "clangd" },
  { "cmake" },
  { "cssls" },
  { "docker_language_server" },
  { "eslint" },
  { "fish_lsp" },
  { "gopls" },
  { "html" },
  { "httpls" },
  { "jsonls" },
  { "lemminx" },
  { "lua_ls" },
  { "marksman" },
  { "nushell" },
  { "postgres_lsp" },
  { "pyright" },
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
