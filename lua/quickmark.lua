local M = {}

local config = require("quickmark.config")

function M.setup(user_config)
    config.setup(user_config)

    for action, mapping in pairs(config.options.key_mappings) do
        if action == "shortcut" then
            vim.api.nvim_set_keymap('n', mapping,
                ':lua require("quickmark").create_shortcut()<CR>',
                { noremap = true, silent = true })
        elseif action == "open_shortcut" then
            vim.api.nvim_set_keymap('n', mapping,
                ':lua require("quickmark").open_shortcut()<CR>',
                { noremap = true, silent = true })
        else
            vim.api.nvim_set_keymap('n', mapping,
                string.format(':Quickmark %s<CR>', action),
                { noremap = true, silent = true })
        end
    end
end

M.quickmarks_list = require("quickmark.features.display").quickmarks_list
M.quickmark_add = require("quickmark.features.management").quickmark_add
M.quickmark_remove_f = require("quickmark.features.management").quickmark_remove_f
M.quickmarks_removeall = require("quickmark.features.management").quickmarks_removeall
M.quickmarks_save = require("quickmark.features.management").quickmarks_save
M.create_shortcut = require("quickmark.features.management").create_shortcut
M.open_shortcut = require("quickmark.features.management").open_shortcut
M.close_window = require("quickmark.window_utils").close_window
M.move_cursor = require("quickmark.window_utils").move_cursor
M.move_file = require("quickmark.window_utils").move_file
M.open_file = require("quickmark.features.operations").open_file
M.remove_quickmark_win_i =
    require("quickmark.features.operations").remove_quickmark_win_i

return M
