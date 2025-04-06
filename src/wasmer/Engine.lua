local ffi = require "ffi"
local Config = require "wasmer.Config"

---@class Engine
---@field config Config?
---@field ptr userdata
---@field UNIVERSAL number
---@overload fun(): Engine
---@overload fun(config: Config): Engine
local Engine = { UNIVERSAL = 0 }
Engine.__index = Engine

---@overload fun(): Engine
---@overload fun(config: Config): Engine
---@return Engine
function Engine.new(config)
    if config ~= nil and getmetatable(config) ~= Config then
        error("Expected config to be an instance of Config", 2)
    end

    local self = setmetatable({}, Engine --[[@as Engine]])

    self.config = config
    self.ptr = self.config and ffi.wasmer.wasm_engine_new_with_config(self.config.ptr) or ffi.wasmer.wasm_engine_new()

    return self
end

---@private
---@param config Config
---@return Engine
function Engine.__call(_, config)
    return Engine.new(config)
end

setmetatable(Engine --[[@as Engine]], Engine --[[@as Engine]])

return Engine
