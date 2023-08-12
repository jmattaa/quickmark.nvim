local api = vim.api
local buf
local win

local function open_window()
    -- create emtpy buffer for the window
    buf = api.nvim_create_buf(false, true)
    local border_buf = api.nvim_create_buf(false, true) -- create the border

    api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    local width = api.nvim_get_option("columns")
    local height = api.nvim_get_option("lines")

    local win_height = math.ceil(height * 0.4 - 4)
    local win_width = math.ceil(width * 0.4)

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

local function set_mappings()
    local mappings = {
        q = "close_window()"
    }

    for k, v in pairs(mappings) do
        api.nvim_buf_set_keymap(buf, 'n', k, ':lua require\'quickmark\'.' .. v .. '<cr>', {
            nowait = true, noremap = true, silent = true
        })
    end
end
return {
    open_window = open_window,
    close_window = close_window,
    print_to_buf = print_to_buf,
    set_mappings = set_mappings,
    win = win,
    buf = buf
}
