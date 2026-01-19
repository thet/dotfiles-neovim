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
