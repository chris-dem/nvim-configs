vim.g.vimtex_view_method                         = 'skim'
vim.g.vimtex_quickfix_mode                       = 2
vim.g.quickfix_open_on_warning                   = 0
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 10

return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    keys = {
        { "<leader>le", "<cmd>VimtexErrors<cr>", desc = "View Tex Errors", ft = "tex" },
    }
}
