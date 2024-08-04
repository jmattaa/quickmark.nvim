local api = vim.api
local window_utils = require("quickmark.window_utils")
local quickmarks_list = require("quickmark.features.display").quickmarks_list
local quickmarks_save = require("quickmark.features.management").quickmarks_save
local constants = require("quickmark.constants")

local quickmarks_loaded_file = table.load_file(constants.quickmarks_f) or {{ constants.initial_msg }, {}}

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

local function move_file(dir)
    -- take the file the cursor is on
    local current_file = api.nvim_get_current_line()
    if #quickmarks < 1 or current_file == constants.initial_msg then -- list is empty
        window_utils.close_window()
        return
    end
    -- move it according to dir
    local idx = -1
    for i = 0, #quickmarks do
        if quickmarks[i] == current_file then
            idx = i
            break
        end
    end
    if idx == -1 then
        window_utils.close_window()
        vim.cmd [[
            echohl ErrorMsg
            echo "Quickmark: Unexpected error"
            echohl None
        ]]
        return
    elseif idx + dir <= 0 or idx + dir > #quickmarks then
        return
    end
    -- update the list
    local temp = quickmarks[idx]
    -- hehe you see me big brain the + dir thats math
    -- like the test i have tomorrow
    quickmarks[idx] = quickmarks[idx + dir]
    quickmarks[idx + dir] = temp
    -- update the window
    window_utils.close_window()
    quickmarks_list()
    window_utils.set_cursor(idx + dir) -- me smarte
    quickmarks_save()
end

return {
    open_file = open_file,
    move_file = move_file,
}
