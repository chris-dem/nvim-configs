-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


return require('lazy').setup({

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },

    -- {
    --     'rose-pine/neovim',
    --     name = 'rose-pine',
    --     config = function()
    --         vim.cmd("colorscheme rose-pine")
    --     end
    -- },

    "nvim-lua/plenary.nvim", -- don't forget to add this one if you don't have it yet!bla
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { { "nvim-lua/plenary.nvim" } }
    },

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'nvim-treesitter/playground',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'neovim/nvim-lspconfig',
    { 'mason-org/mason.nvim',            opts = {} },
    { 'mason-org/mason-lspconfig.nvim' },
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lua',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'vonheikemen/lsp-zero.nvim',
    {
        "mg979/vim-visual-multi",
        branch = "master",
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional
        }
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    'OmniSharp/omnisharp-vim',
    -- install with yarn or npm
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    'pbrisbin/vim-mkdir',
    'godlygeek/tabular',
    {
        "lukas-reineke/indent-blankline.nvim",
        buftype_exclude = { filetypes = { "dashboard" } },
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        buftype_exclude = { filetypes = { "dashboard" } },
    },
    'vimjas/vim-python-pep8-indent',
    { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        buftype_exclude = { filetypes = { "dashboard" } },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope.nvim',
            'hrsh7th/nvim-cmp',
        }
    },
    {
        "NvChad/nvterm",
        config = function(_, opts)
            require("nvterm").setup(opts)
        end,
    },
    "wfxr/minimap.vim",
    {
        "NvChad/nvim-colorizer.lua",
        event = "User FilePost",
        config = function(_, opts)
            require("colorizer").setup(opts)

            -- execute colorizer as soon as possible
            vim.defer_fn(function()
                require("colorizer").attach_to_buffer(0)
            end, 0)
        end,
    },
    'f-person/git-blame.nvim',
    -- { 'Exafunction/codeium.vim'},
    {
        "folke/noice.nvim",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        init = function()
            vim.g.rustaceanvim = {}
        end,
        lazy = false
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Trouble",
        opts = {
            diagnostics = { auto_open = true }
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

    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require('nvim-autopairs.rule')

            npairs.setup({
                check_ts = true,
                ts_config = {
                    lua = { 'string' }, -- it will not add a pair on that treesitter node
                    javascript = { 'template_string' },
                    java = false,       -- don't check treesitter on java
                }
            })

            local ts_conds = require('nvim-autopairs.ts-conds')

            -- press % => %% only while inside a comment or string
            npairs.add_rules({
                Rule("%", "%", "lua")
                    :with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
                Rule("$", "$", "lua")
                    :with_pair(ts_conds.is_not_ts_node({ 'function' }))
            })
        end
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            terminal_colours = false,
        },
    },
    {
        "kkoomen/vim-doge",
    },
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        keys = {
            { "<leader>le", "<cmd>VimtexErrors<cr>", desc = "View Tex Errors", ft = "tex" },
        }
    },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'mfussenegger/nvim-dap',
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = 'VeryLazy',
        requires = {
            "mason-org/mason.nvim",
            "mfussenegger/nvim-dap",
        }
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    {
        "benfowler/telescope-luasnip.nvim",
        module = "telescope._extensions.luasnip", -- if you wish to lazy-load
    },
    {
        'mrcjkb/haskell-tools.nvim',
        version = '^6', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },
    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            "jmbuhr/otter.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "amitds1997/remote-nvim.nvim",
        version = "*",                       -- Pin to GitHub releases
        dependencies = {
            "nvim-lua/plenary.nvim",         -- For standard functions
            "MunifTanjim/nui.nvim",          -- To build the plugin UI
            "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
        },
        config = function()
            require("remote-nvim").setup({
                ssh_config = {
                    -- These are useful for password-based SSH authentication.
                    -- It provides parsing pattern for the plugin to detect that an input is requested.
                    -- Each element contains the following attributes:
                    -- match - The string to match (plain matching is done)
                    -- type - Supports two values "plain"|"secret". Secret means when you provide the value, it should not be stored in the completion history of Neovim.
                    -- value - Default value for the prompt
                    -- value_type - "static"|"dynamic". For things like password, it would be needed for each new connection that the plugin initiates which could be obtrusive.
                    -- So, we save the value (only for current session's interval) to ease the process. If set to "dynamic", we do not save the value even for the session. You have to provide a fresh value each time.
                    ssh_prompts = {
                        {
                            match = "Password",
                            type = "secret",
                            value_type = "static",
                            value = "",
                        },
                        {
                            match = "continue connecting (yes/no/[fingerprint])?",
                            type = "plain",
                            value_type = "static",
                            value = "",
                        },
                        { -- Handle SSH-key with passphrases
                            match = "Verification code",
                            type = "secret",
                            value_type = "static",
                            value = "",
                        },
                        -- There are other values here which can be checked in lua/remote-nvim/init.lua
                    },
                },
            })
        end,
    },
    {
        "scalameta/nvim-metals",
        name = "metals",
        ft = { "scala", "sbt", "java" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- stylua: ignore
        keys = {
            { "<leader>cW", function() require('metals').hover_worksheet() end,               desc = "Metals Worksheet" },
            { "<leader>cM", function() require('telescope').extensions.metals.commands() end, desc = "Telescope Metals Commands" },
        },
        config = function()
            local metals_config = require("metals").bare_config()

            metals_config.settings = {
                showImplicitArguments = true,
                showImplicitConversionsAndClasses = true,
                showInferredType = true,
                superMethodLensesEnabled = true,
            }
            metals_config.init_options.statusBarProvider = "on"
            metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()





            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "scala", "sbt", "java" },
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end,
    },
})
