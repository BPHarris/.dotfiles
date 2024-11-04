require "nvchad.options"

vim.o.cursorlineopt = "both"

vim.o.spell = true
vim.o.spelllang = "en_gb"

vim.o.updatetime = 100

-- Indenting
vim.o.smartindent = true

vim.o.expandtab = false
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.o.expandtab = true
    vim.o.shiftwidth = 2
    vim.o.tabstop = 2
    vim.o.softtabstop = 2
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.o.expandtab = true
    vim.o.shiftwidth = 4
    vim.o.tabstop = 4
    vim.o.softtabstop = 4
  end,
})

-- Line numbers, rules, etc.
vim.opt.relativenumber = true
vim.o.colorcolumn = "88,100,120"

-- Auto reload externally modified files
vim.o.autoread = true
vim.api.nvim_create_augroup("checktime", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = "checktime",
  command = "checktime",
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- -- Alacritty: toggle padding on enter/exit nvim
-- if vim.env.TERM == "alacritty" or vim.env.TMUX ~= nil then
--   vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained"}, {
--     callback = function()
--       os.execute "alacritty msg config window.padding.x=0 window.padding.y=0"
--     end,
--   })
--
--   vim.api.nvim_create_autocmd({ "VimLeave", "FocusLost" }, {
--     callback = function()
--       os.execute "alacritty msg config --reset"
--     end,
--   })
-- end

-- Barbecue
-- Default config from github
require("barbecue").setup {
  create_autocmd = false,
}

vim.api.nvim_create_autocmd({
  "WinScrolled",
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",
  "BufModifiedSet",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function()
    require("barbecue.ui").update()
  end,
})
