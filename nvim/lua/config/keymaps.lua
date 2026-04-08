-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- sair do terminal com ESC
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

local wk = require("which-key")

wk.add({
  { "<leader>y", group = " Yazi" }, -- grupo principal

  { "<leader>yy", "<cmd>Yazi cwd<CR>", desc = " Yazi at working directory" },
})

wk.add({
  { "<leader>l", group = "🐳 LazyDocker" },
  {
    "<leader>ld",
    function()
      require("lazydocker").open()
    end,
    desc = "Open Lazydocker floating window",
  },
})

wk.add({
  { "<leader>o", group = "🤖 OpenCode" },

  {
    "<leader>oa",
    function()
      require("opencode").ask()
    end,
    desc = "Ask AI",
  },
  {
    "<leader>oe",
    function()
      require("opencode").ask("Explain this code: ")
    end,
    desc = "Explain code",
  },
  {
    "<leader>or",
    function()
      require("opencode").ask("Refactor this: ")
    end,
    desc = "Refactor code",
  },
  {
    "<leader>os",
    function()
      require("opencode").select()
    end,
    desc = "Actions",
  },
  {
    "<leader>ot",
    function()
      require("opencode").toggle()
    end,
    desc = "Toggle panel",
  },

  -- Visual mode (seleção)
  {
    mode = "v",
    {
      "<leader>oa",
      function()
        require("opencode").ask("@selection: ")
      end,
      desc = "Ask AI (selection)",
    },
  },
})
