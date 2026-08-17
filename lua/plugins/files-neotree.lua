-- https://github.com/nvim-neo-tree/neo-tree.nvim/tree/main
-- https://github.com/nvim-tree/nvim-web-devicons

-- Alternatives:
-- https://github.com/nvim-tree/nvim-tree.lua

-- Keymap:
-- <leader>fe .. dir at current file
-- <leader>fE .. dir at cwd
-- <leader>E
-- <leader>be .. open buffers
-- <leader>ge .. git status
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false, -- neo-tree will lazily load itself
  },
}
