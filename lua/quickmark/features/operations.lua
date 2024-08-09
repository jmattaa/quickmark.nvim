local api = vim.api
local window_utils = require("quickmark.window_utils")
local constants = require("quickmark.constants")
local quickmark_remove_i =
    require("quickmark.features.management").quickmark_remove_i
local quickmark_list = require("quickmark.features.display").quickmarks_list

local quickmarks_loaded_file = table.load_file(constants.quickmarks_f) or { { constants.initial_msg }, {} }

local quickmarks = quickmarks_loaded_file[1]

-- open file under cursor
local function open_file()
    local str = api.nvim_get_current_line()
    if #quickmarks < 1 or str == constants.initial_msg then -- list is empty
        window_utils.close_window()
        return
    end
    window_utils.close_window()
    api.nvim_command('edit ' .. str)
end

-- remove the quickmark with index at current cursor position
local function remove_quickmark_win_i()
    local str = api.nvim_get_current_line()
    local i, _ = unpack(vim.api.nvim_win_get_cursor(0))
    if #quickmarks < 1 or str == constants.initial_msg then -- list is empty
        window_utils.close_window()
        return
    end

    vim.cmd('echohl QuickmarkInfo | echo "Confirm removal of quickmark for file'
        .. ' <' .. str .. '>"' .. ' | echohl None')
    vim.cmd('echohl QuickmarkInfo | echo "[y(es), n(o)]" | echohl None')

    -- Prompt the user for input
    local confirm = vim.fn.input("")
    if confirm ~= "y" then return end

    -- TODO: Find a more efficient way to update the window content
    -- without closing doing something and then opening again
    -- cuz we be doin this somewhere else too i remoember
    window_utils.close_window()
    quickmark_remove_i(i)
    quickmark_list()
end

return {
    open_file = open_file,
    remove_quickmark_win_i = remove_quickmark_win_i,
}
