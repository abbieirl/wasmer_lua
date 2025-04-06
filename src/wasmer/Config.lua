local ffi = require "ffi"

---@class Config
---@field ptr userdata
---@overload fun(): Config
local Config = {}
Config.__index = Config

---@return Config
function Config.new()
    local self = setmetatable({}, Config --[[@as Config]])

    self.ptr = ffi.wasmer.wasm_config_new()

    return self
end

---@param engine number
---@return Config
function Config:set_engine(engine)
    ffi.wasmer.wasm_config_set_engine(self.ptr, engine)
    self.engine = engine
    return self
end

---@param compiler Compiler
---@return Config
function Config:set_compiler(compiler)
    ffi.wasmer.wasm_config_set_compiler(self.ptr, compiler)
    self.compiler = compiler
    return self
end

---@param target Target
---@return Config
function Config:set_target(target)
    ffi.wasmer.wasm_config_set_target(self.ptr, target.ptr)
    self.target = target
    return self
end

---@private
---@return Config
function Config.__call()
    return Config.new()
end

setmetatable(Config --[[@as Config]], Config --[[@as Config]])

return Config
