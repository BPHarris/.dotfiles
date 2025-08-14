return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        path_display = { "smart" },
        results_title = false,
        dynamic_preview_title = true,
      },
      pickers = {
        buffers = {
          initial_mode = "normal",
          mappings = {
            n = {
              ["d"] = "delete_buffer",
            },
          },
        },
      },
    },
  },

  -- Winbar
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 100,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "luadoc",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "c",
        "query",
      },
    },
  },
}
