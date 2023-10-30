local api = vim.api

local window_utils = require("quickmark.window_utils")
local utils = require("quickmark.utils")
local mappings = require("quickmark.mappings")

local quickmarks_f = ".quickmarks"
-- array with all quickmarks
-- lua calls it table eww
-- it's ARRAY
local initial_msg = "   -- EMPTY --"
local quickmarks_loaded_file = table.load_file(quickmarks_f) or {{ initial_msg }, {}}

local quickmarks = quickmarks_loaded_file[1] -- why u starting at 1 :(
local shortcuts = quickmarks_loaded_file[2]

local function display_quickmarks(filename)
    local startl = 0
    for i = 1, #quickmarks do -- to get lenght of a "table" (ARRAY!!) we use #
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

    -- very inneficient ik (gotta fix this)
    -- !TODO: FIX ITTTTT!
    display_quickmarks(filename)
    window_utils.resize_window()
    display_quickmarks(filename)

    -- set cursor to right pos
    window_utils.move_cursor(0)
    window_utils.set_mappings()
end

local function quickmark_add()
    local filename = vim.fn.expand('%:~:.')

    -- if its empty don't add it
    if filename == "" then
        vim.cmd [[
            echohl ErrorMsg
            echo "Quickmark: cannot add empty filename to quickmarks"
            echohl None
        ]]
        return
    end

    for i = 1, #quickmarks do
        if quickmarks[i] == filename then
            vim.cmd [[
                echohl ErrorMsg
                echo "Quickmark: Quickmark already exists"
                echohl None
            ]]
            return
        elseif quickmarks[i] == initial_msg then -- remove the first initial empty string
            table.remove(quickmarks, i)
        end
    end

    table.insert(quickmarks, filename)
    table.insert(shortcuts, '')
    print(filename .. " added")
end

local function quickmark_shortcut(key)
    local filename = vim.fn.expand('%:~:.')
    local shortcut = tostring(key)

    local shortcut_index = -1

    for i = 1, #quickmarks do
        if quickmarks[i] == filename then
            shortcut_index = i
        end
    end

    -- there is no file in quickmark list
    if shortcut_index == -1 then
        quickmark_add()
        shortcut_index = #quickmarks -- it is placed at the end
    end

    table.remove(shortcuts, shortcut_index)
    table.insert(shortcuts, shortcut_index, shortcut)
end

local function quickmark_getShortcuts()
    return { shortcuts, quickmarks }
end

local function quickmarks_removeall()
    quickmarks = { initial_msg }
    shortcuts = {}
    os.remove(quickmarks_f)
    print("Quickmark: All quickmarks removed")
end

-- removes current file from quickmarks
local function quickmark_remove()
    local filename = vim.fn.expand('%:~:.')
    for i = 1, #quickmarks do
        if quickmarks[i] == filename then
            table.remove(quickmarks, i)
            table.remove(shortcuts, i)
            print(filename .. " removed from quickmarks")
            break
        end
    end
    -- it's the last quickmark so we remove EVERYTHING
    -- so the file that is left behind
    if #quickmarks == 0 then
        quickmarks_removeall()
    end
end

local function quickmarks_save()
    table.save_file({quickmarks, shortcuts}, quickmarks_f)
    print("Quickmark: quickmarks saved")
end

-- open file under cursor
local function open_file()
    local str = api.nvim_get_current_line()
    if #quickmarks < 1 or str == initial_msg then -- list is empty
        window_utils.close_window()
        return
    end
    window_utils.close_window()
    api.nvim_command('edit ' .. str)
end

local function move_file(dir)
    -- take the file the cursor is on
    local current_file = api.nvim_get_current_line()
    if #quickmarks < 1 or current_file == initial_msg then -- list is empty
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
    quickmarks_list = quickmarks_list,
    quickmark_add = quickmark_add,
    quickmark_shortcut = quickmark_shortcut,
    quickmark_getShortcuts = quickmark_getShortcuts,
    quickmark_remove = quickmark_remove,
    quickmarks_removeall = quickmarks_removeall,
    close_window = window_utils.close_window,
    move_cursor = window_utils.move_cursor,
    move_file = move_file,
    open_file = open_file,
    quickmarks_save = quickmarks_save,
}
