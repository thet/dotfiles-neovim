return {
  cmd = { "ty", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", ".git" },
  settings = {
    ty = {
      environment = {
        -- Path to Python executable (ty will use its site-packages)
        python = "python",
        -- Or explicitly set extra search paths
        pythonSearchPaths = {
          "./src",
          "./sources",
          "./parts/omelette",
        },
      },
      src = {
        root = "./src",
      },
    },
  },
}
