-- https://github.com/jeetsukumaran/vim-filebeagle

-- Disable netrw. We use vim-filebeagle instead.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[
  "" filebeagle defines <leader>f, which I don't want
  let g:filebeagle_suppress_keymaps = 1
  let g:filebeagle_show_hidden = 0  " show with ``gh``
  "let g:filebeagle_check_gitignore = 1
]])

return {
  "jeetsukumaran/vim-filebeagle",

  -- Load after Neovim starts. Allows telescope to open a directory and
  -- filebeagle handle it.
  event = "VimEnter",

  keys = {
    {
      "_",
      "<Plug>FileBeagleOpenCurrentWorkingDir",
      desc = "Browse working directory",
    },
    {
      "-",
      "<Plug>FileBeagleOpenCurrentBufferDir",
      desc = "Browse buffer directory",
    },
  },
}
