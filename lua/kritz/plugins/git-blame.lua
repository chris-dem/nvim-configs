return {
    'f-person/git-blame.nvim',
    enable = true,
    config = function()
        vim.keymap.set("n", "<leader>gt", vim.cmd.GitBlameToggle)
    end
}
