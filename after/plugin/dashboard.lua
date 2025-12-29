local dashboard = require('dashboard')

local second_brain_telescope = function ()
    vim.cmd('cd ~/notes/Knowledge-Base/personal/')
    vim.cmd('Telescope find_files find_command=rg,--hidden,--files')
    end

local second_brain_new_file = function ()
    vim.cmd('cd ~/notes/Knowledge-Base/personal/0-zet-inbox/')
    vim.cmd('ObsidianNew')
    end

local edit_vim_dotfiles = function ()
    vim.cmd('cd ~/.config/nvim/')
    vim.cmd('Telescope find_files find_command=rg,--hidden,--files')
    end

dashboard.setup {
    theme = 'hyper',
    config = {
        shortcut = {
            -- action can be a function type
            -- { desc = string, group = 'highlight group', key = 'shortcut key', action = 'action when you press key' },
            { desc = 'Open Second brain', icon = "🧠", key = 'b', action = second_brain_telescope },
            { desc = 'Edit Vim Dotfiles', icon = "🗒️", key = 'v', action = edit_vim_dotfiles },
            { desc = 'Open Fleeting Note', icon = "🧠🗒️", key = 'n', action = second_brain_new_file },
            { desc = 'Open File Tree', icon = "🌳", key = 't', action =  "NvimTreeToggle"},
        },
        packages = { enable = true }, -- show how many plugins neovim loaded
        -- limit how many projects list, action when you press key or enter it will run this action.
        -- action can be a functino type, e.g.
        -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
        project = { enable = true, limit = 8, icon = '🗄️', label = 'Find files', action = 'Telescope find_files cwd=' },
        mru = { limit = 10, icon = '📁', label = 'Recently opened files', cwd_only = false },
        footer = {}, -- footer
    },
}

vim.keymap.set("n", "<leader>hm", vim.cmd.Dashboard)
