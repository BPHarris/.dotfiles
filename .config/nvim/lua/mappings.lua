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

-- Show diagnostic
map("n", "<leader>sd", function()
  vim.diagnostic.open_float()
end, { desc = "Show LSP diagnostic" })

map("n", "<leader>sD", function()
  vim.diagnostic.setloclist()
end, { desc = "Show LSP diagnostics (all)" })

-- Manual refresh
-- Such as reload externally modified files
map("n", "<F5>", ":checktime<CR>", { silent = true, desc = "Reload editor" })

-- Copy file path
---@param modifier string The vim expand modifier (e.g., "%:p", "%", "%:t")
---@return function
local function create_copy_path_fn(modifier)
  return function()
    local path = vim.fn.expand(modifier)
    vim.fn.setreg("+", path)
    vim.notify_once("Copied: " .. path)
  end
end

map("n", "<leader>cfp", create_copy_path_fn "%:p", { desc = "Copy full file path" })
map("n", "<leader>cfr", create_copy_path_fn "%", { desc = "Copy relative file path" })
map("n", "<leader>cfn", create_copy_path_fn "%:t", { desc = "Copy file name" })
