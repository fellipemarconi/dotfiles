return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "pineapplegiant/spaceduck",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("spaceduck")

      -- ONLY Neo-tree override
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "spaceduck",
        callback = function()
          local set = vim.api.nvim_set_hl
          local purple = "#b3a1e6"

          set(0, "NeoTreeDirectoryName", { fg = purple })
          set(0, "NeoTreeDirectoryIcon", { fg = purple })
          set(0, "NeoTreeFileName", { fg = purple })
          set(0, "NeoTreeFileIcon", { fg = purple })

          set(0, "NeoTreeGitModified", { fg = purple })
          set(0, "NeoTreeGitAdded", { fg = purple })
          set(0, "NeoTreeGitDeleted", { fg = purple })
        end,
      })
    end,
  },
  {
    "pineapplegiant/spaceduck",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("spaceduck")

      -- ONLY Neo-tree override
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "spaceduck",
        callback = function()
          local set = vim.api.nvim_set_hl
          local purple = "#b3a1e6"

          set(0, "NeoTreeDirectoryName", { fg = purple })
          set(0, "NeoTreeDirectoryIcon", { fg = purple })
        end,
      })
    end,
  }, 
  {
  "Mofiqul/dracula.nvim",
  name = "dracula",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "spaceduck",
    },
  },
}
