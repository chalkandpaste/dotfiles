#!/usr/bin/env python3
"""Apply reviewed config, moving existing entries to a dated backup first."""
from pathlib import Path
from datetime import datetime
import shutil

base = Path(__file__).resolve().parent
home = Path.home()
backup = base / 'backups' / datetime.now().strftime('%Y%m%d-%H%M%S-%f')

def link(source, destination):
    source = base / source
    destination = home / destination
    if destination.is_symlink() and destination.resolve() == source.resolve():
        return
    if destination.exists() or destination.is_symlink():
        saved = backup / destination.relative_to(home)
        saved.parent.mkdir(parents=True, exist_ok=True)
        shutil.move(str(destination), str(saved))
        print('Backed up:', destination)
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.symlink_to(source)
    print('Linked:', destination)

for source, destination in [
    ('zprofile', '.zprofile'),
    ('zshrc', '.zshrc'),
    ('zpreztorc', '.zpreztorc'),
    ('tmux.conf', '.tmux.conf'),
    ('init.lua', '.config/nvim/init.lua'),
    ('nvim-pack/dev', '.config/nvim/pack/dev'),
    ('tools/fzf', '.config/nvim/vendor/fzf'),
    ('iterm2.json', 'Library/Application Support/iTerm2/DynamicProfiles/chalk-dev.json'),
]:
    link(source, destination)

# macOS font discovery expects an actual font file.
font = base / "fonts/Droid Sans Mono Dotted for Powerline.ttf"
font_target = home / "Library/Fonts" / font.name
font_target.parent.mkdir(parents=True, exist_ok=True)
if not font_target.exists():
    shutil.copy2(font, font_target)
