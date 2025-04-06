local ffi = require "ffi"

---@class Value
---@field ptr { kind: integer, of: { i32: userdata, i64: userdata, f32: userdata, f64: userdata, ref: userdata } }
local Value = {}
Value.Type = {
    I32 = 0,
    I64 = 1,
    F32 = 2,
    F64 = 3,
    ExternRef = 128
}
Value.__index = Value

function Value.new(type, value)
    local self = setmetatable({}, Value)
    local wasm_value = ffi.new("wasm_val_t")
    wasm_value.kind = type
    if type == Value.Type.I32 then
        wasm_value.of.i32 = value
    elseif type == Value.Type.I64 then
        wasm_value.of.i64 = value
    elseif type == Value.Type.F32 then
        wasm_value.of.f32 = value
    elseif type == Value.Type.F64 then
        wasm_value.of.f64 = value
    elseif type == Value.Type.ExternRef then
        wasm_value.of.ref = ffi.NULL
    end
    self.ptr = wasm_value
    return self
end

---@param ptr userdata
function Value.from_ptr(ptr)
    local self = setmetatable({}, Value)
    self.ptr = ptr --[[@as { kind: integer, of: { i32: userdata, i64: userdata, f32: userdata, f64: userdata, ref: userdata } }]]
    return self
end

function Value:of()
    if self.ptr.kind == Value.Type.I32 then
        return tonumber(self.ptr.of.i32)
    elseif self.ptr.kind == Value.Type.I64 then
        return tonumber(self.ptr.of.i64)
    elseif self.ptr.kind == Value.Type.F32 then
        return tonumber(self.ptr.of.f32)
    elseif self.ptr.kind == Value.Type.F64 then
        return tonumber(self.ptr.of.f64)
    elseif self.ptr.kind == Value.Type.ExternRef then
        return self.ptr.of.ref
    else
        error("Unknown or unsupported type")
    end
end

return Value
