local ffi = require "ffi"
local Extern = require "wasmer.Extern"

---A collection of externs.
---@class Externs
---@field ptr { size: userdata, data: userdata }
local Externs = {}

---@return Externs
function Externs.new()
    local self = setmetatable({}, Externs)
    local externVec = ffi.new("wasm_extern_vec_t")
    ffi.wasmer.wasm_extern_vec_new_empty(externVec)
    self.ptr = externVec
    return self
end

---@return number
function Externs:size()
    return tonumber(self.ptr.size) --[[@as number]]
end

function Externs:__index(index)
    ---Method indexing
    if type(index) == "string" then
        return Externs[index]
    end

    ---Array indexing
    if type(index) == "number" and index > 0 and index <= self:size() then
        return Extern.from_ptr(ffi.cast("wasm_extern_t**", self.ptr.data)[index - 1])
    end

    return nil
end

return Externs
