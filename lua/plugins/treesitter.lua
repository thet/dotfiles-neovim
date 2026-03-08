return {
  -- Comprehensive Treesitter configuration for all languages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      -- Add all the languages you mentioned plus common additional ones
      vim.list_extend(opts.ensure_installed, {
        -- Core languages you specified
        "python",
        "html",
        "css",
        "javascript",
        "typescript",
        "xml",
        "lua",
        "vim", -- VimScript
        "vimdoc", -- Vim help files
        "rust",
        "go",
        "bash",
        "sql",

        -- Additional parsers for better language support
        "tsx", -- TypeScript JSX
        "jsx", -- JavaScript JSX
        "json", -- JSON files
        "json5", -- JSON5 files
        "jsonc", -- JSON with comments
        "yaml", -- YAML files
        "toml", -- TOML files (common in Rust/Python projects)
        "markdown", -- Markdown files
        "markdown_inline", -- Inline markdown
        "regex", -- Regular expressions
        "query", -- Treesitter queries

        -- Web development related
        "scss", -- SCSS/Sass
        "svelte", -- Svelte (from your other config)

        -- Configuration and data formats
        "dockerfile", -- Docker files
        "gitignore", -- .gitignore files
        "gitcommit", -- Git commit messages
        "diff", -- Diff files

        -- Documentation
        "rst", -- reStructuredText (Python docs)
        "latex", -- LaTeX

        -- Other useful languages
        "c", -- C language
        "cpp", -- C++
        "make", -- Makefiles
        "cmake", -- CMake
        "ninja", -- Ninja build files
      })

      -- Configure additional Treesitter settings
      opts.highlight = opts.highlight or {}
      opts.highlight.enable = true
      opts.highlight.additional_vim_regex_highlighting = false

      opts.indent = opts.indent or {}
      opts.indent.enable = true

      opts.incremental_selection = opts.incremental_selection or {}
      opts.incremental_selection.enable = true
      opts.incremental_selection.keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<C-s>",
        node_decremental = "<M-space>",
      }

      return opts
    end,

    init = function()
      -- File type associations
      vim.filetype.add({
        extension = {
          -- Ensure proper file type detection
          rs = "rust",
          go = "go",
          py = "python",
          js = "javascript",
          ts = "typescript",
          jsx = "javascriptreact",
          tsx = "typescriptreact",
          lua = "lua",
          vim = "vim",
          sh = "sh",
          bash = "bash",
          sql = "sql",
          html = "html",
          htm = "html",
          xhtml = "html",
          xml = "xml",
          css = "css",
          scss = "scss",
          sass = "sass",
          json = "json",
          jsonc = "jsonc",
          yaml = "yaml",
          yml = "yaml",
          toml = "toml",
          md = "markdown",
          dockerfile = "dockerfile",
        },
        filename = {
          ["Dockerfile"] = "dockerfile",
          [".dockerignore"] = "gitignore",
          [".gitignore"] = "gitignore",
          ["go.mod"] = "gomod",
          ["go.sum"] = "gosum",
          ["Cargo.toml"] = "toml",
          ["Cargo.lock"] = "toml",
          ["pyproject.toml"] = "toml",
        },
        pattern = {
          ["%.env%..*"] = "sh",
          [".*%.dockerfile"] = "dockerfile",
        },
      })
    end,
  },
}
