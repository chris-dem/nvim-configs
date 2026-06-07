return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local rndr = require("rndr")

        telescope.setup({
            defaults = {
                buffer_previewer_maker = rndr.telescope_buffer_previewer_maker,
                file_ignore_patterns = {
                    "node_modules",
                    "vendor",
                    "build",
                    "%.git",
                },
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<C-t>"] = require("trouble.sources.telescope").open,
                    },
                },
            },
        })

        telescope.load_extension("fzf")
        require("telescope").load_extension("noice")
        require('telescope').load_extension('luasnip')
        require('telescope').load_extension('loogle')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end)
        vim.keymap.set('n', '<leader>pfc', builtin.lsp_document_symbols)
        vim.keymap.set('n', '<leader>pfw', builtin.lsp_workspace_symbols)
        vim.api.nvim_buf_set_keymap(
            0, "n", "<leader>tg",
            "<Cmd>lua require'telescope.builtin'.live_grep{ search_dirs = require'lean'.current_search_paths() }<CR>",
            { noremap = true }
        )
    end,
}
