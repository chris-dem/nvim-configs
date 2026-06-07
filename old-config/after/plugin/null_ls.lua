local null_ls = require("null-ls")
local lsp_zero = require("lsp-zero")

null_ls.setup({
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
    },
    on_attach = lsp_zero.on_attach,
})
