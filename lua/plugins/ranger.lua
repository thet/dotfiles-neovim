-- https://github.com/francoiscabrol/ranger.vim
-- https://github.com/rbgrouleff/bclose.vim
-- Alternatives:
--   https://github.com/rafaqz/ranger.vim
--   https://github.com/kelly-lin/ranger.nvim

return {
  {
    "francoiscabrol/ranger.vim",
    init = function()
      vim.g.ranger_map_keys = 0
    end,
    keys = {
      { "<leader>r", ":Ranger<CR>", desc = "Open Ranger" },
    },
    dependencies = {
      "rbgrouleff/bclose.vim",
    },
  },
}
