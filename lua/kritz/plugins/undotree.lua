vim.opt.undodir = "/Users/christosdemetriou/undodir"
return {
    'mbbill/undotree',
    config = function()
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
}
