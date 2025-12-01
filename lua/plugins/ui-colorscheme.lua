-- More colorschemes:
-- https://github.com/topics/neovim-colorscheme
-- https://github.com/projekt0n/github-nvim-theme

return {

  -- tokyonight
  {
    -- https://github.com/folke/tokyonight.nvim
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
    config = function()
      vim.opt.background = "dark"
    end,
  },

  -- Dracula
  {
    -- https://github.com/dracula/vim
    -- https://draculatheme.com/vim
    "dracula/vim",
    lazy = true,
    config = function()
      vim.opt.background = "dark"
    end,
  },

  -- GitHub Theme
  {
    -- https://github.com/endel/vim-github-colorscheme
    "endel/vim-github-colorscheme",
    lazy = true,
    config = function()
      vim.opt.background = "light"
    end,
  },

  -- papercolor theme
  {
    -- https://github.com/NLKNguyen/papercolor-theme
    "NLKNguyen/papercolor-theme",
    lazy = true,
    config = function()
      vim.opt.background = "light"
    end,
  },

  -- LazyVim theme configuration
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
