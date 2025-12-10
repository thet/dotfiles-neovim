-- https://github.com/nvim-mini/mini.move
-- https://www.lazyvim.org/extras/editor/mini-move
-- Alternatives:
--   https://github.com/matze/vim-move
--   https://github.com/booperlv/nvim-gomove
--   https://superuser.com/questions/1434741/vim-move-selection-up-down-with-ctrlshiftarrow
return {
  {
    "nvim-mini/mini.move",
    event = "VeryLazy",
    opts = {
      mappings = {
        down = "<M-S-Down>",
        up = "<M-S-Up>",
        line_down = "<M-S-Down>",
        line_up = "<M-S-Up>",
      },
      options = {
        reindent_linewise = false,
      },
    },
  },
}
