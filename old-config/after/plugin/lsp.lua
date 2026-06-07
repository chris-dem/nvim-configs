-- Old lsp config
local lsp_zero = require('lsp-zero')
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
                return client:supports_method(method, bufnr)
            else
                return client.supports_method(method, { bufnr = bufnr })
            end
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                end,
            })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            -- Enable inlay hints by default
            -- vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })

            -- Disable hints in insert mode, restore previous state when exiting
            local hint_group = vim.api.nvim_create_augroup('inlay-hint-toggle', { clear = false })
            local hints_enabled_before_insert = {}

            vim.api.nvim_create_autocmd('InsertEnter', {
                buffer = event.buf,
                group = hint_group,
                callback = function()
                    hints_enabled_before_insert[event.buf] = vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
                    vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
                end,
            })
            vim.api.nvim_create_autocmd('InsertLeave', {
                buffer = event.buf,
                group = hint_group,
                callback = function()
                    local was_enabled = hints_enabled_before_insert[event.buf]
                    if was_enabled ~= nil then
                        vim.lsp.inlay_hint.enable(was_enabled, { bufnr = event.buf })
                    end
                end,
            })
        end
    end,
})



lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    } or {},
    virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
}

local words = {}

for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
    table.insert(words, word)
end

require('mason').setup({})
local lua_opts = lsp_zero.nvim_lua_ls()
local servers = {
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
};


servers = vim.tbl_extend("force", servers, lsp_zero.nvim_lua_ls());

require('mason-lspconfig').setup {
    automatic_enable = vim.tbl_keys(servers or {}),
}



require('mason-lspconfig').setup {
    automatic_enable = vim.tbl_keys(servers or {}),
}


local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
    'stylua', -- Used to format Lua code
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

-- Installed LSPs are configured and enabled automatically with mason-lspconfig
-- The loop below is for overriding the default configuration of LSPs with the ones in the servers table
for server_name, config in pairs(servers) do
    vim.lsp.config(server_name, config)
end




require('mason-tool-installer').setup({
    ensure_installed = {
        'clang-format',
    }
})

require('mason-nvim-dap').setup({
    handlers = {},
    ensure_installed = {
        'codelldb'
    },
    automatic_installation = true,
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()
local compare = cmp.config.compare

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            local luasnip = require("luasnip")
            if not luasnip then
                return
            end
            luasnip.lsp_expand(args.body)
        end,
    },
})
