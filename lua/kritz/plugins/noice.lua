return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    keys = {
        { "<leader>nf", function() require("noice").cmd("telescope") end, desc = "Noice telescope" },
        { "<leader>nd", function() require("noice").cmd("dismiss") end,   desc = "Noice dismiss" },
    },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
        highlight = {
            enabled = false, -- kill treesitter highlighting in noice entirely
        },
    },
    -- no config function needed — lazy.nvim will call require("noice").setup(opts) for you
}
