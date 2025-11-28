-- Disable snacks.picker in favor of telescope.
if true then
  return {}
end

-- https://github.com/folke/snacks.nvim
-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
-- https://github.com/folke/snacks.nvim/blob/main/docs/gh.md
-- https://github.com/jhawthorn/fzy
-- https://github.com/sharkdp/fd
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<a-c>"] = {
                "toggle_cwd",
                mode = { "n", "i" },
              },
            },
          },
        },
        actions = {
          ---@param p snacks.Picker
          toggle_cwd = function(p)
            local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
            local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
            local current = p:cwd()
            p:set_cwd(current == root and cwd or root)
            p:find()
          end,
        },
      },
    },

    -- stylua: ignore
    keys = {
      -- find files
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader><", LazyVim.pick("oldfiles"), desc = "Recent" },

      { "<leader>.", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },

      { "<leader>/", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>?", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },

      -- Grep
      { "<leader>\\", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>|", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },

      { "<leader>]", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>}", LazyVim.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },

      { "<leader>[", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>{", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },

      -- git
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
      { "<leader>gD", function() Snacks.picker.git_diff({ base = "origin", group = true }) end, desc = "Git Diff (origin)" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
      { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
      { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
      { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },

      -- search
      { '<leader>ss"', function() Snacks.picker.registers() end, desc = "Registers" },
      { '<leader>sh', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sx", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undotree" },
      { "<leader>sn", function() Snacks.picker.notifications() end, desc = "Notification History" },

      -- ui
      { "<leader>c", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    },
  },
}
