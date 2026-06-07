-- May or may not be needed strictly
--[[return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    buftype_exclude = { filetypes = { "dashboard" } },
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format.with({
            extra_args = { '--style', "{IndentWidth: 4}" }
        }),
        null_ls.builtins.completion.spell,
        -- null_ls.builtins.diagnostics.write_good,
        null_ls.builtins.diagnostics.pylint,
        -- null_ls.builtins.formatting.codespell.with({
        --     filetypes={ "markdown", "text", "latex" },
        -- }),
        -- null_ls.builtins.diagnostics.codespell.with({
        --     filetypes={ "markdown", "text", "latex" },
        -- }),
        null_ls.builtins.formatting.prettier.with({
            filetypes = { "json", "jsonc", "javascript", "typescript", "html", "css", "vue" },
        }),
    }
}]]
