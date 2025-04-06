---@class Memory
---@field ptr userdata
local Memory = {}
Memory.__index = Memory

---@param ptr userdata
---@return Memory
function Memory.from_ptr(ptr)
    local self = setmetatable({}, Memory)
    self.ptr = ptr
    return self
end

return Memory
