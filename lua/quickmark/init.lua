local display = require("quickmark.features.display")
local management = require("quickmark.features.management")
local operations = require("quickmark.features.operations")
local window_utils = require("quickmark.window_utils")

return {
    quickmarks_list = display.quickmarks_list,
    quickmark_add = management.quickmark_add,
    quickmark_shortcut = management.quickmark_shortcut,
    quickmark_getShortcuts = management.quickmark_getShortcuts,
    quickmark_remove = management.quickmark_remove,
    quickmarks_removeall = management.quickmarks_removeall,
    quickmarks_save = management.quickmarks_save,
    close_window = window_utils.close_window,
    move_cursor = window_utils.move_cursor,
    move_file = operations.move_file,
    open_file = operations.open_file,
}
