package.path = package.path .. ";./src/?.lua"
require "wasmer".load("bin/wasmer.dll")

local config = Config():set_compiler(Compiler.CRANELIFT)
local engine = Engine(config)
local store = Store(engine)

local module = Module(store, [[
    (module
        (func $add (export "add") (param $a i32) (param $b i32) (result i32)
            (i32.add (local.get $a) (local.get $b))
        )
    )
]])

local exports = module:exports();

print(exports:size())

return 1
