local ffi = require("ffi")

---A collection of exports.
---@class Exports
---@field ptr userdata
local Exports = {}
Exports.__index = Exports

---@return Exports
function Exports.new()
    local self = setmetatable({}, Exports)
    local exportTypeVec = ffi.new("wasm_exporttype_vec_t")
    ffi.wasmer.wasm_exporttype_vec_new_empty(exportTypeVec)
    self.ptr = exportTypeVec
    return self
end

---@param name string
function Exports:get(name)
    
end

---@return number
function Exports:size()
    ---@diagnostic disable-next-line
    return tonumber(self.ptr.size)
end

function Exports:__index(index)
    ---Method indexing
    if type(index) == "string" then
        return Exports[index]
    end

    ---Array indexing
    if type(index) == "number" and index > 0 and index <= self:size() then
        return nil -- TODO
    end

    return nil
end

return Exports
