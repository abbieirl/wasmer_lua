local ffi = require "ffi"

---@class Bytes
---@field ptr userdata
local Bytes = {}
Bytes.__index = Bytes

---@overload fun(): Bytes
---@overload fun(bytes: string): Bytes
function Bytes.new(bytes)
    local self = setmetatable({}, Bytes)
    local byteVec = ffi.new("wasm_byte_vec_t")

    if bytes then
        local byteArray = ffi.new("wasm_byte_t[?]", #bytes, bytes)
        ffi.wasmer.wasm_byte_vec_new(byteVec, #bytes, byteArray)
    else
        ffi.wasmer.wasm_byte_vec_new_empty(byteVec)
    end

    self.ptr = byteVec

    return self
end

---@return number
function Bytes:size()
    ---@diagnostic disable-next-line
    return tonumber(self.ptr.size)
end

return Bytes
