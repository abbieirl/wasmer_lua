local ffi = require "ffi"

ffi.cdef [[
    struct wasm_ref_t;

    typedef uint8_t wasm_valkind_t;

    typedef struct wasm_val_t {
        wasm_valkind_t kind;
        union {
          int32_t i32;
          int64_t i64;
          float f32;
          double f64;
          struct wasm_ref_t* ref;
        } of;
      } wasm_val_t;

    typedef struct wasm_val_vec_t {
        size_t size;
        wasm_val_t* data;
    } wasm_val_vec_t;

    void wasm_val_vec_new(wasm_val_vec_t* out, size_t size, wasm_val_t* ptr);
    void wasm_val_vec_new_empty(wasm_val_vec_t* out);
    void wasm_val_vec_new_uninitialized(wasm_val_vec_t* out);

    typedef struct wasm_func_t wasm_func_t;

    void wasm_func_call(wasm_func_t* func, wasm_val_vec_t* args, wasm_val_vec_t* results);
]]

ffi.cdef [[
    typedef uint8_t wasm_byte_t;
    typedef struct  wasm_byte_vec_t {
        size_t size;
        wasm_byte_t* data;
    } wasm_byte_vec_t;
    typedef wasm_byte_vec_t wasm_name_t;

    wasm_byte_vec_t* wasm_byte_vec_new(wasm_byte_vec_t* out, size_t size, wasm_byte_t* ptr);
    void             wasm_byte_vec_new_empty(wasm_byte_vec_t* out);
    void             wasm_byte_vec_delete(wasm_byte_vec_t* out);
]]

ffi.cdef [[
    typedef enum wasm_compiler_t {
        CRANELIFT = 0,
        LLVM = 1,
        SINGLEPASS = 2,
    } wasm_compiler_t;
]]

ffi.cdef [[
    typedef struct wasmer_target_t wasmer_target_t;
]]

ffi.cdef [[
    typedef wasm_byte_vec_t wasm_message_t;
]]

ffi.cdef [[
    typedef struct wasm_extern_t wasm_extern_t;
    typedef struct wasm_extern_vec_t {
        size_t size;
        wasm_extern_t* data;
    } wasm_extern_vec_t;

    void wasm_extern_as_func(wasm_extern_t* extern_t);
    void wasm_extern_as_table(wasm_extern_t* extern_t);
    void wasm_extern_as_global(wasm_extern_t* extern_t);
    void wasm_extern_as_memory(wasm_extern_t* extern_t);

    void wasm_extern_vec_new(wasm_extern_vec_t* out, size_t size, wasm_extern_t* ptr);
    void wasm_extern_vec_new_empty(wasm_extern_vec_t* out);
    void wasm_extern_vec_delete(wasm_extern_vec_t* out);
]]

ffi.cdef [[
    typedef enum wasmer_engine_t {
        WASMER_ENGINE_UNIVERSAL = 0
    } wasmer_engine_t;

    typedef struct wasm_config_t wasm_config_t;

    wasm_config_t* wasm_config_new();
    void           wasm_config_set_engine(wasm_config_t* config, wasmer_engine_t engine);
    void           wasm_config_set_compiler(wasm_config_t* config, wasm_compiler_t compiler);
    void           wasm_config_set_target(wasm_config_t* config, wasmer_target_t* target);
    void           wasm_config_delete(wasm_config_t* config);
]]

ffi.cdef [[
    typedef struct wasm_exporttype_t wasm_exporttype_t;
    typedef struct wasm_exporttype_vec_t {
        size_t size;
        wasm_exporttype_t* data;
    } wasm_exporttype_vec_t;

    void wasm_exporttype_vec_new(wasm_exporttype_vec_t* out, size_t size, wasm_exporttype_t* ptr);
    void wasm_exporttype_vec_new_empty(wasm_exporttype_vec_t out);
]]

ffi.cdef [[
    typedef struct wasm_engine_t wasm_engine_t;

    wasm_engine_t* wasm_engine_new();
    wasm_engine_t* wasm_engine_new_with_config(wasm_config_t* config);
    void           wasm_engine_delete(wasm_engine_t* engine);
]]

ffi.cdef [[
    typedef struct wasm_store_t wasm_store_t;

    wasm_store_t*  wasm_store_new(wasm_engine_t* engine);
    void           wasm_store_delete(wasm_store_t* store);
]]

ffi.cdef [[
    typedef struct wasm_trap_t wasm_trap_t;

    wasm_trap_t*   wasm_trap_new(wasm_store_t* store, wasm_message_t* message);
    void           wasm_trap_delete(wasm_trap_t* trap);
]]

ffi.cdef [[
    typedef struct wasm_module_t wasm_module_t;

    wasm_module_t* wasm_module_new(wasm_store_t* store, wasm_byte_vec_t* bytes);
    void           wasm_module_imports(wasm_module_t* module, wasm_exporttype_vec_t* out);
    void           wasm_module_exports(wasm_module_t* module, wasm_exporttype_vec_t* out);
    void           wasm_module_delete(wasm_module_t* module);
]]

ffi.cdef [[
    typedef struct   wasm_instance_t wasm_instance_t;

    wasm_instance_t* wasm_instance_new(wasm_store_t* store, wasm_module_t* module, wasm_extern_vec_t* imports, wasm_trap_t* trap);
    void             wasm_instance_exports(wasm_instance_t* instance, wasm_extern_vec_t* out);
    void             wasm_instance_delete(wasm_instance_t* instance);
]]

ffi.cdef [[
    typedef struct wasmer_cpu_features_t wasmer_cpu_features_t;

    wasmer_cpu_features_t* wasmer_cpu_features_new();
    bool                   wasmer_cpu_features_add(wasmer_cpu_features_t* cpu_features, wasm_name_t* feature);
    void                   wasmer_cpu_features_delete(wasmer_cpu_features_t* cpu_features);
]]

ffi.cdef [[
    typedef struct wasmer_triple_t wasmer_triple_t;

    wasmer_triple_t* wasmer_triple_new(wasm_name_t* triple);
    void             wasmer_triple_delete(wasmer_triple_t* triple);
]]

ffi.cdef [[
    void wat2wasm(wasm_byte_vec_t* wat, wasm_byte_vec_t* out);
]]

---@param path string
function load(path)
    ---@class wasmer
    --
    ---@field wasm_byte_vec_new fun(byte_vec: userdata, size: integer, byte: userdata)
    ---@field wasm_byte_vec_new_empty fun(out: userdata)
    ---@field wasm_byte_vec_delete fun(out: userdata)
    --
    ---@field wasm_config_new fun(): userdata
    ---@field wasm_config_set_engine fun(config: userdata, engine: number)
    ---@field wasm_config_set_compiler fun(config: userdata, compiler: number)
    ---@field wasm_config_set_target fun(config: userdata, target: userdata)
    ---@field wasm_config_delete fun(config: userdata)
    --
    ---@field wasm_engine_new fun(): userdata
    ---@field wasm_engine_new_with_config fun(config: userdata): userdata
    ---@field wasm_engine_delete fun(engine: userdata)
    --
    ---@field wasm_store_new fun(engine: userdata): userdata
    ---@field wasm_store_delete fun(store: userdata)
    --
    ---@field wasm_module_new fun(store: userdata, bytes: userdata): userdata
    ---@field wasm_module_imports fun(module: userdata, out: userdata)
    ---@field wasm_module_exports fun(module: userdata, out: userdata)
    ---@field wasm_module_delete fun(module: userdata)
    --
    ---@field wasm_instance_new fun(store: userdata, module: userdata, imports: userdata, trap: userdata)
    ---@field wasm_instance_exports fun(instance: userdata, out: userdata)
    ---@field wasm_instance_delete fun()
    --
    ---@field wasm_exporttype_vec_new fun(out: userdata, size: integer, ptr: userdata)
    ---@field wasm_exporttype_vec_new_empty fun(out: userdata)
    --
    ---@field wasmer_cpu_features_new fun(): userdata
    ---@field wasmer_cpu_features_add fun(cpu_features: userdata, feature: userdata): boolean
    ---@field wasmer_cpu_features_delete fun(cpu_features: userdata)
    --
    ---@field wasmer_triple_new fun(triple: userdata): userdata
    ---@field wasmer_triple_delete fun(triple: userdata)
    --
    ---@field wasm_trap_new fun(store: userdata, message: userdata)
    ---@field wasm_trap_delete fun(trap: userdata)
    --
    ---@field wasm_extern_vec_new fun(out: userdata, size: number, ptr: userdata)
    ---@field wasm_extern_vec_new_empty fun(out: userdata)
    ---@field wasm_extern_vec_delete fun(out: userdata)
    --
    ---@field wasm_extern_as_func fun(extern: userdata): userdata
    ---@field wasm_extern_as_table fun(extern: userdata): userdata
    ---@field wasm_extern_as_global fun(extern: userdata): userdata
    ---@field wasm_extern_as_memory fun(extern: userdata): userdata
    --
    ---@field wat2wasm fun(wat: userdata, out: userdata)

    ---@class ffi.wasmer: wasmer

    ffi.wasmer = ffi.load(path)

    local wasmer = {
        Bytes = require "wasmer.Bytes",
        Compiler = require "wasmer.Compiler",
        Config = require "wasmer.Config",
        Engine = require "wasmer.Engine",
        Externs = require "wasmer.Externs",
        Features = require "wasmer.Features",
        Imports = require "wasmer.Imports",
        Exports = require "wasmer.Exports",
        Instance = require "wasmer.Instance",
        Module = require "wasmer.Module",
        Name = require "wasmer.Name",
        Store = require "wasmer.Store",
        Target = require "wasmer.Target",
        Triple = require "wasmer.Triple",
        Value = require "wasmer.Value",
        Values = require "wasmer.Values",
        wat2wasm = require "wasmer.wat2wasm",
    }

    _G.Bytes = wasmer.Bytes
    _G.Compiler = wasmer.Compiler
    _G.Config = wasmer.Config
    _G.Engine = wasmer.Engine
    _G.Store = wasmer.Store
    _G.Module = wasmer.Module
    _G.Imports = wasmer.Imports
    _G.Exports = wasmer.Exports
    _G.Instance = wasmer.Instance
    _G.Value = wasmer.Value
    _G.Values = wasmer.Values

    return wasmer
end

-- for name, module in pairs(wasmer) do
--     _G[name] = module
-- end

return { load = load }
