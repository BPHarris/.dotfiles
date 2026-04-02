require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

local servers = { "html", "cssls", "clangd", "gopls", "ruff", "basedpyright", "zls" }

-- enable extra server
vim.lsp.enable "tombi"

-- default configs
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })

  vim.lsp.enable(lsp)
end

-- custom config (bashls)
vim.lsp.config("bashls", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "sh", "bash" },
})

vim.lsp.enable "bashls"
