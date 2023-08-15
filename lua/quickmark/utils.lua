local api = vim.api

local function center_str(str)
    local width = api.nvim_win_get_width(0)
    local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
    return string.rep(' ', shift) .. str
end

local function get_key_fom_val(t, val)
   local s={}
   for k,v in pairs(t) do
     s[v]=k
   end
   return s[val]
end

local function file_exists(name)
   local f = io.open(name, "r")
   return f ~= nil and io.close(f)
end

function table.serialize(tbl)
    local str = "{"
    for k, v in pairs(tbl) do
        str = str .. "[" .. tostring(k) .. "]=" .. "\"" .. tostring(v) .. "\","
    end
    str = str .. "}"
    return str
end

-- Save a table to a file
function table.save_file(tbl, filename)
    local serializedTable = table.serialize(tbl)
    local file = io.open(filename, "w")
    if file == nil then
        return
    else
        file:write(serializedTable)
        file:close()
    end
end

-- Load a table from a file
function table.load_file(filename)
    local file = io.open(filename, "r")
    if file then
        local serializedTable = file:read("*a")
        file:close()
        local loadedTable = load("return " .. serializedTable)()
        return loadedTable
    else
        return nil
    end
end


return {
    center_str = center_str,
    get_key_fom_val = get_key_fom_val,
    file_exists = file_exists,
}
