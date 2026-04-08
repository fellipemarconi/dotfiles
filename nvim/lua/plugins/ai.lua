return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "<C-CR>" } },
        panel = { enabled = false },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "*",
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    dependencies = {
      {
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {},
          picker = {
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
          },
        },
      },
    },

    config = function()
      vim.g.opencode_opts = {
        ui = {
          window = {
            layout = "vertical", -- 🔥 abre na direita
            width = 0.2, -- 40% da tela
          },
        },
      }

      vim.o.autoread = true
    end,
  },
}
