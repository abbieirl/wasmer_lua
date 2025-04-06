local ffi = require "ffi"
local Trap = require "wasmer.Trap"
local Message = require "wasmer.Message"
local Externs = require "wasmer.Externs"

---@class Instance
---@field public exports Externs
---@field private module Module
---@field ptr userdata
local Instance = {}
Instance.__index = Instance

---@overload fun(store: Store, module: Module): Instance
---@overload fun(store: Store, module: Module, imports: Imports): Instance
function Instance.new(store, module, imports)
    local self = setmetatable({}, Instance)

    imports = imports or Imports.new()
    local trap = Trap.new(store, Message.new())

    self.exports = Externs.new()
    self.module = module
    self.ptr = ffi.wasmer.wasm_instance_new(store.ptr, module.ptr, imports.ptr, trap.ptr)

    ffi.wasmer.wasm_instance_exports(self.ptr, self.exports.ptr)

    return self
end

---Gets the `Module` associated with this instance.
---@return Module
function Instance:get_module()
    return self.module
end

return Instance
