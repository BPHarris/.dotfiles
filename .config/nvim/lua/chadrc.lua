-- Must follow:
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "doomchad",
  transparency = true,

  hl_override = {
    ColorColumn = { bg = "#161616" },
    TelescopeSelection = { bg = "grey", fg = "white" },
    QuickFixLine = { bg = "black" },
    Operator = { fg = "red" },
    Comment = { italic = true },
    ["@Comment"] = { italic = true },
  },
}

M.lsp = {
  signature = true,
}

M.ui = {
  statusline = {
    theme = "vscode_colored",
  },
  tabufline = {
    enabled = false,
  },
}

return M
