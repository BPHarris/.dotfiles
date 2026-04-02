local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_organize_imports", "ruff_format", "ruff_fix" },
    go = { "goimports", "gofumpt" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    rust = { "rustfmt" },
    markdown = { "mdformat", "mdslw" },
    zig = { "zigfmt" },
    sh = { "shellharden", "shfmt" },
    bssh = { "shellharden", "shfmt" },
    toml = { "tombi" },

    html = { "superhtml" },

    ["*"] = {}, -- always
    ["_"] = { "trim_whitespace" }, -- only if not other formatters configured
  },

  formatters = {
    astyle = {
      prepend_args = {
        "--max-code-length=88",
        "--break-after-logical",
        "--indent=spaces=4",
      },
    },
    clang_format = {
      inherit = true,
      prepend_args = {
        "--style={BasedOnStyle: LLVM, UseTab: Always, IndentWidth: 4, TabWidth: 4, ColumnLimit: 88, BinPackArguments: false, BinPackParameters: false, AllowAllArgumentsOnNextLine: false, AllowAllParametersOfDeclarationOnNextLine: false, AlignAfterOpenBracket: false, BreakAfterOpenBracketFunction: true, BreakBeforeCloseBracketFunction: true, PointerAlignment: Left, BreakBeforeBinaryOperators: None}",
      },
    },
    mdformat = { command = "/home/anon/.local/pipx/bin/mdformat", prepend_args = { "--wrap", "no" } },
    mdslw = { prepend_args = { "--stdin-filepath", "$FILENAME", "--max-width", "0" } },
  },

  format_on_save = {
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
