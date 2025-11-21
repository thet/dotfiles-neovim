return {
  --    https://github.com/stevearc/aerial.nvim
  {
    "stevearc/aerial.nvim",
    lazy = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup({})
    end,
    keys = {
      {
        "tt",
        "<cmd>AerialToggle<CR>",
        desc = "Toggle outline",
      },
    },
  },
  -- https://github.com/hedyhli/outline.nvim
  --{
  --  "hedyhli/outline.nvim",
  --  lazy = true,
  --  cmd = { "Outline", "OutlineOpen" },
  --  keys = {
  --    {
  --      "tt", "<cmd>Outline<CR>", desc = "Toggle outline"
  --    },
  --  },
  --},
}
