return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local nvimtree = require("nvim-tree")

        nvimtree.setup({
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            reload_on_bufenter = true,
            view = {
                side = "left",
                width = 35,
                preserve_window_proportions = true,
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                    resize_window = true,
                },
            },
            renderer = {
                highlight_opened_files = "all",
            },
            tab = {
                sync = {
                    open = false,
                    close = false,
                    ignore = {},
                },
            },
        })
        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end


        local api = require("nvim-tree.api")

        vim.keymap.set('n', '<leader>q', api.tree.toggle)
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', '<C-r>', api.tree.reload)
        vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', '<leader>ttf', vim.cmd.NvimTreeFindFile)
    end,
}
