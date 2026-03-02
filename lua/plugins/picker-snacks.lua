-- Disable snacks.picker in favor of telescope.
--if true then
--  return {}
--end

-- https://github.com/folke/snacks.nvim
-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
-- https://github.com/folke/snacks.nvim/blob/main/lua/snacks/picker/source/files.lua
-- https://github.com/folke/snacks.nvim/blob/main/docs/explorer.md
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
      -- explorer
      -- https://github.com/folke/snacks.nvim/blob/main/docs/explorer.md
      { "<leader>n", function() Snacks.explorer.open() end, desc = "Open file explorer" },

      -- find files
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#buffers
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Find buffers" },
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#files
      {
        "<leader>.",
        function()
          local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")
          Snacks.picker.files({
            dirs = { dir },
            follow = true,
            ignored = true,
            hidden = true,
          })
        end,
        desc = "Find relative"
      },
      { "<leader>/", function() Snacks.picker.files({ follow = true, ignored = true, hidden = true, }) end, desc = "Find root" },
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#recent
      { "<leader><", function() Snacks.picker.recent() end, desc = "Find recent" },
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#git_files
      { "<leader>?", function() Snacks.picker.git_files() end, desc = "Find git" },

      -- Grep
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#grep_buffers
      { "<<", function() Snacks.picker.grep_buffers({ }) end, desc = "Grep buffers" },
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#grep
      {
        "<>",
        function()
          local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")
          Snacks.picker.grep({
            dirs = { dir },
            follow = true,
            ignored = true,
            hidden = true,
          })
        end,
        desc = "Grep relative"
      },
      { "<?", function() Snacks.picker.grep({ follow = true, ignored = true, hidden = true, }) end, desc = "Grep root" },

      -- terminal
      -- https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md
      { "<leader>t", function() Snacks.terminal.toggle() end, desc = "Toggle terminal." },

      -- git
      -- https://github.com/folke/snacks.nvim/blob/main/docs/gitbrowse.md
      { "<leader>gb", function() Snacks.gitbrowse() end, desc = "Git browse current file." },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
      { "<leader>gD", function() Snacks.picker.git_diff({ base = "origin", group = true }) end, desc = "Git Diff (origin)" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
      { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
      { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
      { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
      -- https://github.com/folke/snacks.nvim/blob/main/docs/git.md
      -- https://github.com/folke/snacks.nvim/blob/main/docs/gh.md
      -- https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md

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
