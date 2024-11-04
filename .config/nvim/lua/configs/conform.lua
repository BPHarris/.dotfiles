local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_organize_imports", "ruff_format", "ruff_fix" },
    go = { "goimports", "gofumpt" },
    cpp = { "astyle" },
    rust = { "rustfmt" },
    markdown = { "mdformat", "mdslw" },
    zig = { "zigfmt" },

    ["*"] = { "codespell" }, -- always
    ["_"] = { "trim_whitespace" }, -- only if not other formatters configured
  },
  formatters = {
    mdslw = { prepend_args = { "--stdin-filepath", "$FILENAME" } },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_fallback = true,
  },
  format_after_save = {
    lsp_fallback = true,
  },

  notify_on_error = true,
  notify_no_formatters = true,
}

return options
