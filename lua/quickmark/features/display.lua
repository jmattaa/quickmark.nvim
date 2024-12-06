require("quickmark.utils")
local window_utils = require("quickmark.window_utils")
local constants = require("quickmark.constants")

local managment = require("quickmark.features.management")
local quickmarks = managment.quickmarks

-- DO I REALLY HAVE TO IGNORE THE FILENAME IDK
-- maybe TODO; make ignore filename config?????
local function display_quickmarks(filename)
    local startl = 0
    for i = 1, #quickmarks do -- to get length of a "table" (ARRAY!!) we use #
        -- well thats very readable
        -- imma stay with c in the future
        if quickmarks[i] ~= filename or #quickmarks == 1 then -- dont show the current line
            window_utils.print_to_buf(quickmarks[i], startl, -1)
            startl = startl + 1
        end
    end
end

local function quickmarks_list()
    local filename = vim.fn.expand('%:~:.')
    window_utils.open_window()

    if (#quickmarks == 0) then
        quickmarks = { constants.initial_msg }
    end

    -- very inefficient ik (gotta fix this)
    -- !TODO: FIX ITTTTT!
    display_quickmarks(filename)
    window_utils.resize_window()
    display_quickmarks(filename)

    -- set cursor to right pos
    window_utils.move_cursor(0)
    window_utils.set_mappings()
end

return {
    quickmarks_list = quickmarks_list,
}
