local window_utils = require("quickmark.window_utils")

local api = vim.api

local function center_str(str)
    local width = api.nvim_win_get_width(0)
    local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
    return string.rep(' ', shift) .. str
end

return {
    center_str = center_str,
}
