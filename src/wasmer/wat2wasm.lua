local Bytes = require "wasmer.Bytes"
local ffi = require "ffi"

---@param wat string | Bytes
---@return Bytes
local function wat2wasm(wat)
    local watBytes = type(wat) == "string" and Bytes.new(wat) or wat
    local out = Bytes.new()
    ffi.wasmer.wat2wasm(watBytes.ptr, out.ptr)
    return out
end

return wat2wasm
