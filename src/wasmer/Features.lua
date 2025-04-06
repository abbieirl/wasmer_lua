local ffi = require "ffi"

---@class Features
---@field ptr userdata
local Features = {}
Features.__index = Features

---@return Features
function Features.new()
    local self = setmetatable({}, Features)
    self.ptr = ffi.wasmer.wasmer_cpu_features_new()
    return self
end

---@param feature Name
function Features:add(feature)
    ffi.wasmer.wasmer_cpu_features_add(self.ptr, feature.ptr)
end

---@private
function Features:__gc()
    ffi.wasmer.wasmer_cpu_features_delete(self.ptr)
end

return Features
