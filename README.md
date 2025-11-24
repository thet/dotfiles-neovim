# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Installation

Preconditions:

```bash
npm install\
    markdownlint-cli2
    markdown-toc
```

## cheatsheet

query the value for a setting:

```vim
set parameter?
```

Query a buffer variable:

```vim
:echo b:variable_name
```

Check editorconfig status:

```vim
:echo b:editorconfg
```

```vim
:checkhealth
:LspInfo
```

## documentation

https://github.com/folke/lazy.nvim
https://www.lazyvim.org/

https://www.lazyvim.org/keymaps

https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

https://neovim.io/doc/user/diagnostic.html

https://neovim.io/doc/user/lsp.html

https://neovim.io/doc/user/lua-guide.html

## References

vim search multiple words at once
e.g. `/\vsite-(home|logo)` for site-home and site-logo
https://gemini.google.com/app/4c8980443182ab26

translate vim script to lazyvim lua
https://chatgpt.com/c/68f69bcf-1ba0-8333-827e-a0bf0726e11b

Configuring copilot and disabling for secret files:
https://chatgpt.com/c/691f4ebd-c96c-8008-8a37-363945f9f0cf

Force dark background LazyVim
https://chatgpt.com/c/6912342c-13b4-8331-88ae-c167b7bf0a57

LazyVim options:
https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

https://github.com/neovim/nvim-lspconfig

markdownlint-cli2 / Markdownlint rules
<https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md#md034---bare-url-used>
<https://pymarkdown.readthedocs.io/en/stable/plugins/rule_md034/>

GnuPG plugins
<https://vimawesome.com/plugin/gnupg-vim>
<https://github.com/jamessan/vim-gnupg>

gitsigns-nvim
<https://vimawesome.com/plugin/gitsigns-nvim>
<https://github.com/lewis6991/gitsigns.nvim>
<https://www.lazyvim.org/plugins/editor#gitsignsnvim>

Copilot
<https://www.lazyvim.org/extras/ai/copilot>
<https://github.com/zbirenbaum/copilot.lua>

outline.nvim
<https://www.lazyvim.org/extras/editor/outline#outlinenvim>
<https://github.com/hedyhli/outline.nvim>

edgy.nvim - window layouts
<https://www.lazyvim.org/extras/editor/outline#edgynvim-optional>
<https://github.com/folke/edgy.nvim>

https://github.com/nvim-neo-tree/neo-tree.nvim
https://github.com/SmiteshP/nvim-navic
https://github.com/nvim-mini/mini.diff
https://github.com/gbprod/yanky.nvim
https://github.com/mbbill/undotree

https://github.com/chrisjsewell/rst-language-server
https://pypi.org/project/rst-language-server/
