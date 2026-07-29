# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Installation

Preconditions:

```bash
npm install\
    markdownlint-cli2
    markdown-toc

sudo apt install\
    fdfind\
    gh\
    ripgrep\
    luarocks
```

Node packages:

```bash
pnpm install \
    "@agentclientprotocol/claude-agent-acp" \
    "@anthropic-ai/claude-code" \
    "@github/copilot" \
    "@google/gemini-cli" \
    "@openai/codex" \
    "@zed-industries/codex-acp" \
    "copilot-api"

# Run post-install script for claude
node run node_modules/@anthropic-ai/claude-code/install.cjs
```

With this setup running, log in to Copilot via:

```
:Copilot auth
```

Maybe necessary:

```bash
claude auth login

copilot auth

copilot-api auth
copilot-api start

ollama
ollama run codestral:22b
ollama run gemmat:12b
```

## Keymap cheatsheet

NOTE: Keymaps can change. This info might not be accurate.

`:Lazy` - Open LazyVim page. Then press `U` to run upgrades
`:Mason` - Open Mason dependency installer. Then run `U` for upgrades.

```
,< ... file history
,> ... session history
```

### Diagnostic messages

```
[d ... previous message
]d ... next message
,cd ... Open floating window with full diagnostic message
,xd ... Open diagnostics quickfix list
,p ... Toggle inlay hints (custom binding)
```

### Tab pages

https://neovim.io/doc/user/tabpage/#tabpage

```
:tabnew
:tabclose

:tabn
:tabnext

:tabp
:tabprevious

:tabm
:+tabmove
:tabmove +
:tabmove -
```

### Sort blocks

https://superuser.com/a/752821/404355

```vim
:g/BLOCK_START/,/BLOCK_END/s/\n/§
:%sort
%s/§/\r/g
```

```vim
:g/<utility/,/\/>/s/\n/§
:%sort
%s/§/\r/g
```

### Search/Replace

https://linuxize.com/post/vim-find-replace/

```vim
:%s/foo/bar/g
```

### GV

`:GV` - to open commit browser
`:GV!` - will only list commits that affected the current file
`:GV?` - fills the location list with the revisions of the current file

`:GV` or `:GV?` can be used in visual mode to track the changes in the selected lines.
Mappings

`o` or `<cr>` on a commit to display the content of it
`o` or `<cr>` on commits to display the diff in the range
`O` opens a new tab instead
`gb` for `:GBrowse`
`]]` and `[[` to move between commits
`.` to start command-line with `:Git [CURSOR] SHA` à la fugitive
`q` or `gq` to close

## CodeCompanion cheatsheet

https://codecompanion.olimorris.dev/usage/chat-buffer/slash-commands#mcp
https://codecompanion.olimorris.dev/usage/chat-buffer/agents-tools#mcp
https://codecompanion.olimorris.dev/usage/chat-buffer/#keymaps

If you want to use local LLMs provided by ollama, start ollama first!

```
ollama
```

General chat

```
:CodeCompanionChat adapter=copilot
```

```
<CR>, <C-s> ... Send prompt in normal mode
<C-CR> ... Send prompt in insert mode

} ... next chat
{ ... prev chat

gm ... send a "btw" message while tool execution
ga ... Switch adapter mid-session
# ... invoke variable completion menu
@ ... invoke tool completion menu
\ ... ACP tool native command completion menu
/acp_session_options
```

History. Normal mode / insert mode.

```
gh ... history
r / <M-r> ... rename
d / <M-d> ... delete
<C-y> / <C-y> ... duplicate
```

### ACP mode

```
:CodeCompanionChat adapter=codex
```

### MCP

MCP chrome_devtools configured for codex.
Example prompt:

```
Please connect to localhost:3000 via the provided chrome_devtools MCP server and tell me, if you can render the page.
```

Actions and tools:

```
/mcp -- start MCP servers
@ -- Start tools menu. E.g.:
@{mcp:chrome_devtools}

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

Install new plugin spec dependencies

```vim
Lazy sync
```

https://neovim.io/doc/user/terminal.html

```vim
:terminal
```

Relative vs absolute line numbers:
https://jeffkreeftmeijer.com/vim-number/

```vim
set relativenumber
set rnu

set norelativenumber
set nornu

set number
set nu

set nonumber
set nonu

set rnu nu   " Set hybridnumber
set rnu! nu! " Toggle hybridnumber
```

Move a block
https://neovim.io/doc/user/motion.html
https://vim.fandom.com/wiki/Moving_lines_up_or_down

```vim
:m 12  " move current line to after line 12
:m 0   " move current line to before first line
:m $   " move current line to after last line

:5,7m 21   " move lines 5, 6 and 7 to after line 21
:,+4m 21 " move 5 lines starting at current line to after line 21
```

## Debugging

```vim
:checkhealth
:checkhealth lsp
:checkhealth mason
:LspInfo
:LspLog
```

### Performance issues

Debugging performance issues:

```bash
nvim --startuptime output.txt

# https://neovim.io/doc/user/starting.html#-V
nvim -V
```

#### Profiling

https://www.reddit.com/r/neovim/comments/6j4wri/debugging_slowness/
https://stackoverflow.com/questions/12213597/how-to-see-which-plugins-are-making-vim-slow

You can use built-in profiling support: after launching vim do

```vim
:profile start profile.log
:profile func *
:profile file *
" At this point do slow actions
:profile pause
:noautocmd qall!
```

## documentation

diagnostics:
https://neovim.io/doc/user/diagnostic/

https://github.com/folke/lazy.nvim
https://www.lazyvim.org/

https://www.lazyvim.org/keymaps

https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

https://neovim.io/doc/user/diagnostic.html

https://neovim.io/doc/user/lsp.html

https://neovim.io/doc/user/lua-guide.html

## References

https://github.com/rockerBOO/awesome-neovim

### AI code completion

https://www.reddit.com/r/neovim/comments/1hjhdnb/alternative_to_github_copilot_plugin/

https://supermaven.com/
https://github.com/supermaven-inc/supermaven-nvim

https://github.com/Exafunction/windsurf.vim
https://dev.to/jonatas-sas/inline-ai-suggestions-in-neovim-github-copilot-vs-windsurf-codeium-a-technical-comparative-4b7l

https://github.com/milanglacier/minuet-ai.nvim#providers
https://github.com/monkoose/neocodeium

https://github.com/zbirenbaum/copilot.lua

https://github.com/GeorgesAlkhouri/nvim-aider
https://aider.chat/docs/install/optional.html

### More AI

https://github.com/ColinKennedy/neovim-ai-plugins

https://codecompanion.olimorris.dev/usage/inline
https://github.com/yetone/avante.nvim
https://github.com/greggh/claude-code.nvim

### Other

vim search multiple words
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
https://github.com/rebelot/heirline.nvim
https://github.com/j-hui/fidget.nvim

https://github.com/chrisjsewell/rst-language-server
https://pypi.org/project/rst-language-server/

### NeoVim distributions

https://www.lazyvim.org/
https://astronvim.com/
