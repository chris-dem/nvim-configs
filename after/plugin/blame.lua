require('gitblame').setup {
     --Note how the `gitblame_` prefix is omitted in `setup`
    enabled = false,
}

vim.keymap.set("n", "<leader>gt",vim.cmd.GitBlameToggle)
