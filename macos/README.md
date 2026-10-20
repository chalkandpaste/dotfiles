# Fresh Mac dev setup

Installed 2026-09-15 on Apple Silicon macOS. This configuration is in `~/dotfiles/macos`, on the `fresh-macos-2026` branch. The original repository files remain available for reference. Use this directory rather than the old root `setup.sh`.

## Install on another Mac

Install the Apple command-line tools and [Homebrew](https://brew.sh/) first, then:

```sh
git clone https://github.com/chalkandpaste/dotfiles.git ~/dotfiles
cd ~/dotfiles
git switch fresh-macos-2026
brew bundle --file=macos/Brewfile
git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
python3 macos/apply.py
exec /bin/zsh -l
```

If either repository already exists, fetch it instead of cloning it. `apply.py` moves any files it replaces into a timestamped directory under `macos/backups`; review those backups before deleting them. The checked-in iTerm profile becomes available automatically through iTerm's Dynamic Profiles directory and is set as the default. If iTerm was open during setup, quit and reopen it before creating a new window.

## Installed

- macOS zsh + fresh Prezto, Paradox prompt, Emacs bindings, autosuggestions, syntax highlighting, completion and substring history search.
- Neovim 0.12.5, Tomorrow Night, four-space indentation (two for Haskell), transparent background, backslash leader.
- Neovim packages: base16-vim, fzf.vim, vim-fugitive and vim-surround. Built-in netrw file browser and `gc` commenting. Language servers can be added for the languages you actually use.
- tmux 3.7c with mouse support, true color, clipboard integration and one-based windows.
- ripgrep, fd, jq, and fzf 0.74.4. Git is supplied by the Apple command-line tools.
- iTerm profile **Chalk Dev**: your archived appearance values, fresh Droid Sans Mono Dotted for Powerline 12, Option keys configured as Esc+ for Neovim Alt mappings. The profile is saved as the default.

## Use

Open a new iTerm window. Existing shells can load the setup with `exec /bin/zsh -l`.

Shell: Ctrl-R searches history; Ctrl-T searches files; Alt-C selects a directory.

Neovim (`vim`, `vi`, or `nvim`):

| Keys | Action |
|---|---|
| `\` then Space | Find files |
| `\b` then Space | Find buffers |
| `\rg` | Search project text |
| `\f` | File browser |
| `\gs` | Git status |
| `\gd` | Git diff |
| `\w` | Save |
| `\` then Enter | Clear search highlighting |
| Ctrl-h/j/k/l | Move between splits |
| Alt-s / Alt-v | Horizontal / vertical split |
| `\y`, `\p`, `\d` | System clipboard operations |
| `gcc` / visual `gc` | Comment line / selection |

Tmux: prefix Ctrl-b; `|` or `-` splits panes; `c` creates a window; `r` reloads config. Copy mode uses Vim keys and `y` copies to the macOS clipboard.

## Maintenance

Edit the files here; the live configs are symlinked. `python3 ~/dotfiles/macos/apply.py` recreates links and backs up any replaced entries under `macos/backups`. The font is a regular file in `~/Library/Fonts` for macOS discovery.

Prezto is a separate fresh Git checkout at `~/.zprezto`; `zprezto-update` updates it. Plugin source URLs and installed revisions are recorded in `sources.json`; the Neovim plugin files are vendored under `nvim-pack`.

fzf uses its official release binary with verified SHA-256 and its matching source runtime in `tools/fzf`. Homebrew could not build fzf within this task's nested sandbox, so it is not registered as a Homebrew formula. The Brewfile describes the normal Homebrew installation for a future setup.

Homebrew also could not run the certificate package post-install hooks inside the nested sandbox. To finish those ancillary hooks, run this in your own terminal:

```sh
brew postinstall ca-certificates openssl@3
```

No archived executable code, shell history, credentials, or sessions were restored. The old archive was read only.

## Verification

Verified clean zsh startup and a real interactive Paradox prompt, fzf Ctrl-R binding and filtering, autosuggestions, Neovim theme/plugin loading and file writes, and an isolated tmux session. Font Book lists Droid Sans Mono Dotted for Powerline. iTerm loaded Chalk Dev and its default GUID was saved; open a new window to use it. If the existing app retains the old default in memory, choose Chalk Dev from Profiles or restart iTerm when your sessions are safe to close.

## Detailed differences and latest adjustments

See [CHANGES.md](CHANGES.md) for the archived-local versus fresh configuration audit. Neovim now uses four-space indentation, except Haskell/literate Haskell (two). In netrw, single-click selects and double-click opens or expands; the former netrw special mouse actions are disabled. Restart Neovim for the changed settings.

## Buffer deletion

`:BD` deletes the current buffer while preserving its split windows and tabs; it refuses unsaved changes. `:BD!` discards unsaved changes. Windows show the alternate/another listed editing buffer, or a new empty buffer if necessary. `\bd` and Alt-q invoke `:BD`; Alt-Shift-q invokes `:BD!`.
