-- https://github.com/mfussenegger/nvim-lint
-- https://github.com/stylelint/stylelint
-- https://stylelint.io/
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          args = { "--stdin", "--disable", "MD034" },
        },
      },
      linters_by_ft = {
        ["*"] = { "editorconfig-checker" }, -- Report .editorconfig violations in every filetype.
        css = { "stylelint" },
        scss = { "stylelint" },
        less = { "stylelint" },
        markdown = { "markdownlint" },
      },
    },
  },
}
