return {
  {
    -- https://github.com/nvim-telescope/telescope.nvim
    -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
    -- https://github.com/nvim-telescope/telescope-ui-select.nvim
    -- https://github.com/nvim-telescope/telescope-github.nvim
    -- https://github.com/andrewberty/telescope-themes
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-github.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "andrewberty/telescope-themes",
    },
    opts = {
      --defaults = {
      --  layout_strategy = "horizontal",
      --  layout_config = {
      --    horizontal = {
      --      preview_width = 0.5,
      --    },
      --  },
      --},
      pickers = {
        buffers = {
          sort_mru = true,
          ignore_current_buffer = true,
        },
        find_files = {
          find_command = {
            "fdfind",
            "--type",
            "f",
            "--type",
            "d",
            "--follow",
            "--hidden",
            "--no-ignore",
            "--strip-cwd-prefix",
          },
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
      telescope.load_extension("gh")
      telescope.load_extension("themes")
    end,

    -- stylua: ignore
    keys = {
      -- find files
      { "<leader>,", "<cmd>Telescope buffers sort_mru=true ignore_current_buffer=true<CR>", desc = "Buffers" },
      { "<leader><", "<cmd>Telescope oldfiles<CR>", desc = "Recent" },
      { "<leader>.", "<cmd>Telescope find_files cwd=%:p:h<CR>", desc = "Find Files (cwd)" },
      { "<leader>/", "<cmd>Telescope find_files<CR>", desc = "Find Files (Root Dir)" },
      { "<leader>?", "<cmd>Telescope git_files<CR>", desc = "Find Files (git-files)" },

      -- Grep
      { "<leader>\\", "<cmd>Telescope live_grep<CR>", desc = "Grep (Root Dir)" },
      { "<leader>|", "<cmd>Telescope grep_string<CR>", desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
      { "<leader>]", "<cmd>Telescope live_grep cwd=%:p:h<CR>", desc = "Grep (cwd)" },
      { "<leader>}", "<cmd>Telescope grep_string cwd=%:p:h<CR>", desc = "Visual selection or word (cwd)", mode = { "n", "x" } },

      { "<leader>[", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer Lines" },
      { "<leader>{", function() require("telescope.builtin").live_grep({ grep_open_files = true }) end, desc = "Grep Open Buffers" },

      -- git
      { "<leader>gd", function() require("telescope.builtin").git_bcommits() end, desc = "Git Commits (buffer)" },
      { "<leader>gD", function() require("telescope.builtin").git_commits() end, desc = "Git Commits (all)" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git Status" },
      { "<leader>gi", function() require("telescope").extensions.gh.issues() end, desc = "GitHub Issues (open)" },
      { "<leader>gI", function() require("telescope").extenTuuusions.gh.issues({ state = "all" }) end, desc = "GitHub Issues (all)" },
      { "<leader>gp", function() require("telescope").extensions.gh.pull_requests() end, desc = "GitHub Pull Requests (open)" },
      { "<leader>gP", function() require("telescope").extensions.gh.pull_requests({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },

      -- search
      { '<leader>ss"', "<cmd>Telescope registers<CR>", desc = "Registers" },
      { '<leader>sh', "<cmd>Telescope search_history<CR>", desc = "Search History" },
      { "<leader>sc", "<cmd>Telescope commands<CR>", desc = "Commands" },
      { "<leader>sx", "<cmd>Telescope command_history<CR>", desc = "Command History" },
      { "<leader>sd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
      { "<leader>su", "<cmd>Telescope undo<CR>", desc = "Undo History" },

      -- ui
      { "<leader>c", "<cmd>Telescope themes<CR>", desc = "Theme switcher" },
    },
  },
}
