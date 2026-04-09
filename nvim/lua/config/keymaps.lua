-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- ========================
-- 🖱️ MOUSE
-- ========================
vim.o.mouse = "a"

-- ========================
-- 🚫 DESATIVAR HJKL
-- ========================
vim.keymap.set("n", "h", "<Nop>")
vim.keymap.set("n", "j", "<Nop>")
vim.keymap.set("n", "k", "<Nop>")
vim.keymap.set("n", "l", "<Nop>")

-- ========================
-- ⌨️ NAVEGAÇÃO (VSCode style)
-- ========================
-- Movimento fino (insert)
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

-- Palavras
vim.keymap.set({ "n", "i" }, "<C-Left>", "<Esc>b", { desc = "Previous word" })
vim.keymap.set({ "n", "i" }, "<C-Right>", "<Esc>w", { desc = "Next word" })

-- Blocos
vim.keymap.set({ "n", "i" }, "<C-Up>", "<Esc>{", { desc = "Previous block" })
vim.keymap.set({ "n", "i" }, "<C-Down>", "<Esc>}", { desc = "Next block" })

-- ========================
-- 🔙 UNDO / REDO
-- ========================
vim.keymap.set("i", "<C-z>", "<Esc>u i")
vim.keymap.set("n", "<C-z>", "u")

vim.keymap.set("i", "<C-S-z>", "<Esc><C-r>i")
vim.keymap.set("n", "<C-S-z>", "<C-r>")

-- fallback
vim.keymap.set("i", "<C-y>", "<Esc><C-r>i")
vim.keymap.set("n", "<C-y>", "<C-r>")

-- ========================
-- 💾 SAVE
-- ========================
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>i")

-- ========================
-- 📋 COPY / PASTE
-- ========================
vim.keymap.set({ "n", "v" }, "<C-c>", '"+y')
vim.keymap.set({ "n", "v" }, "<C-x>", '"+d')
vim.keymap.set({ "n", "v" }, "<C-v>", '"+p')

-- ========================
-- 🪟 JANELAS (ALT + ← →)
-- ========================
vim.keymap.set("n", "<A-Left>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<A-Right>", "<C-w>l", { desc = "Right window" })

-- ========================
-- 🔀 MOVER LINHA (ALT + ↑ ↓)
-- ========================
-- Normal
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })

-- Insert
vim.keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi")

-- Visual
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")

-- ========================
-- 🖥️ TERMINAL
-- ========================
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
-- ========================
-- 📏 RESIZE JANELAS (ALT + SHIFT + SETAS)
-- ========================
vim.keymap.set("n", "<A-S-Left>", ":vertical resize -3<CR>", { desc = "Resize left" })
vim.keymap.set("n", "<A-S-Right>", ":vertical resize +3<CR>", { desc = "Resize right" })
vim.keymap.set("n", "<A-S-Up>", ":resize -2<CR>", { desc = "Resize up" })
vim.keymap.set("n", "<A-S-Down>", ":resize +2<CR>", { desc = "Resize down" })

-- ========================
-- 📑 BUFFER NAV (CTRL + TAB)
-- ========================
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-w>", ":bd<CR>", { desc = "Close buffer" })
-- ========================
-- 🧠 SELECT ALL (CTRL + A)
-- ========================
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- ========================
-- 📦 WHICH-KEY GROUPS
-- ========================
local wk = require("which-key")

wk.add({
  { "<leader>y", group = " Yazi" },
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
