local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.config.set_config({
  store_selection_keys = '<c-s>',
})


ls.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),
        snip({
            trig = "link",
            namr = "markdown_link",
            dscr = "Create markdown link [txt](url)"
        },
        {
            text('['),
            insert(1),
            text(']('),
            func(function(_, snip)
                return snip.env.TM_SELECTED_TEXT[1] or {}
            end, {}),
            text(')'),
            insert(0),
        }),
    }
})

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets/", }});
vim.keymap.set("n", "<leader>psn",function() vim.cmd.Telescope('luasnip') end)
