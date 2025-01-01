-- https://github.com/akinsho/bufferline.nvim

return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<C-Right>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<C-Left>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
      { "<S-Right>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move tab right" },
      { "<S-Left>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move tab left" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
}
