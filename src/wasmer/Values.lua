local ffi = require "ffi"

---@class Values
---@field ptr { size: userdata, data: userdata }
local Values = {}

---@overload fun(): Values
---@overload fun(values: Value[]): Values
function Values.new(values)
    local self = setmetatable({}, Values)
    local valVec = ffi.new("wasm_val_vec_t")

    if values then
        local valArray = ffi.new("wasm_val_t[?]", #values, values)
        ffi.wasmer.wasm_val_vec_new(valVec, #values, valArray)
    else
        ffi.wasmer.wasm_val_vec_new_empty(valVec)
    end

    self.ptr = valVec

    return self
end

function Values:size()
    return tonumber(self.ptr.size)
end

function Values:__index(index)
    ---Method indexing
    if type(index) == "string" then
        return Values[index]
    end

    ---Array indexing
    if type(index) == "number" and index > 0 and index <= self:size() then
        return Value.from_ptr(ffi.cast("wasm_val_t**", self.ptr.data)[index - 1])
    end

    return nil
end

return Values
