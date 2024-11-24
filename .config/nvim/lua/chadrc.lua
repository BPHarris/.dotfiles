-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig

local M = {}

M.base46 = {
  theme = "pastelbeans",
  transparency = true,

  hl_override = {
    ColorColumn = { bg = "#161616" },
    TelescopeSelection = { bg = "grey", fg = "white" },
    QuickFixLine = { bg = "black" },
    Operator = { fg = "red" },
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
