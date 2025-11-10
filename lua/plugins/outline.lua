-- https://github.com/hedyhli/outline.nvim
return {
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "tt", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
    },
  },
}
