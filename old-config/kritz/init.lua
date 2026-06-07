require("kritz.remap")
require("kritz.set")
require("kritz.lazy")

vim.g._jukit_python_os_cmd     = 'python3'
vim.opt.listchars              = { space = '·', tab = '->', eol = '↵', trail = '~' }
vim.opt.list                   = true
vim.g.vim_markdown_frontmatter = 0
vim.spell.spelllang            = 'en_gb'
vim.opt.spellfile              = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
