-- https://github.com/rhysd/git-messenger.vim

return {
  "rhysd/git-messenger.vim",
  event = "VeryLazy",
  keys = {
    { "?", "<cmd>GitMessenger<CR>", mode = "n", noremap = true, desc = "Git messenger" },
  },
  -- config = function()
  --   vim.g.git_messenger_no_default_mappings = 1
  -- end,
}
