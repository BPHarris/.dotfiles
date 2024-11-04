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
    -- Comment = { italic = true },
    -- ["@comment"] = { italic = true },
  },
}

M.lsp = {
  signature = true,
}

M.ui = {
  statusline = {
    theme = "vscode_colored",
    modules = {
      -- TODO Why does this give a lua import error?
      custom_cursor = function()
        return "%#St_Pos_sep#█%#St_Pos_bg# %#St_Pos_txt# %l, %c | %p█"
      end,
    },
  },
}

return M
