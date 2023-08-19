local mappings = require("quickmark.mappings")

local api = vim.api
local buf
local win

local width = api.nvim_get_option("columns")
local height = api.nvim_get_option("lines")

local win_height = math.ceil(height * 0.4 - 4)
local win_width = math.ceil(width * 0.7)

local function open_window()
    if win ~= nil then -- if there is an already open window we jusst return nil
        return nil
    end

    -- create emtpy buffer for the window
    buf = api.nvim_create_buf(false, true)
    local border_buf = api.nvim_create_buf(false, true) -- create the border

    api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    -- starting position center
    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width) / 2)

    -- set some options
    local opts = {
        style = "minimal",
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col
    }

    -- add border
    local border_opts = {
        style = "minimal",
        relative = "editor",
        width = win_width + 2,
        height = win_height + 2,
        row = row - 1,
        col = col - 1
    }
    local border_lines = { '╭' .. string.rep('─', win_width) .. '╮' }
    local middle_line = '│' .. string.rep(' ', win_width) .. '│'
    -- go until before searchbar height
    for i = 1, win_height do
        table.insert(border_lines, middle_line)
    end
    table.insert(border_lines, '╰' .. string.rep('─', win_width) .. '╯')
    api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

    -- show the border win
    api.nvim_open_win(border_buf, true, border_opts)

    -- and finally create it with buffer attached
    win = api.nvim_open_win(buf, true, opts)
    api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! "' .. border_buf)

    return { win = win, buf = buf }
end

local function close_window()
    api.nvim_win_close(win, true)
    buf = nil
    win = nil
end

-- startl starting line index
-- endl ending line index -1 for last line
-- u see i read docs
local function print_to_buf(str, startl, endl)
    api.nvim_buf_set_lines(
        buf,
        startl,
        endl,
        false,
        { str }
    )
end

local function move_cursor(dir)
    local new_pos = api.nvim_win_get_cursor(win)[1] + dir
    if vim.fn.line("$") < 4 then -- list empty don't move cursor
        new_pos = 1              -- for some reason 1 is the first not 0
    else                         -- list not empty cursor first line is 3
        if new_pos >= vim.fn.line("$") then
            new_pos = vim.fn.line("$")
        elseif new_pos < 4 then
            new_pos = 4
        end
    end

    api.nvim_win_set_cursor(win, { new_pos, 0 })
end

local function set_mappings()
    -- remove the function of all the chars
    -- so we only use ours
    local other_chars = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
        's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' '
    }

    for _, v in ipairs(other_chars) do
        api.nvim_buf_set_keymap(buf, 'n', v, '', { nowait = true, noremap = true, silent = true })
        api.nvim_buf_set_keymap(buf, 'n', v:upper(), '', { nowait = true, noremap = true, silent = true })
        api.nvim_buf_set_keymap(buf, 'n', '<c-' .. v .. '>', '', { nowait = true, noremap = true, silent = true })
    end
    for k, v in pairs(mappings.mappings) do
        api.nvim_buf_set_keymap(buf, 'n', k, ':lua require\'quickmark\'.' .. v .. '<cr>', {
            nowait = true, noremap = true, silent = true
        })
    end
end
return {
    open_window = open_window,
    close_window = close_window,
    move_cursor = move_cursor,
    print_to_buf = print_to_buf,
    set_mappings = set_mappings,
    win = win,
    buf = buf,
    win_width = win_width,
    win_height = win_height,
    mappings = mappings,
}
