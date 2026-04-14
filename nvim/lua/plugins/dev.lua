return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji", "L3MON4D3/LuaSnip" },
    opts = function(_, opts)
      opts.sources = vim.list_extend({
        { name = "copilot" }, -- GitHub Copilot
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer", keyword_length = 5 },
        { name = "emoji" },
      })

      opts.completion = opts.completion or {}
      opts.completion.completeopt = "menu,menuone,noinsert"

      -- Mapeamento de teclas
      local cmp = require("cmp")
      opts.mapping = {
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }

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
      dashboard = {
        sections = {
          { section = "header" },
          {
            padding = 1,
            text = {
              { "Simplicity is the soul of efficiency.", hl = "SnacksDashboardDesc", align = "right" },
            },
          },
        },
        preset = {
          header = [[
███▄ ▄███▓ ▄▄▄       ██▀███   ▄████▄   ▒█████   ███▄    █  ██▓
▓██▒▀█▀ ██▒▒████▄    ▓██ ▒ ██▒▒██▀ ▀█  ▒██▒  ██▒ ██ ▀█   █ ▓██▒
▓██    ▓██░▒██  ▀█▄  ▓██ ░▄█ ▒▒▓█    ▄ ▒██░  ██▒▓██  ▀█ ██▒▒██▒
▒██    ▒██ ░██▄▄▄▄██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒▒██   ██░▓██▒  ▐▌██▒░██░
▒██▒   ░██▒ ▓█   ▓██▒░██▓ ▒██▒▒ ▓███▀ ░░ ████▓▒░▒██░   ▓██░░██░
░ ▒░   ░  ░ ▒▒   ▓▒█░░ ▒▓ ░▒▓░░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒░   ▒ ▒ ░▓  
░  ░      ░  ▒   ▒▒ ░  ░▒ ░ ▒░  ░  ▒     ░ ▒ ▒░ ░ ░░   ░ ▒░ ▒ ░
░      ░     ░   ▒     ░░   ░ ░        ░ ░ ░ ▒     ░   ░ ░  ▒ ░
       ░         ░  ░   ░     ░ ░          ░ ░           ░  ░  
                              ░
          ]],
        },
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<leader>\]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
      })
    end,
  },
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      open_for_directories = false,
      keymaps = { show_help = "<F1>" },
    },
    init = function()
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
    "mgierada/lazydocker.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    event = "BufRead",
    config = function()
      require("lazydocker").setup({
        border = "curved", -- "single" | "double" | "shadow" | "curved"
        width = 0.9, -- 0-1 para percentual
        height = 0.9, -- 0-1 para percentual
      })
    end,
  },
  {
    "spacedentist/resolve.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  { "nvim-tree/nvim-web-devicons", opts = {} },
  {
    "Maxteabag/sqlit.nvim",
    opts = {},
    keys = {
      {
        "<leader>D",
        function()
          require("sqlit").open()
        end,
        desc = "Database (sqlit)",
      },
    },
  },
  {
    "salkhalil/summon.nvim",
    config = function()
      require("summon").setup({
        width = 0.9,
        height = 0.9,
        border = "rounded",
        close_keymap = "q",

        commands = {
          redis = {
            type = "terminal",
            command = "redis-tui",
            title = " Redis ",
            keymap = "<leader>rr",
            border_color = "#ef4444",
          },

          http = {
            type = "terminal",
            command = "posting",
            title = " HTTP ",
            keymap = "<leader>pp",
            border_color = "#a855f7",
          },

          ssh = {
            type = "terminal",
            command = "lazyssh",
            title = " SSH ",
            keymap = "<leader>ls",
            border_color = "#2563eb",
          },
        },
      })
    end,
  },
  { "tamton-aquib/mpv.nvim", config = true },
}
