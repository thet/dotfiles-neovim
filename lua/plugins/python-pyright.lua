if true then
  return {}
end
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              -- Add your buildout directories here
              extraPaths = {
                "src",
                --"eggs",
                "parts/omelette",
              },

              verboseOutput = true,

              -- optional: make analysis more thorough
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      },
    },
  },
}
