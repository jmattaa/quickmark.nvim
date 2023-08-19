local api = vim.api

local window_utils = require("quickmark.window_utils")
local utils = require("quickmark.utils")
local mappings = require("quickmark.mappings")

local quickmarks_f = ".quickmarks"
-- array with all quickmarks
-- lua calls it table eww
-- it's ARRAY
local quickmarks = table.load_file(quickmarks_f) or { "" }

local function display_quickmarks(filename)
    for i = 0, #quickmarks do -- to get lenght of a "table" (ARRAY!!) we use #
        -- well thats very readable
        -- imma stay with c in the future
        local startl = i + 3              -- shift down lines gotta make this a var
        local endl = startl + 1
        if quickmarks[i] ~= filename then -- dont show the current line
            window_utils.print_to_buf(quickmarks[i], startl, endl)
        end
    end
end

local function quickmarks_list()
    local filename = vim.fn.expand("%")
    local win = window_utils.open_window()
    if win == nil then
        return
    end

    window_utils.print_to_buf(
        "Press " .. utils.get_key_fom_val(mappings.mappings, 'close_window()') .. " to exit",
        0, -1
    )
    window_utils.print_to_buf(
        utils.center_str("Quickmarks"),
        1, -1
    )
    -- separator line
    local bufid = vim.fn.bufwinid(win.buf)
    local bufw = vim.fn.winwidth(bufid)
    window_utils.print_to_buf(
        string.rep('─', bufw),
        2, -1
    )

    api.nvim_buf_add_highlight(
        win.buf,
        -1,
        "QuickmarkInfo",
        0,
        0, -1
    )
    api.nvim_buf_add_highlight(
        win.buf,
        -1,
        "QuickmarkTitle",
        1,
        0, -1
    )

    display_quickmarks(filename)
    -- set cursor to right pos
    window_utils.move_cursor(0)
    window_utils.set_mappings()

    api.nvim_win_set_option(win.win, 'cursorline', true) -- Highlight the line the cursor is on
end

local function quickmark_add()
    local filename = vim.fn.expand('%')

    -- if its empty don't add it
    if filename == "" then
        vim.cmd [[
            echohl ErrorMsg
            echo "Quickmark: cannot add empty filename to quickmarks"
            echohl None
        ]]
        return
    end

    for i = 0, #quickmarks do
        if quickmarks[i] == filename then
            vim.cmd [[
                echohl ErrorMsg
                echo "Quickmark: Quickmark already exists"
                echohl None
            ]]
            return
        elseif quickmarks[i] == "" then -- remove the first initial empty string
            table.remove(quickmarks, i)
        end
    end

    table.insert(quickmarks, filename)
    print(filename .. " added")
end

-- removes current file from quickmarks
local function quickmark_remove()
    local filename = vim.fn.expand('%')
    for i = 0, #quickmarks do
        if quickmarks[i] == filename then
            table.remove(quickmarks, i)
            print(filename .. "removed from quickmarks")
            break
        end
    end
end

local function quickmarks_removeall()
    quickmarks = { "" }
    os.remove(quickmarks_f)
    print("Quickmark: All quickmarks removed")
end

local function quickmarks_save()
    table.save_file(quickmarks, quickmarks_f)
    print("Quickmark: quickmarks saved")
end

-- open file under cursor
local function open_file()
    local str = api.nvim_get_current_line()
    if #quickmarks < 1 or str == "" then -- list is empty
        window_utils.close_window()
        return
    end
    window_utils.close_window()
    api.nvim_command('edit ' .. str)
end

return {
    quickmarks_list = quickmarks_list,
    quickmark_add = quickmark_add,
    quickmark_remove = quickmark_remove,
    quickmarks_removeall = quickmarks_removeall,
    close_window = window_utils.close_window,
    move_cursor = window_utils.move_cursor,
    open_file = open_file,
    quickmarks_save = quickmarks_save,
}
