local api = vim.api

local window_utils = require("quickmark.window_utils")
local utils = require("quickmark.utils")

-- array with all quickmarks
-- lua calls it table eww
-- it's ARRAY
local quickmarks = {}

local function display_quickmarks()
    for i = 0, #quickmarks do -- to get lenght of a "table" (ARRAY!!) we use #
        -- well thats very readable
        -- imma stay with c in the future
        local startl = i + 3 -- shift down lines
        local endl = startl + 1
        window_utils.print_to_buf(quickmarks[i], startl, endl)
    end
end

local function quickmarks_list()
    local win = window_utils.open_window()
    window_utils.print_to_buf(
        "Press q to exit",
        1, -1
    )
    window_utils.print_to_buf(
        utils.center_str("Quickmarks"),
        0, -1
    )

    -- separator line
    local bufid = vim.fn.bufwinid(win.buf)
    local bufw = vim.fn.winwidth(bufid)
    window_utils.print_to_buf(
        string.rep('─', bufw + 10), -- some extra lines
        2, -1
    )

    display_quickmarks()
    window_utils.set_mappings()
end

local function quickmark_add()
    local bufname = api.nvim_buf_get_name(0)

    -- if its empty don't add it
    if bufname == "" then
        vim.cmd [[
            echohl ErrorMsg
            echo "Quickmark: cannot add empty filename to quickmarks"
            echohl None
        ]]
        return
    end

    for i = 0, #quickmarks do
        if quickmarks[i] == bufname then
            vim.cmd [[
                echohl ErrorMsg
                echo "Quickmark: Quickmark already exists"
                echohl None
            ]]
            return
        end
    end

    table.insert(quickmarks, bufname)
    print(bufname .. " added")
end

return {
    quickmarks_list = quickmarks_list,
    quickmark_add = quickmark_add,
    close_window = window_utils.close_window
}
