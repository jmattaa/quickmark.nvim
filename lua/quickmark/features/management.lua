local constants = require("quickmark.constants")

local quickmarks_loaded_file = table.load_file(constants.quickmarks_f) or {{ constants.initial_msg }, {}}

local quickmarks = quickmarks_loaded_file[1]
local shortcuts = quickmarks_loaded_file[2]

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
        elseif quickmarks[i] == constants.initial_msg then -- remove the first initial empty string
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
    quickmarks = { constants.initial_msg }
    shortcuts = {}
    os.remove(constants.quickmarks_f)
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
    table.save_file({quickmarks, shortcuts}, constants.quickmarks_f)
    print("Quickmark: quickmarks saved")
end

return {
    quickmark_add = quickmark_add,
    quickmark_shortcut = quickmark_shortcut,
    quickmark_getShortcuts = quickmark_getShortcuts,
    quickmark_remove = quickmark_remove,
    quickmarks_removeall = quickmarks_removeall,
    quickmarks_save = quickmarks_save,
}
