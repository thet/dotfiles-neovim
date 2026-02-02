-- https://github.com/airblade/vim-gitgutter
return {
  {
    "airblade/vim-gitgutter",

    -- Load on buffer open (or you can omit `event` to load immediately)
    event = { "BufReadPre", "BufNewFile" },

    -- Set the Vimscript globals before the plugin loads
    init = function()
      vim.g.gitgutter_async = 1
      -- vim.g.gitgutter_realtime = 0
      -- vim.g.gitgutter_eager = 0
    end,

    -- Keymaps equivalent to your vimscript nmap lines
    keys = {
      { "]z", "<Plug>(GitGutterNextHunk)", mode = "n", desc = "Next hunk (gitgutter)" },
      { "[z", "<Plug>(GitGutterPrevHunk)", mode = "n", desc = "Prev hunk (gitgutter)" },
      { "<leader>hg", "<Plug>(GitGutterToggle)", mode = "n", desc = "Toggle GitGutter" },
      { "<leader>ha", "<Plug>(GitGutterStageHunk)", mode = "n", desc = "Stage hunk" },
      { "<leader>hu", "<Plug>(GitGutterUndoHunk)", mode = "n", desc = "Undo hunk" },
      { "<leader>hp", "<Plug>(GitGutterPreviewHunk)", mode = "n", desc = "Preview hunk" },
    },
  },
}
