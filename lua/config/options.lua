-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- set leader
vim.g.mapleader = ","

-- default foldmethod indent.
vim.opt.foldmethod = "indent"

-- Define the LazyVim picker implementation.
vim.g.lazyvim_picker = "snacks"

-- Make sure autoread is set (should be the default)
vim.o.autoread = true

-- Disable animations
vim.g.snacks_animate = false
