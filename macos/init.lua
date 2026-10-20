-- Small Neovim setup retaining the old dotfiles' editing preferences.
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'
local o = vim.opt
o.number = true
o.termguicolors = true
o.background = 'dark'
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.smartindent = true
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true
o.scrolloff = 7
o.colorcolumn = '100'
o.splitright = true
o.splitbelow = true
o.mouse = 'a'
o.undofile = true
o.signcolumn = 'yes'
o.updatetime = 250
o.completeopt = { 'menu', 'menuone', 'noselect' }
o.foldmethod = 'indent'
o.foldlevelstart = 99
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '+' }
o.laststatus = 3
o.statusline = ' %f %m%r %= %y  %l:%c  %p%% '
o.grepprg = 'rg --vimgrep --smart-case'
o.grepformat = '%f:%l:%c:%m'

-- fzf's Vim runtime is supplied by its installed distribution.
for _, runtime in ipairs({ '/opt/homebrew/opt/fzf', vim.fn.expand('~/.config/nvim/vendor/fzf') }) do
  if vim.fn.isdirectory(runtime) == 1 then o.runtimepath:prepend(runtime) end
end
vim.cmd('packloadall')
vim.cmd.colorscheme('base16-tomorrow-night')
for _, group in ipairs({ 'Normal', 'NormalNC', 'SignColumn', 'EndOfBuffer' }) do
  vim.api.nvim_set_hl(0, group, { bg = 'NONE' })
end

-- Delete the current buffer without removing any of its windows.
vim.api.nvim_create_user_command('BD', function(opts)
    local target = vim.api.nvim_get_current_buf()
    if vim.bo[target].modified and not opts.bang then
        error('Buffer has unsaved changes; use :BD! to discard them')
    end

    local function usable(buf)
        return buf ~= target and vim.api.nvim_buf_is_valid(buf)
            and vim.bo[buf].buflisted and vim.bo[buf].buftype == ''
    end

    local replacement = vim.fn.bufnr('#')
    if not usable(replacement) then
        replacement = nil
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if usable(buf) then
                replacement = buf
                break
            end
        end
    end

    local windows = vim.fn.win_findbuf(target)
    if not replacement and #windows > 0 then
        replacement = vim.api.nvim_create_buf(true, false)
    end
    for _, win in ipairs(windows) do
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_set_buf(win, replacement)
        end
    end
    if vim.api.nvim_buf_is_valid(target) then
        vim.cmd.bdelete({ args = { tostring(target) }, bang = opts.bang })
    end
end, { bang = true, desc = 'Delete buffer, preserving windows; ! discards changes', force = true })

local function map(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { silent = true, desc = desc })
end
map('Q', '<Nop>', 'Disable Ex mode')
map('<leader>w', '<cmd>write<cr>', 'Save')
map('<leader><cr>', '<cmd>nohlsearch<cr>', 'Clear search highlighting')
map('<leader><space>', '<cmd>Files<cr>', 'Find files')
map('<leader>b<space>', '<cmd>Buffers<cr>', 'Find buffers')
map('<leader>rg', '<cmd>Rg<cr>', 'Search project text')
map('<leader>f', '<cmd>Lexplore<cr>', 'File browser')
map('<M-w>', '<cmd>Lexplore<cr>', 'File browser')
map('<leader>bn', '<cmd>bnext<cr>', 'Next buffer')
map('<leader>bp', '<cmd>bprevious<cr>', 'Previous buffer')
map('<leader>bd', '<cmd>BD<cr>', 'Delete buffer, keeping split')
map('<M-q>', '<cmd>BD<cr>', 'Delete buffer, keeping split')
map('<M-Q>', '<cmd>BD!<cr>', 'Discard buffer, keeping split')
map('<leader>gs', '<cmd>Git<cr>', 'Git status')
map('<leader>gd', '<cmd>Gdiffsplit<cr>', 'Git diff')
map('<M-s>', '<cmd>split<cr>', 'Horizontal split')
map('<M-v>', '<cmd>vsplit<cr>', 'Vertical split')
for _, key in ipairs({ 'h', 'j', 'k', 'l' }) do
  map('<C-' .. key .. '>', '<C-w>' .. key, 'Move between windows')
  map('<M-' .. key .. '>', '<C-w>' .. key, 'Move between windows')
end
for _, key in ipairs({ 'y', 'p', 'd' }) do
  vim.keymap.set({ 'n', 'x' }, '<leader>' .. key, '"+' .. key, { desc = 'System clipboard ' .. key })
end
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
-- Netrw defaults to single-click open and double-click parent-directory.
-- Use conventional selection and double-click activation instead.
vim.g.netrw_mousemaps = 0
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('ChalkNetrwMouse', { clear = true }),
  pattern = 'netrw',
  callback = function(event)
    vim.keymap.set('n', '<2-LeftMouse>', '<CR>', {
      buffer = event.buf, remap = true, silent = true,
      desc = 'Open file or expand directory',
    })
  end,
})
vim.g.fzf_layout = { window = { width = 0.85, height = 0.8 } }
-- Use Neovim's built-in gc commenting; add language servers per project later.

-- Four spaces per indent, except Haskell's two-space convention.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('ChalkIndentation', { clear = true }),
  pattern = '*',
  callback = function(event)
    local width = (vim.bo[event.buf].filetype == 'haskell' or vim.bo[event.buf].filetype == 'lhaskell') and 2 or 4
    vim.bo[event.buf].expandtab = true
    vim.bo[event.buf].tabstop = width
    vim.bo[event.buf].shiftwidth = width
    vim.bo[event.buf].softtabstop = width
  end,
})
