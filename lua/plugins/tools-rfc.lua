-- Currently disabled, only to remeber that we want a `snacks` equivalent of
-- this rfc browser, eventually.
-- stylua: ignore
if true then return {} end

-- https://github.com/moniquelive/rfc.nvim
return {
  {
    "moniquelive/rfc.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("rfc")
    end,
  },
}
