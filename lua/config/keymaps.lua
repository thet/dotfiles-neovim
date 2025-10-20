-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Yank'in
-- -------

-- stylua: ignore start

-- 🗑️ Delete key: send deletions to the black-hole register to not overwrite other yank registers.
-- Thanks bairu from #vim!
map({ "n", "v", "x" }, "<Del>", '"_x', { desc = "<Del> into blackhole.", noremap = true, silent = true })

-- 📋 System clipboard: Copy, Paste, Delete
-- Copy to system clipboard
map('n', '1', '"+yy', { desc = "Copy line to system clipboard", noremap = true, silent = true })
map('x', '1', '"+y',  { desc = "Copy selection to system clipboard", noremap = true, silent = true })

-- Paste BEFORE (like 'P')
map('n', '2', '"+p',  { desc = "Paste from system clipboard (after cursor)", noremap = true, silent = true })
map('x', '2', '"_d"+P', { desc = "Paste from system clipboard (preserve +, before selection)", noremap = true, silent = true })

-- Paste AFTER (like 'p')
map('n', '@', '"+P',  { desc = "Paste from system clipboard (before cursor)", noremap = true, silent = true })
map('x', '@', '"_d"+p', { desc = "Paste from system clipboard (preserve +, after selection)", noremap = true, silent = true })

-- Delete into system clipboard
map('n', '3', '"+dd', { desc = "Delete line into system clipboard", noremap = true, silent = true })
map('x', '3', '"+d',  { desc = "Delete selection into system clipboard", noremap = true, silent = true })


-- 🧷 Paste selected text into the command line
-- In normal mode: yank the current line, start command-line, paste the yanked text
map('n', ';', 'y:<C-r>"<C-b>', { desc = 'Paste last yanked text into command line', noremap = true, silent = true })
-- In visual mode: yank selection, then open command line with that text
map('x', ';', 'y:<C-r>"<C-b>', { desc = 'Paste visual selection into command line', noremap = true, silent = true })

-- 📁 Copy filename/path to clipboard
map('n', '<leader>cs', ':let @+=expand("%")<CR>', { desc = 'Copy relative file path to clipboard', noremap = true, silent = true })
map('n', '<leader>cl', ':let @+=expand("%:p")<CR>', { desc = 'Copy absolute file path to clipboard', noremap = true, silent = true })

-- stylua: ignore end

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
