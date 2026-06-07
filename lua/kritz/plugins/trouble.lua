return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        filters = {
            ignore_qt_compiler_arg = function(item, enabled)
                if not enabled then
                    return true
                end

                local message = item.item and item.item.message or ""
                return not message:match("^Unknown argument:%s*['\"]?%-mno%-direct%-extern%-access['\"]?")
            end,
        },
        modes = {
            diagnostics = {
                filter = {
                    ["not"] = {
                        ignore_qt_compiler_arg = true,
                    },
                },
            },
        },
    },
    keys = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section belowkeys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xq",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },

}
