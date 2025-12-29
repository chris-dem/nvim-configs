require("kritz.remap")
require("kritz.set")
require("kritz.lazy")

vim.g._jukit_python_os_cmd = 'python3'
vim.opt.listchars = { space = '·',tab='->', eol = '↵',trail = '~'}
vim.opt.list = true
vim.g.vim_markdown_frontmatter = 0
vim.spell.spelllang = 'en_gb'
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
vim.g.vimtex_view_method = 'skim'
-- vim.g.minimap_width = 5
-- vim.g.minimap_auto_start = 1
-- vim.g.minimap_auto_start_win_enter = 2
