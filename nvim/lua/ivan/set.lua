vim.g.statusline = "%-{y} %-{f} %-{m} %-{h} %-{r}"

vim.opt.formatoptions = "cqj"
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- colorscheme options
vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = true
vim.g.nord_bold = true
vim.g.nord_uniform_diff_background = true


vim.g.vimwiki_hl_headers = 1
vim.g.vimwiki_folding = 'expr'

require('nord').set()

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.coq_settings = {
    auto_start = 'shut-up',
}

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true
vim.opt.cursorcolumn = false


vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 1000

vim.opt.textwidth = 120


