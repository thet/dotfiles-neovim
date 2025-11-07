-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Select all
map({ "n", "v", "x" }, "<C-a>", "ggVG", { desc = "Select all.", noremap = true, silent = true })

-- Repeat last change for every line in the visual/select selection
map({ "x", "s" }, ".", ":normal .<CR>", { desc = "Repeat last change (visual/select)", noremap = true, silent = true })

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
map("n", "<leader>e", ":edit %:h/", {
  desc = "Edit new file in current file's directory",
  noremap = true,
  silent = false,
})

-- FOLDS
--------

-- Current fold
map("n", "<C-S-Right>", "zo", { desc = "Open current fold", remap = true })
map("n", "<C-S-Left>", "zc", { desc = "Close current fold", remap = true })
-- Recursive open/close at cursor
map("n", "<A-Right>", "zO", { desc = "Open all folds under cursor.", noremap = true, silent = true })
map("n", "<A-Left>", "zC", { desc = "Close all folds under cursor.", noremap = true, silent = true })

-- Text formatting helpers
-- -----------------------

-- Wrap the current paragraph on `textwidth`.
map("n", "<leader>w", function()
  -- Save original formatexpr and formatprg
  local fx, fp = vim.bo.formatexpr, vim.bo.formatprg
  -- Unset both
  vim.bo.formatexpr, vim.bo.formatprg = "", ""
  -- Wrap bypassing formatexpr, formatprg
  vim.cmd.normal({ args = { "gwip" }, bang = true })
  -- Restore original
  vim.bo.formatexpr, vim.bo.formatprg = fx, fp
end, { desc = "Wrap paragraph (internal gqip, uses textwidth)", noremap = true, silent = true })

-- Join text: select inner paragraph, join, move to first non-blank.
map("n", "<leader>j", function()
  -- Avoid Treesitter recomputing folds while joining, which would lead in a noisy traceback.
  -- Return on special buffers.
  if vim.bo.buftype ~= "" then
    return
  end
  local bufnr = 0
  -- Stop tresitter
  pcall(vim.treesitter.stop, bufnr)
  -- Do the joining.
  pcall(vim.cmd.normal, { "vipJ^", bang = true })
  -- Restore
  pcall(vim.treesitter.start, bufnr)
end, { desc = "Join paragraph (TS stop/start)", silent = true, noremap = true })

map("n", "<leader>j", "vipJ^", { desc = "Join paragraph (vipJ^)", noremap = true, silent = true })

-- Split each sentence onto its own line within the paragraph
-- Matches ., ?, !, ; followed by spaces and inserts a newline after the punctuation.
map(
  "n",
  "<leader>k",
  [[vap:s/\([\.\?!;]\) \+/\1\r/e<CR>]],
  { desc = "Split sentences in paragraph", noremap = true, silent = true }
)

-- helper to preserve view and search register when running a command
local function preserve(cmd)
  local view = vim.fn.winsaveview()
  local search = vim.fn.getreg("/")
  vim.cmd(cmd)
  vim.fn.winrestview(view)
  vim.fn.setreg("/", search)
end

-- Strip trailing whitespace in the whole file, preserving view and search register
map("n", "<leader>s", function()
  preserve([[%s/\s\+$//e]])
end, { desc = "Strip trailing whitespace", noremap = true, silent = true })

-- Plugins

-- https://github.com/hedyhli/outline.nvim
map("n", "tt", "<cmd>Outline<cr>", { desc = "Toggle Outline", noremap = true, silent = true })
