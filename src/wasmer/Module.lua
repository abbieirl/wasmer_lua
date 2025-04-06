local ffi = require "ffi"
local wat2wasm = require "wasmer.wat2wasm"
local Store = require "wasmer.Store"

---@class Module
---@field store Store
---@field ptr userdata
---@overload fun(store: Store, bytes: string): Module
local Module = {}
Module.__index = Module

---@param store Store
---@param bytes string
---@return Module
function Module.new(store, bytes)
    assert(store and getmetatable(store) == Store, "Expected store to be an instance of Store")
    assert(type(bytes) == "string", "Expected bytes to be a string.")

    local self = setmetatable({}, Module --[[@as Module]])

    self.store = store
    self.ptr = ffi.wasmer.wasm_module_new(self.store.ptr, wat2wasm(bytes).ptr)

    return self
end

---@return Imports
function Module:imports()
    local imports = Imports.new()
    ffi.wasmer.wasm_module_imports(self.ptr, imports.ptr)
    return imports
end

---@return Exports
function Module:exports()
    local exports = Exports.new()
    ffi.wasmer.wasm_module_exports(self.ptr, exports.ptr)
    return exports
end

---@private
---@param store Store
---@param bytes string
---@return Module
function Module.__call(_, store, bytes)
    return Module.new(store, bytes)
end

setmetatable(Module --[[@as Module]], Module --[[@as Module]])

return Module
