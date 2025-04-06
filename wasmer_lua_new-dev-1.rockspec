rockspec_format = "3.0"
package = "wasmer_lua_new"
version = "dev-1"
source = {
   url = "*** TODO ***",
}
description = {
   homepage = "*** TODO ***",
   license = "MIT",
}
dependencies = {
   "lua >= 5.1",
}
build = {
   type = "builtin",
   modules = {
      ["wasmer"] = "src/wasmer.lua",
      ["wasmer.Bytes"] = "src/wasmer/Bytes.lua",
      ["wasmer.Compiler"] = "src/wasmer/Compiler.lua",
      ["wasmer.Config"] = "src/wasmer/Config.lua",
      ["wasmer.Engine"] = "src/wasmer/Engine.lua",
      ["wasmer.Features"] = "src/wasmer/Features.lua",
      ["wasmer.Name"] = "src/wasmer/Name.lua",
      ["wasmer.Target"] = "src/wasmer/Target.lua",
      ["wasmer.Triple"] = "src/wasmer/Triple.lua",
      ["wasmer.wat2wasm"] = "src/wasmer/wat2wasm.lua",
   }
}
test = {
   type = "command",
   command = "luajit tests/test.lua",
}
