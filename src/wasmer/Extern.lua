local ffi = require "ffi"
local Function = require "wasmer.Function"
local Table = require "wasmer.Table"
local Global = require "wasmer.Global"
local Memory = require "wasmer.Memory"

---@class Extern
---@field ptr userdata
local Extern = {}
Extern.__index = Extern

---@param ptr userdata
---@return Extern
function Extern.from_ptr(ptr)
    local self = setmetatable({}, Extern)
    self.ptr = ptr
    return self
end

---@return Function
function Extern:as_function()
    return Function.from_ptr(ffi.wasmer.wasm_extern_as_func(self.ptr))
end

---@return Table
function Extern:as_table()
    return Table.from_ptr(ffi.wasmer.wasm_extern_as_table(self.ptr))
end

---@return Global
function Extern:as_global()
    return Global.from_ptr(ffi.wasmer.wasm_extern_as_global(self.ptr))
end

---@return Memory
function Extern:as_memory()
    return Memory.from_ptr(ffi.wasmer.wasm_extern_as_memory(self.ptr))
end

return Extern
