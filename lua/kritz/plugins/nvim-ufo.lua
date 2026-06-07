return {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
        local ignore_types = { dashboard = '' }
        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return ignore_types[filetype] or { 'treesitter', 'indent' }
            end
        })
    end
}
