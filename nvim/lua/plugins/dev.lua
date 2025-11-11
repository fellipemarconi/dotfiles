return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      require("supermaven-nvim.completion_preview").suggestion_group = "SupermavenSuggestion"

      opts.ai_accept = function()
        local suggestion = require("supermaven-nvim.completion_preview")
        if suggestion.has_suggestion() then
          LazyVim.create_undo()
          vim.schedule(function()
            suggestion.on_accept_suggestion()
          end)
          return true
        end
      end

      return opts
    end,
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      opts.sources = vim.list_extend({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer", keyword_length = 5 },
        { name = "emoji" },
      })

      opts.completion = opts.completion or {}
      opts.completion.completeopt = "menu,menuone,noinsert"

      return opts
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = false,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      local lsp = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Python
      lsp.pyright.setup({ capabilities = capabilities })

      -- Lua
      lsp.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Prisma
      lsp.prismals.setup({ capabilities = capabilities })

      -- Docker
      lsp.dockerls.setup({ capabilities = capabilities })
      lsp.docker_compose_language_service.setup({ capabilities = capabilities })

      -- SQL
      lsp.sqlls.setup({ capabilities = capabilities })

      -- Go
      lsp.gopls.setup({ capabilities = capabilities })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        python = { "ruff" },
        lua = { "luacheck" },
        go = { "golangci_lint" },
      }

      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      format_on_save = {
        async = false,
        timeout_ms = 3000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        python = { "ruff_format" },
        go = { "gofmt", "goimports" },
      },
    },
  },
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
        "json",
        "jsonc",
        "go",
        "dockerfile",
        "sql",
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "folke/snacks.nvim",
    opts = {
      stats = { enabled = false },
    },
  },
}
