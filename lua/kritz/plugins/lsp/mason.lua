-- Old configuration
--[[local servers = {
    -- lsp_zero.default_setup,
    lua_ls = lua_opts,

    pyright = {
        handlers = handlers,
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            client.server_capabilities.hoverProvider = true
            client.server_capabilities.signature_help = true
        end
    },
    uiua = {},
    ltex = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = lsp_zero.on_attach, -- Inherit keymaps
        cmd = { 'ltex-ls' },
        settings = {
            ltex = {
                language = 'en-GB',
                completionEnabled = true,
                dictionary = {
                    ['en-GB'] = words,
                },
                enabled = { 'latex', 'tex', 'bib', 'markdown' },
                diagnosticSeverity = 'information',
                sentenceCacheSize = 2000,
                additionalRules = { enablePickyRules = true, motherTongue = 'en-GB' },
                trace = { server = 'verbose' },
                disabledRules = { ['en-GB'] = { 'OXFORD_SPELLING_Z_NOT_S' } },
                hiddenFalsePositives = {}
            },
        },
    },
    texlab = {},
    ts_ls = {
        init_options = {
            plugins = {
                {
                    name = '@vue/typescript-plugin',
                    location = vim.fn.stdpath('data') ..
                        '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                    languages = { 'vue' },
                },
            },
        },
        filetypes = { 'javascript', 'typescript', 'vue' },
    },
    volar = {
        init_options = {
            vue = {
                hybridMode = false,
            }
        }
    },
    rust_analyzer = {},
}
]]


return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        local ensure_installed = {
            "lua_ls",
            "pyright",
            "uiua",
            "ltex",
            "ts_ls",
            "texlab",
            "html",
            "clangd",
            "rust_analyzer",
        }

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = ensure_installed,
        })
    end,
}


