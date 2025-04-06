---@class Table
---@field ptr userdata
local Table = {}
Table.__index = Table

---@param ptr userdata
---@return Table
function Table.from_ptr(ptr)
    local self = setmetatable({}, Table)
    self.ptr = ptr
    return self
end

return Table
