-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Force "indent" as foldmethod, even if TreeSitter or others have set it differently
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "typescriptreact", "json", "html", "xml" },
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldexpr = "0"
  end,
  desc = "Force indent folding for JS/TS/HTML/XML files",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.zcml",
  callback = function()
    vim.bo.filetype = "xml"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.pt", "*.cpt", "*.zpt" },
  callback = function()
    vim.bo.filetype = "xhtml"
    vim.cmd("syntax html")
  end,
})
