---@class Global
---@field ptr userdata
local Global = {}
Global.__index = Global

---@param ptr userdata
---@return Global
function Global.from_ptr(ptr)
    local self = setmetatable({}, Global)
    self.ptr = ptr
    return self
end

return Global
