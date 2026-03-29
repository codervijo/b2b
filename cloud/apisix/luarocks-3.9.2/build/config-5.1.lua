-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = home .. "/.luarocks" };
   { name = "system", root = "/usr/src/app/luarocks-3.9.2/foorock" };
}
lua_interpreter = "lua5.1";
variables = {
   LUA_DIR = "/usr";
   LUA_BINDIR = "/usr/bin";
}
