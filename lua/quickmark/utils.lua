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

return {
    center_str = center_str,
    get_key_fom_val = get_key_fom_val,
}
