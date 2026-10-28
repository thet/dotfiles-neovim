-- https://github.com/stevearc/conform.nvim

-- https://www.lazyvim.org/plugins/formatting
-- https://www.lazyvim.org/extras/formatting/biome
-- https://www.lazyvim.org/extras/formatting/black
-- https://www.lazyvim.org/extras/formatting/prettier

-- https://prettier.io/
-- https://github.com/prettier/prettier

-- https://black.readthedocs.io/en/stable/
-- https://github.com/psf/black
-- https://pypi.org/project/black/

-- https://github.com/stylelint/stylelint
-- https://stylelint.io/

-- https://github.com/patrickvane/shfmt
-- https://github.com/JohnnyMorganz/StyLua

return {
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>f",
        function()
          -- No lsp_format here, so the per-filetype setting below applies.
          require("conform").format({ timeout_ms = 3000 })
        end,
        mode = { "n", "x" },
        desc = "Format",
      },
    },
    opts = {
      formatters = {
        markdownlint = {
          prepend_args = { "--disable", "MD034" },
        },
        zpretty = {
          command = "zpretty",
          -- Format buffer contents via stdin; -i is only for on-disk files.
          stdin = true,
          args = function(_, ctx)
            -- ZCML buffers use the xml filetype, but need their own style.
            if vim.fn.fnamemodify(ctx.filename, ":e") == "zcml" then
              return { "-z" }
            elseif vim.bo[ctx.buf].filetype == "xml" then
              return { "-x" }
            end
            return {}
          end,
        },
        prettier = {
          -- Prettier reads `.gitignore` and `.prettierignore` from its cwd
          -- and silently skips ignored files. In multi-repository setups
          -- the outer repository usually ignores `/src`, which contains the
          -- package checkouts. So only respect `.prettierignore`, from the
          -- package root.
          prepend_args = { "--ignore-path", ".prettierignore" },
          cwd = require("conform.util").root_file({ ".prettierignore", ".git" }),
        },
      },
      formatters_by_ft = {
        ["lua"] = { "stylua" },
        ["sh"] = { "shfmt" },
        ["bash"] = { "shfmt" },
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
        ["vue"] = { "prettier" },
        ["css"] = { "prettier", "stylelint" },
        ["scss"] = { "prettier", "stylelint" },
        ["less"] = { "prettier" },
        ["json"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["graphql"] = { "prettier" },
        ["markdown"] = { "markdownlint" },

        ["python"] = { "isort", "black" },
        ["rust"] = { "rustfmt", lsp_format = "fallback" },

        -- Page templates (*.pt, *.cpt, *.zpt) use xhtml; *.zcml uses xml.
        ["html"] = { "zpretty" },
        ["xml"] = { "zpretty" },
        ["xhtml"] = { "zpretty" },
      },
    },
  },
}
