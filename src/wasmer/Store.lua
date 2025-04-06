local ffi = require "ffi"
local Engine = require "wasmer.Engine"

---@class Store
---@field private engine Engine
---@field ptr userdata
---@overload fun(): Store
---@overload fun(engine: Engine): Store
local Store = {}
Store.__index = Store

---@param engine Engine
---@overload fun(): Store
---@overload fun(engine: Engine): Store
---@return Store
function Store.new(engine)
    if engine ~= nil and getmetatable(engine) ~= Engine then
        error("Expected engine to be an instance of Engine", 2)
    end

    local self = setmetatable({}, Store --[[@as Store]])

    self.engine = engine or Engine.new()
    self.ptr = ffi.wasmer.wasm_store_new(self.engine.ptr)

    return self
end

---Gets the `Engine` associated with this store.
---@return Engine
function Store:get_engine()
    return self.engine
end

---@private
---@param engine Engine
---@return Store
function Store.__call(_, engine)
    return Store.new(engine)
end

setmetatable(Store --[[@as Store]], Store --[[@as Store]])

return Store
