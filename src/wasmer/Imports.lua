local ffi = require "ffi"

---A collection of imports.
---@class Imports
---@field ptr userdata
local Imports = {}
Imports.__index = Imports

---@return Imports
function Imports.new()
    local self = setmetatable({}, Imports)
    local externVec = ffi.new("wasm_extern_vec_t")
    ffi.wasmer.wasm_extern_vec_new_empty(externVec)
    self.ptr = externVec
    return self
end

---@return number
function Imports:size()
    ---@diagnostic disable-next-line
    return tonumber(self.ptr.size)
end

return Imports
