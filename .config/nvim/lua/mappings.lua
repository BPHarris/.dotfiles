require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- Show lsp hover
map("n", "<leader>st", function()
  vim.lsp.buf.hover()
end, { desc = "Show LSP hover" })

map("n", "<C-Space>", function()
  vim.lsp.buf.hover()
end, { desc = "Show LSP hover" })

-- Disable spell check
map("n", "<leader>ss", function()
  vim.o.spell = not vim.o.spell
end, { desc = "Toggle spellcheck" })
