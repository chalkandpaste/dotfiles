# Exact configuration audit

Comparison: the archived **local** dotfiles, rather than only the 2020 GitHub checkout, versus the fresh setup. Archived code was read as text, never sourced. “Removed” below means absent from the active new config; the original files remain in the archive and the GitHub checkout. Presence of an old plugin or command is not proof that it worked on the old machine. Old Neovim defaults were not measured by running the archived installation.

## Corrections made during this audit

- Default `tabstop`, `shiftwidth` and `softtabstop`: 4, with spaces rather than literal tabs.
- Haskell and literate Haskell: all three widths set to 2 after filetype detection. Verified `.txt`, `.py`, `.js`, `.lua`, `.hs`, `.lhs` buffers.
- Keep netrw. Disable its special mouse mappings, which used single-click to open and double-click to go up a directory. Set a buffer-local double-click mapping to its Enter action instead. Single-click now only selects; double-click opens a file or expands/collapses a directory. This also removes netrw's special right-click-delete, middle-click-open and shift-click-mark behavior; keyboard operations remain.
- No other behavior described below was restored during the audit. In particular, netrw still lacks the old Git status badges and current-file-reveal wrapper.

## Neovim: behavior differences

| Area | Archived local configuration | Fresh configuration |
|---|---|---|
| Configuration | Vimscript `vim/vimrc` via `init.vim`; vim-plug | Lua `macos/init.lua`; four vendored start packages plus fzf runtime |
| Plugin installation | vim-plug bootstrap/`:PlugInstall`/`:PlugUpdate` | Explicitly installed snapshots; no automatic download/update at startup |
| Indentation | `expandtab`, `tabstop=2`, `shiftwidth=2`; no explicit softtabstop | Initially 2 everywhere; corrected to 4, Haskell/literate Haskell 2; explicit softtabstop |
| Indent rounding | `shiftround` enabled | Disabled; `>` does not round to a shiftwidth boundary |
| Smart indentation | No explicit autoindent/smartindent (lines commented) | `smartindent=true`; current Neovim autoindent true |
| File browser | NERDTree + Git status extension | netrw tree view, left sidebar, 25% width; no Git status badges |
| Browser launch | `\f` closed an open tree, otherwise revealed the current file with NERDTreeFind; Alt-w toggled | Both invoke Lexplore on the working directory; no explicit current-file reveal |
| Browser hidden files | Explicit `NERDTreeShowHidden=1` | No explicit hidden-file filtering; native netrw defaults |
| File finding | CtrlP mappings, including hidden-file and ignore settings, but no CtrlP plugin declaration or installed directory | Working fzf.vim Files/Buffers; old CtrlP filtering and hidden-file configuration not translated |
| Search | ag.vim and custom Git grep wrapper | `rg` grepprg and fzf `:Rg`; no GGrep wrapper |
| Whitespace markers | `list` and custom listchars commented out locally | `list=true`: tabs `» `, trailing spaces `·`, nonbreaking spaces `+` |
| Vertical movement | `j`/`k` mapped to `gj`/`gk` (display rows) | Native j/k (logical lines) |
| Cursor position | BufReadPost restored last position | That restoration autocmd omitted |
| Buffer close | Alt-q/Alt-Shift-q invoked BufKill `:BD`/`:BD!` to preserve layout; `\bd` called `:Bd`, which the installed BufKill did not define | Native `:bdelete`, which may close a window |
| Mode coverage | Many `map`/`noremap` bindings covered normal, visual and operator-pending modes | Most replacements are normal-mode-only; clipboard maps cover normal and visual |
| Leader timeout | `timeoutlen=2000` | Current default 1000 ms |
| Status/tab line | Airline, its buffer/tab line; status line per window (`laststatus=2`) | Simple global status line (`laststatus=3`); Airline buffer/tab line absent |
| Search/selection styling | White on salmon Search highlight; Visual linked to Search | Theme defaults |
| Cursor styling | Explicit red block, no normal-mode blinking | Current Neovim cursor defaults; insert mode bar |
| Bracket matching | `showmatch`, `matchtime=2` | No explicit showmatch; current false, matchtime 5 |
| Sign column | Linked to LineNr; Syntastic sign colors | Always visible, transparent; no Syntastic signs |
| Conceal | Conceal highlight cleared; custom Haskell conceal variables | Theme/runtime defaults |
| Folding | Indent folds, nest max 5, level 99; Vim files used marker folds at level 0 | Indent folds, level 99; current nest max 20; Vim-specific override omitted |
| Wrapping | wrap + linebreak; textwidth 500 | wrap remains; linebreak false, textwidth 0 |
| Crossing line boundaries | whichwrap added arrows and h/l | Default `b,s`; those added keys no longer wrap |
| Command completion | `wildmode=list:longest,full` | Current default `full` |
| Insert completion | Added `longest` to completeopt | Explicit `menu,menuone,noselect`; no completion-engine setup |
| Formatting | External par at 72 columns; Haskell formatprg stylish-haskell | Empty formatprg; external formatting integration absent |
| Haskell save hook | Stripped trailing whitespace from `*.hs` | Omitted |
| File safety | backup off, writebackup off, swapfile off | backup still off; writebackup and swapfile enabled by current defaults |
| Undo | undotree plugin declared; no explicit persistent-undo setting | `undofile=true`; undo persists, but no graphical undo tree |
| Command history | Explicit 700 entries | Current Neovim default 10000 |
| Redraw | lazyredraw enabled | Default false |
| Idle update interval | No explicit setting | 250 ms |
| Window title | title enabled | Default false |
| Bell | noerrorbells + visualbell enabled | Current visualbell false; old terminal bell overrides absent |
| Diff orientation | diffopt explicitly added vertical | Default diffopt without vertical; new Gdiffsplit may therefore use a different orientation |
| File format detection | unix,dos,mac | Current unix,dos |
| Tags | `tags;/,codex.tags;/`, Haskell tagbar config, hscope hookup | Default `./tags;,tags`; custom tag/hscope config removed |
| Include search | BufRead added current file's directory to path | Autocmd removed |
| Reload/local overrides | Saving `.vimrc` sourced MYVIMRC; optional `.vimrc.local` loaded | Neither hook; archived `.vimrc.local` was absent |
| Editor PATH | Appended `~/.local/bin` inside Vim | No such append; inherits clean shell PATH |
| GUI-only legacy settings | MacVim Monaco 19, GUI toolbar/tab tweaks | Removed; iTerm controls terminal font |

### Preserved behavior

Backslash leader, Tomorrow Night, true color, transparent normal background, line numbers, column-100 guide, scrolloff 7, ignorecase + smartcase, incremental/highlighted searching, mouse enabled, indent folding starting unfolded, normal-mode Ctrl-h/j/k/l and Alt-h/j/k/l split navigation, Alt-s/Alt-v split creation, `\bp`/`\bn`, and clear-search shortcut. Auto-read, hidden buffers, normal wrapping, UTF-8, smarttab, ruler, and ordinary syntax/filetype support remain through explicit settings or current Neovim defaults. `Q` remains disabled.

Clipboard mappings changed from register `*` to `+`; on macOS both use the system clipboard provider. The old `\<Enter>` also reapplied red cursor styling and had a Haskell diagnostics-clearing override; the new command only clears search highlighting.

### Removed mappings and command wrappers

- `,,` repeat-character-search convenience.
- `\r` redraw; `\ma`/`\mo` mouse on/off.
- `\e` edit prompt prefilled with current file directory.
- `\u` GundoToggle (the configured plugin was undotree, not Gundo).
- Visual `*`/`#` search for selected text, plus VisualSelection/CmdLine helper functions.
- `j`/`k` display-row movement.
- Alt-q/Alt-Shift-q window-preserving buffer deletion (`:BD`/`:BD!`, defined by the archived BufKill plugin). The separate `\bd` mapping called `:Bd`, which that plugin did not define.
- `\sh`, `\sl`, `\sk`, `\sj` directional split creation; `\bo` close other windows.
- `\ss` spellcheck toggle.
- `\a=`, `\a,`, `\a|`, `\ap` alignment mappings. They called `:Align`, while the declared plugin was Tabular.
- `\tg` legacy Haskell codex/hscope tag generation; `\tt` Tagbar; Ctrl-backslash cscope lookup.
- `\gg` custom GGrep quickfix search; `\gl` Extradite history; `\gb` blame shortcut; `\g?` latest-commit file list. Fugitive itself remains, so underlying Git operations are still available through commands.
- Haskell `\ht`, `\hT`, `\hc`, `\hl`, `\hh`, `\hH`, `\hi`, `\hI`, `\hz`, visual `\h.` and `\h>`: types, lint/checks, Hoogle and pointfree/pointful conversions.

Changed mappings: CtrlP/Buffer become Files/Buffers; tree mappings become Lexplore; `\gs` becomes `:Git`, `\gd` becomes `:Gdiffsplit`; `\bd` becomes native bdelete. Added `\w` as an actual save mapping (old file mentioned it in a comment but did not define it) and `\rg` for Rg.

### Configured versus functional old Haskell support

The archive had Haskell syntax, stylish-haskell, Syntastic, Tagbar, async.vim and vim-lsp plugin directories. A HIE language server was only registered if `hie-wrapper` existed. GhcMod, neco-ghc and Hoogle mappings/configuration referenced plugins that were commented out in the declarations. SuperTab was already commented out locally, including its Ctrl-Space mappings, although its old directory remained on disk. Therefore these are removed declarations/mappings, not evidence of a fully functioning prior IDE. Ordinary built-in Haskell syntax remains in Neovim; the new configuration supplies no Haskell language server, linting, formatter or type-query setup.

## Shell configuration differences

### zshrc and zprofile

- Retains Prezto, Paradox, and `vi`/`vim` aliases to nvim.
- Loads a fresh standalone `~/.zprezto` checkout, rather than the old dotfiles submodule.
- Moves prompt selection into zpreztorc. Previously zpreztorc selected Sorin and zshrc then overrode it with Paradox; effective theme stays Paradox.
- Removes obsolete `NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim` export line. The trailing `nvim` was also treated as an export name; this did not launch the editor.
- Replaces a PATH reset with additive, deduplicated paths. Adds Apple Silicon Homebrew and the locally installed fzf bin directory. Does not explicitly add Miniconda, old `/home/chalkandpaste/.local/bin`, `~/.local/bin`, Foundry, Linux games/snap directories, `~/bin`, `~/sbin`, MacPorts, or Intel Homebrew directories. Some system paths may still be inherited; this is not a guaranteed ban on those paths.
- Removes four hardcoded credential exports from archived zshrc. Values are excluded from this audit.
- Collapses repeated `brew shellenv` calls into login initialization; current Prezto homebrew module also caches HOMEBREW variables.
- Explicitly sets EDITOR and VISUAL to nvim, and LANG to en_US.UTF-8. Previously the profile only supplied nano/LANG defaults when unset.
- Omits profile defaults for BROWSER=open, PAGER=less, LESS options and optional LESSOPEN/lesspipe setup. Their effective value may still come from the environment or framework.
- Only explicitly deduplicates the `path` array, rather than cdpath/fpath/mailpath/path together.
- Overrides Prezto `ll='ls -lh'` with `ll='ls -lah'`, so ll includes dotfiles plus `.`/`..`; aliases derived from ll can inherit the change.
- Adds fzf interactive Ctrl-R, Ctrl-T and Alt-C bindings. Ctrl-R is now fzf history search instead of the previous history-search widget. Ctrl-T/Alt-C replace normal Emacs transpose-characters/capitalize-word actions. Fzf setup runs only in an interactive terminal with line editing.

### Omitted startup files

- No new `.zshenv`: old top-level non-login/non-interactive shells conditionally sourced `.zprofile`; that bootstrap is absent. Four duplicate Foundry PATH appends in archived zshenv were omitted.
- No new `.zlogin`: completion-cache byte compilation in the background and optional fortune greeting are absent.
- No new `.zlogout`: the custom randomly chosen Douglas Adams/Truman farewell is absent.

### zpreztorc

The set of 14 explicitly requested modules is identical. Original order:

```
environment terminal editor history directory spectrum utility
syntax-highlighting completion prompt autosuggestions git
history-substring-search homebrew
```

New order:

```
environment terminal editor history directory spectrum utility
homebrew completion git prompt syntax-highlighting autosuggestions
history-substring-search
```

Color remains enabled; editing remains Emacs-style. History storage changes from the framework default 10,000 to an explicit 50,000 entries. No history was restored. All the other old zpreztorc examples were commented out, so deleting those comments did not remove enabled behavior.

## Prezto source update, separate from our settings

Archive checkout: `6e564503f1c5e6ddba2bcf5d9065e5872ca207d2`.
Fresh checkout: `cff2d01871425b1b80710f8ec6a475c5a53145b4`.

In the loaded module sources:

- Paradox/git-info now escape evaluated Git ref/remote and virtualenv strings before displaying them.
- `gwC`: `git clean --force` becomes `git clean -d --force` — now includes untracked directories.
- Adds `gWa`, `gWl`, `gWx`, `gWX`, `gWm`, `gWc` for worktree add/list/remove/forced remove/move/prune.
- `glS` now uses topological order and Prezto's medium log format with signatures.
- Colored diff is limited to terminal output and preserves diff's exit status.
- ls detection recognizes uutils and reuses its version check.
- bindkey-all iteration, named-color initialization, and updater directory changes received small implementation fixes.
- Other shipped prompt themes received escaping changes; they are not selected.

External modules:

| Module | Strict change |
|---|---|
| Autosuggestions | Same pinned commit and identical file contents |
| History substring search | Different commit, but only README changed; executable contents identical |
| Syntax highlighting | Updated redirection recognition and caffeinate handling; version file 0.8.0 → 0.8.1-dev |
| Extra completions | Many completion definitions added, removed or updated; full source diff supplied separately |

This is a source/configuration audit. The former zsh/Neovim executables and complete old environment were not run, so it does not claim to enumerate every behavioral difference between their old and new software versions.

## Complete plugin inventory

Retained/reinstalled: base16-vim, vim-fugitive, vim-surround. Fzf remains as a separate matching binary/runtime. Added fzf.vim.

Previously enabled declarations absent from the new active setup:

- `tpope/vim-obsession`
- `coot/atp_vim`
- `parkr/vim-jekyll`
- `bling/vim-airline`
- `flazz/vim-colorschemes`
- `junegunn/limelight.vim`
- `christoomey/vim-conflicted`
- `vim-scripts/gitignore`
- `int3/vim-extradite`
- `Xuyuanp/nerdtree-git-plugin`
- `rking/ag.vim`
- `mbbill/undotree`
- `scrooloose/nerdcommenter`
- `scrooloose/nerdtree`
- `tpope/vim-unimpaired`
- `vim-scripts/bufkill.vim`
- `scrooloose/syntastic`
- `nathanaelkane/vim-indent-guides`
- `majutsushi/tagbar`
- `Shougo/vimproc.vim`
- `godlygeek/tabular`
- `michaeljsmith/vim-indent-object`
- `easymotion/vim-easymotion`
- `prabirshrestha/async.vim`
- `prabirshrestha/vim-lsp`
- `neovimhaskell/haskell-vim`
- `nbouscal/vim-stylish-haskell`
- `vim-denops/denops.vim`
- `nekowasabi/claudecode.vim`
- `git@github.com:chalkandpaste/atlas-foundry-agent`

SuperTab was already disabled in the archived local config; it was enabled in the older GitHub version.

## Raw old mappings for line-by-line inspection

This is a static inventory, including conditional/filetype-specific declarations. It is not executed.

```vim
31: noremap ,, ,
43: nnoremap Q <nop>
215: map <silent> <leader>r :redraw!<CR>
218: nnoremap <leader>ma :set mouse=a<cr>
221: nnoremap <leader>mo :set mouse=<cr>
311: nmap <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
314: nmap <silent> <leader>u :GundoToggle<CR>
317: nnoremap <silent> <Leader><space> :CtrlP<CR>
351: nmap <leader>y "*y
352: vmap <leader>y "*y
353: nmap <leader>d "*d
354: vmap <leader>d "*d
355: nmap <leader>p "*p
356: vmap <leader>p "*p
364: vnoremap <silent> * :call VisualSelection('f', '')<CR>
365: vnoremap <silent> # :call VisualSelection('b', '')<CR>
372: nnoremap j gj
373: nnoremap k gk
375: noremap <c-h> <c-w>h
376: noremap <c-k> <c-w>k
377: noremap <c-j> <c-w>j
378: noremap <c-l> <c-w>l
382: noremap <A-s> <esc><c-w>s
383: noremap <A-v> <esc><c-w>v
384: noremap <A-h> <esc><c-w>h
385: noremap <A-j> <esc><c-w>j
386: noremap <A-k> <esc><c-w>k
387: noremap <A-l> <esc><c-w>l
389: noremap <A-q> <esc>:BD<CR>
390: noremap <A-Q> <esc>:BD!<CR>
395: nmap <silent> <leader><cr> :noh\|hi Cursor guibg=red<cr>
414: nmap <leader>sh :leftabove  vnew<CR>
415: nmap <leader>sl :rightbelow vnew<CR>
416: nmap <leader>sk :leftabove  new<CR>
417: nmap <leader>sj :rightbelow new<CR>
431: nnoremap <leader>bp :bp<cr>
432: nnoremap <leader>bn :bn<cr>
435: nnoremap <leader>bo <c-w>o
438: noremap <leader>bd :Bd<cr>
441: noremap <leader>b<space> :CtrlPBuffer<cr>
471: map <leader>ss :setlocal spell!<cr>
526: nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
528: nmap <silent> <A-w> <ESC>:NERDTreeToggle<CR>
553: map <Leader>a= :Align =<CR>
555: map <Leader>a, :Align ,<CR>
557: map <Leader>a<bar> :Align <bar><CR>
559: map <leader>ap :Align
603: map <leader>tg :!codex update --force<CR>:call system("git-hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>
605: map <leader>tt :TagbarToggle<CR>
611: nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
639: nmap <leader>gs :Gstatus<CR>
640: nmap <leader>gg :copen<CR>:GGrep
641: nmap <leader>gl :Extradite!<CR>
642: nmap <leader>gd :Gdiff<CR>
643: nmap <leader>gb :Gblame<CR>
659: nnoremap <silent> <leader>g? :call CommittedFiles()<CR>:copen<CR>
724: nmap <silent> <leader>ht :GhcModType<CR>
726: nmap <silent> <leader>hT :GhcModTypeInsert<CR>
728: nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>
747: nmap <silent> <leader>hl :SyntasticCheck hlint<CR>
750: nnoremap <silent> <leader>hh :Hoogle<CR>
753: nnoremap <leader>hH :Hoogle
756: nnoremap <silent> <leader>hi :HoogleInfo<CR>
759: nnoremap <leader>hI :HoogleInfo
762: nnoremap <silent> <leader>hz :HoogleClose<CR>
771: vnoremap <silent> <leader>h. :call Pointfree()<CR>
776: vnoremap <silent> <leader>h> :call Pointful()<CR>
```

## Subsequent restoration: buffer deletion

The omissions above describe the initial setup. `:BD` and `:BD!` have now been restored as local Lua commands preserving split windows and tabs. `\bd`, Alt-q and Alt-Shift-q use them. `:BD` refuses a modified buffer; `:BD!` discards changes. The old BufKill plugin itself was not added.
