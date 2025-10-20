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
--

-- FOLDS
--------

map("n", "<C-S-Right>", "zo", { desc = "Open current fold", remap = true })
map("n", "<C-S-Left>", "zc", { desc = "Close current fold", remap = true })

--"" open/close all folds
--""noremap <C-TAB> za
--""noremap <C-S-TAB> zA
--noremap <C-S-Right> zo
--noremap <C-S-Left> zc
--"" termit might override usage of -A-
--""noremap <C-S-A-Right> zO
--""noremap <C-S-A-Left> zC
