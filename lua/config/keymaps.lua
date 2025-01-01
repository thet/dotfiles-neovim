-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "1", '"+yy', { desc = "Copy to system clipboard", remap = true })
map("n", "2", '"+p', { desc = "Paste before", remap = true })
map("n", "@", '"+P', { desc = "Paste after", remap = true })
map("n", "3", '"+d', { desc = "Delete into system clipboard", remap = true })

-- Buffers
-- -------
map("n", "<C-x>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- Open buffer relative to current one
--map("n", "<leader>e", "<cmd>n %:h/", { desc = "Open buffer relative to current one", remap = true })
