local ffi = require "ffi"

---@class Triple
---@field ptr userdata
local Triple = {}
Triple.__index = Triple

---@param name Name
---@return Triple
function Triple.new(name)
    local self = setmetatable({}, Triple)
    self.ptr = ffi.wasmer.wasmer_triple_new(name.ptr)
    return self
end

---@private
function Triple:__gc()
    ffi.wasmer.wasmer_triple_delete(self.ptr)
end

return Triple
