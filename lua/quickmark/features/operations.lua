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

return {
    open_file = open_file,
}
