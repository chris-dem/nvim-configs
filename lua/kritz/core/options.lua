vim.cmd("let g:netrw_liststyle = 3")

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true


vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.background = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = true
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.opt.conceallevel = 2


vim.g.no_default_scala_ftplugin = 1 -- Disables /runtime/ftplugin/scala.vim

vim.g._jukit_python_os_cmd      = 'python3'
vim.opt.listchars               = { space = '·', tab = '->', eol = '↵', trail = '~' }
vim.opt.list                    = true
vim.g.vim_markdown_frontmatter  = 0
vim.spell.spelllang             = 'en_gb'
vim.opt.spellfile               = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
