# dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io). Work in progress toward a modern, TUI-first shell environment.

## Workflow

Chezmoi manages dotfiles by storing them in this repo with a `dot_` prefix (so `dot_bashrc` becomes `~/.bashrc` on the target machine). Changes flow in two directions:

**Editing a dotfile:**
```sh
chezmoi edit ~/.bashrc        # opens the source file in your editor
chezmoi apply                 # applies changes to the home directory
```

**Pulling in a change from home directory:**
```sh
chezmoi add ~/.some_new_file  # begins tracking a file
chezmoi diff                  # review pending changes
chezmoi apply
```

**Syncing to a new machine:**
```sh
chezmoi init https://github.com/davidbirdsong/dotfiles
chezmoi apply
```

**Keeping in sync across machines:**
```sh
chezmoi update    # git pull + apply in one step
```

Changes you want to persist back to the repo are committed and pushed from `~/.local/share/chezmoi` like any other git repo.

## Shell

Bash with vi keybindings (`set -o vi`). The config is split into focused RC files sourced from `~/.bashrc`:

| File | Purpose |
|---|---|
| `~/.history.rc` | History tuning and Ctrl-R picker |
| `~/.pickers.rc` | File and ripgrep pickers |
| `~/.bash_completion.rc` | Completion setup |
| `~/.git_ps1.rc` | Git branch prompt |
| `~/.git_spice_ps1.rc` | Git-spice aware prompt (shows branch and its base) |
| `~/.mise.rc` | Mise completions |

## Pickers

Three keyboard shortcuts wire fzf into the shell for interactive search. All insert their result directly into the readline buffer rather than running a command, so they compose naturally with whatever you are typing.

### Ctrl-R: History search

Custom replacement for the default Ctrl-R binding. Before searching, it merges history from other live sessions. Entries are then ranked by a combined score:

```
score = (frequency * 10) + recency
```

Commands you run often and recently float to the top. The result is previewed inline and inserted into the current command line.

### Ctrl-F: File picker

Uses `fd` to enumerate files (hidden files included, `.git` excluded, symlinks followed) and previews each selection with `bat` for syntax-highlighted output. The selected path is appended to the current readline buffer.

### Ctrl-G: Ripgrep picker

A live, interactive ripgrep search. As you type, `rg` reruns against your query and updates the list. Results are shown as `file:line:content`. Selecting an entry inserts `file +line` into the buffer, ready to pass to your editor.

Preview is rendered by `bat` with the matching line highlighted.

```
Ctrl-R    ranked history search
Ctrl-F    file picker (fd + fzf + bat)
Ctrl-G    content search (rg + fzf + bat)
```

Navigation inside fzf uses `ctrl-j` / `ctrl-k` (down/up) and `ctrl-d` / `ctrl-u` (half-page).

## Tools

The Brewfile tracks the full dependency list. Key pieces of the stack:

| Tool | Role |
|---|---|
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder, backbone of all pickers |
| [fd](https://github.com/sharkdp/fd) | Fast file enumeration |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Content search engine |
| [bat](https://github.com/sharkdp/bat) | Syntax-highlighted previews |
| [lazygit](https://github.com/jesseduffield/lazygit) | Git TUI |
| [git-spice](https://github.com/abhinav/git-spice) | Stacked branch workflow |
| [mise](https://mise.jdx.dev) | Polyglot tool version management |
| [neovim](https://neovim.io) | Editor (managed via mise) |

## Version management

Mise wraps Go, Node, Python, Ruby, Pulumi, biome, golangci-lint, and make. The wrappers in `~/.bashrc` ensure the correct version is active per project without needing to manually activate environments.

## Status

This is an active work in progress. The goal is a cohesive TUI-first workflow where file navigation, history, and search all flow through keyboard-driven, composable tools rather than GUI applications.
