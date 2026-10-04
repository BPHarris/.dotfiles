require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Some terminals will override C-i as Tab
-- This ensures that C-i will still jump forwards
map("n", "<Tab>", "<C-i>", { desc = "Jump forward" })

-- Auto-align
map("v", "<leader>a", ":!column -t<CR>", {
  desc = "Align selected lines with column -t",
})

-- LSP quickfix
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action {
    filter = function(a)
      return a.isPreferred
    end,
    apply = true,
  }
end, { desc = "Apply LSP Quickfix" })

-- Quit
map("n", "<C-x>", ":qall<CR>", { desc = "Quit" })

-- Switch and close buffers without tabufline
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>x", function()
  local buf_count = #vim.fn.getbufinfo { buflisted = 1 }

  if buf_count == 1 then
    vim.cmd "new"
    vim.cmd "bdelete #"
  else
    vim.cmd "bdelete"
  end
end, { desc = "Close current buffer" })

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
