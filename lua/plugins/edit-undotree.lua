-- Alternatives:
--    https://github.com/mbbill/undotree (original)
return {
  -- https://github.com/jiaoshijie/undotree
  {
    "jiaoshijie/undotree",
    ---@module 'undotree.collector'
    ---@type UndoTreeCollector.Opts
    opts = {
      float_diff = true, -- using float window previews diff
    },
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", noremap = true },
    },
  },
}
