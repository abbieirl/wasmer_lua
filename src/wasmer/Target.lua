local ffi = require "ffi"

---@class Target
---@field ptr userdata
local Target = {}
Target.__index = Target

---@param triple Triple
---@param features Features
---@return Target
function Target.new(triple, features)
    local self = setmetatable({}, Target)
    self.ptr = ffi.wasmer.wasmer_target_new(triple.ptr, features.ptr)
    return self
end

---@private
function Target:__gc()
    ffi.wasmer.wasmer_target_delete(self.ptr)
end

return Target
