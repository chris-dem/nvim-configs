return {
    "wfxr/minimap.vim",
    config = function()
        vim.keymap.set("n", "<leader>m", vim.cmd.MinimapToggle)
    end
}
