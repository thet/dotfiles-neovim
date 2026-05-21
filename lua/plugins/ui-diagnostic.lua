-- https://github.com/rachartier/tiny-inline-diagnostic.nvim
return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
    end,
  },
}

-- Alternative config
---- Diagnostics: show sign-column icon on all lines, expand full message below current line only
--vim.diagnostic.config({
--  virtual_text = false,
--  virtual_lines = { current_line = true },
--})
